Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 287301A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 10:18:00 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 4 Sep 2014 18:17:57 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8A7531FF003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 18:17:52 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s850HrD028508184
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 02:17:53 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s850MImN031728
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Sep 2014 18:22:18 -0600
Date: Thu, 4 Sep 2014 17:17:51 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140905001751.GL5001@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <21512.10628.412205.873477@gargle.gargle.HOWL>
 <20140904090952.GW17454@tucnak.redhat.com>
 <540859EC.5000407@hurleysoftware.com>
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>
 <5408C0AB.6050801@hurleysoftware.com> <5408E4A3.2060303@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5408E4A3.2060303@zytor.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Peter Hurley <peter@hurleysoftware.com>,
 Mikael Pettersson <mikpelinux@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2014 at 03:16:03PM -0700, H. Peter Anvin wrote:
> On 09/04/2014 12:42 PM, Peter Hurley wrote:
> > 
> > Or we could give up on the Alpha.
> > 
> 
> If Alpha is turning into Voyager (kept alive only as a museum piece, but
> actively causing problems) then please let's kill it.

Sorry for being slow to join this thread, but I propose the following
patch.  If we can remove support for all CPUs that to not support
direct access to bytes and shorts (which I would very much like to
see happen), I will remove the last non-guarantee.

							Thanx, Paul

------------------------------------------------------------------------

documentation: Record limitations of bitfields and small variables

This commit documents the fact that it is not safe to use bitfields
as shared variables in synchronization algorithms.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 87be0a8a78de..a28bfe4fd759 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -269,6 +269,26 @@ And there are a number of things that _must_ or _must_not_ be assumed:
 	STORE *(A + 4) = Y; STORE *A = X;
 	STORE {*A, *(A + 4) } = {X, Y};
 
+And there are anti-guarantees:
+
+ (*) These guarantees do not apply to bitfields, because compilers often
+     generate code to modify these using non-atomic read-modify-write
+     sequences.  Do not attempt to use bitfields to synchronize parallel
+     algorithms.
+
+ (*) Even in cases where bitfields are protected by locks, all fields
+     in a given bitfield must be protected by one lock.  If two fields
+     in a given bitfield are protected by different locks, the compiler's
+     non-atomic read-modify-write sequences can cause an update to one
+     field to corrupt the value of an adjacent field.
+
+ (*) These guarantees apply only to properly aligned and sized scalar
+     variables.  "Properly sized" currently means "int" and "long",
+     because some CPU families do not support loads and stores of
+     other sizes.  ("Some CPU families" is currently believed to
+     be only Alpha 21064.  If this is actually the case, a different
+     non-guarantee is likely to be formulated.)
+
 
 =========================
 WHAT ARE MEMORY BARRIERS?
