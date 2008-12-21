Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8EE7BDDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 20:40:29 +1100 (EST)
Subject: Re: Commits added to powerpc.git next and master branches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <1229851937.13001.57.camel@pasglop>
References: <18765.58426.49381.986612@cargo.ozlabs.ibm.com>
	<fa686aa40812210107o3d12d42q2e6b0265810f7b77@mail.gmail.com>
	<1229851937.13001.57.camel@pasglop>
Content-Type: text/plain
Date: Sun, 21 Dec 2008 20:40:23 +1100
Message-Id: <1229852423.13001.58.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-12-21 at 20:32 +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2008-12-21 at 02:07 -0700, Grant Likely wrote:
> > Hey Paul,
> > 
> > Top of your -next tree fails with a stack overflow on the MPC5200 when
> > attempting to mount an NFS rootfs (log below).  I haven't had a chance
> > to bisect yet, but I'm posting this in case someone has already seen
> > and solved this.
> 
> >From the NIP & LR values, it looks like it could be my fault.
> 
> MPC5200 is a 603 core right ?

Looks like a brown paper bag for me.

Try this:

Index: linux-work/arch/powerpc/mm/hash_low_32.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_low_32.S	2008-12-21 20:38:10.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_low_32.S	2008-12-21 20:38:14.000000000 +1100
@@ -709,3 +709,4 @@ _GLOBAL(_tlbia)
 	tlbia
 	sync
 #endif /* CONFIG_SMP */
+	blr
