Message-ID: <A109131318C4D1119AC20060088DECE330F4A2@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: diekema@bucks.si.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Software Emulation Kernel Panic--specific information
Date: Wed, 21 Jun 2000 14:52:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We came across this before and got all excited until we looked at our mask
revision (3H97G) and searched through the errata. That particular errata is
no longer listed (I thought, though,it is CPU6, not CPU5). There is a fix
(or workaround) for CPU6 in the Montavista kernel. So far that hasn't fixed
our problem, though.

Thanks for all your ideas.

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.


-----Original Message-----
From: diekema@bucks.si.com [mailto:diekema@bucks.si.com]
Sent: Wednesday, June 21, 2000 2:29 PM
To: lucsch@adaptivemicro.com
Subject: Re: Software Emulation Kernel Panic--specific information


This should help...

>From wd@denx.de Sat Feb 26 19:57:50 2000
Return-Path: <wd@denx.de>
Received: from checkers.si.com([126.1.8.254]) (6026 bytes) by bucks.si.com
	via sendmail with P:esmtp/D:user/T:local
	(sender: <wd@denx.de> owner: <real-diekema>)
	id <m12Os1t-001SwhC@bucks.si.com>
	for <diekema@bucks.si.com>; Sat, 26 Feb 2000 19:57:49 -0500 (EST)
	(Smail-3.2.0.111 2000-Feb-17 #1 built 2000-Feb-25)
Received: from challenger.si.com (unverified) by checkers.si.com
 (Content Technologies SMTPRS 2.0.15) with SMTP id
<B0000916151@checkers.si.com> for <diekema@bucks.si.com>;
 Sat, 26 Feb 2000 20:00:15 -0500
Received: by challenger.si.com; id TAA08911; Sat, 26 Feb 2000 19:57:42 -0500
(EST)
Received: from unknown(195.30.0.14) by challenger.si.com via smap (V5.5)
	id xma008900; Sat, 26 Feb 00 19:56:44 -0500
Received: (qmail 13206 invoked from network); 27 Feb 2000 00:56:42 -0000
Received: from denx.muc.de (193.149.49.53)
  by popmail.space.net with SMTP; 27 Feb 2000 00:56:42 -0000
Received: from denx.local.net (IDENT:root@denx.local.net [10.0.0.2])
	by denx.muc.de (8.9.3/8.9.3) with ESMTP id BAA25238
	for <diekema@bucks.si.com>; Sun, 27 Feb 2000 01:59:03 +0100
Received: from denx.local.net (IDENT:wd@localhost [127.0.0.1])
	by denx.local.net (8.9.3/8.9.3) with ESMTP id BAA21111
	for <diekema@bucks.si.com>; Sun, 27 Feb 2000 01:56:38 +0100
Message-Id: <200002270056.BAA21111@denx.local.net>
To: diekema@bucks.si.com (diekema_jon)
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 27.75.228.193 vs. 207.75.228.193: I think I found the problem
X-Mailer: exmh version 1.6.4 10/10/1995
MIME-Version: 1.0
In-Reply-To: Your message of "Sat, 26 Feb 2000 17:45:40 EST."
             <m12Opy0-001SwhC@bucks>
Date: Sun, 27 Feb 2000 01:56:38 +0100
Sender: wd@denx.de
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Content-Length: 4445
X-Status:
X-Keywords:
X-UID: 60
Status: OR

On the other hand, while this obviously was  the  immediate  problem,
I'm not sure if you now will be much luckier. These other crashes are
not explained by the bad IP address.

And I have similar problems when running  a  more  extensive  set  of
tests on my module. Problems which look very familiar to me... :-(

I'm reading a Microprocessor Mask Set of 0160 in my IMMR - which is a
bit strange, since it  is  not  listed  in  the  Motorola  docs  (for
instance http://www.mot.com/SPS/RISC/netcomm/docs/pubs/860.html); but
the  printing  on  the  chip reads "XPC860TZP50B5", which indicates a
B.5/3J21M  mask  -   and   the   errata   sheet   (MPC860err.pdf   on
http://www.mot.com/SPS/RISC/netcomm/support/index.html)   still  con-
tains the CPU Bug #5: "Possible Data Cache  Corruption  When  Writing
SPR's".

This is a known problem, and it will KILL you during context switches
and/or interrupts with any OS which uses the MMU with virtual  memory
- including Linux.

Please check your CPU - I'm afraid that TQ shipped you old CPU,  too.
If this should be the case you need to get a replacement, because you
will  never  be  able to run a normal Linux with full speed on such a
system. [As a workaround and for verification that this is indeed the
problem,  you  can  disable  the   data   cache   -   please   modify
arch/ppc/kernel/head.S as follows:

--- arch/ppc/kernel/head.S.OLD	Tue Feb 15 01:10:40 2000
+++ arch/ppc/kernel/head.S	Sun Feb 27 01:49:16 2000
@@ -425,14 +425,6 @@
 	mtspr	IC_CST, r8
 #if 0
 	mtspr	DC_CST, r8
-#else
-	/* For a debug option, I left this here to easily enable
-	 * the write through cache mode
-	 */
-	lis	r8, DC_SFWT@h
-	mtspr	DC_CST, r8
-	lis	r8, IDC_ENABLE@h
-	mtspr	DC_CST, r8
 #endif

 /* We now have the lower 8 Meg mapped into TLB entries, and the caches


This will completely disable the data cache. You system will be a bit
slower than normal, but it should not crash any more.]


Seems we found both a software bug *and* a hardware problem :-(

I'm sorry, but I don't have any better news for you.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In C we had to code our own bugs, in C++ we can inherit them.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
