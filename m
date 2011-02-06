Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95285B711B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 10:50:19 +1100 (EST)
Subject: RE: [PATCH] e500: Erratum cpu a005 workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Yu-B13201 <B13201@freescale.com>
In-Reply-To: <FBDE6FBB4662C043AC9EECB95F62CDDE114038@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1295935333-13045-1-git-send-email-yu.liu@freescale.com>
	<5DA54AEE-B8AC-452B-A56C-65B35391A97C@freescale.com>
	<FBDE6FBB4662C043AC9EECB95F62CDDE114038@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 10:49:15 +1100
Message-ID: <1297036155.14982.19.camel@pasglop>
Mime-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > 
> > This isn't the way to do this.  We normally add entries in 
> > cputable.c an add a new cpu_feature_bit for the errata.
> > 
> > Than above we'd do:
> > 
> > if (cur_cpu_spec->cpu_features & CPU_FTR_E500_A005_ERRATUM)
> > 
> > 
> 
> IMHO, a cpu erratum is not a cpu feature.
> See there're only 32 bits can be used for all PowerPC platform to represent cpu feature, 
> then is it worth consuming one of them to represent one e500 erratum?

This is an interesting debate :-)

We have used cpu_features for errata in the past. However, we are
getting a bit short and I'd rather keep CPU features for things
that are spread out in multiple places and/or hitting hot code path.

If the workaround is very limited to a single non-critical code path,
testing the PVR might actually be a nicer way to do it.

Now, this specific patch is ... hrm ... hard to decide. I don't like
that much the global variable. On the other hand, it's static and allows
the whole business of this errata to be completely local to the
math_efp.c file which is a good thing.

So I'm tempted to say go with the patch as it-is, but I'll let Kumar
ultimately decide.

Cheers,
Ben.
