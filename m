Date: Wed, 11 Apr 2001 21:00:21 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] gettimeofday stability
Message-ID: <20010411210021.A4894@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'd like to suggest the following modification of do_gettimeofday():


===== time.c 1.8 vs edited =====
--- 1.8/arch/ppc/kernel/time.c  Mon Apr  2 03:36:42 2001
+++ edited/time.c       Wed Apr 11 20:38:42 2001
@@ -212,6 +212,10 @@
        sec = xtime.tv_sec;
        usec = xtime.tv_usec;
        delta = tb_ticks_since(tb_last_stamp);
+
+       if( (int)delta < 0 )
+               delta = 0;
+
 #ifdef CONFIG_SMP
        /* As long as timebases are not in sync, gettimeofday can only
         * have jiffy resolution on SMP.


Normally, delta should be strictly positive. However, if
coherency between DEC and TB is lost, then delta might turn
out to be (slightly) negative, which results in a
bogus time stamp.

The main reason why I want this modification is that MOL
touches both DEC and TB. I've not managed to maintain
exact coherency (appears to be more or less impossible).
The fix above would guard against an occasional drift.

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
