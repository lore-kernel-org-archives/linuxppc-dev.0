Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EF4067B69
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 10:00:23 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <20750c905c7c0f2eccc3eba6dc1421db@kernel.crashing.org>
References: <20050629130113.GA30972@suse.de>
	<20750c905c7c0f2eccc3eba6dc1421db@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:54:44 +1000
Message-Id: <1120089284.31924.33.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Eric Biederman <ebiederm@xmission.com>, Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] use correct register names in
	arch/ppc/kernel/relocate_kernel.S
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-06-29 at 20:08 +0200, Segher Boessenkool wrote:
> > --- linux-2.6.13-rc1.orig/arch/ppc/kernel/relocate_kernel.S
> > +++ linux-2.6.13-rc1/arch/ppc/kernel/relocate_kernel.S
> > @@ -34,9 +34,9 @@ relocate_new_kernel:
> >
> >  	mr	r8, r0
> >  	ori     r8, r8, MSR_RI|MSR_ME
> > -	mtspr	SRR1, r8
> > +	mtspr	SPRN_SRR1, r8
> >  	addi	r8, r4, 1f - relocate_new_kernel
> > -	mtspr	SRR0, r8
> > +	mtspr	SPRN_SRR0, r8
> >  	sync
> >  	rfi
> 
> Or just mtsrr0 c.q. mtsrr1

They are lovely but shits me when I grep for SPRN_SRR0 :) I tend to
prefer consistency here and so if we start using mtsrr0/1, then we
should change the whole kernel at once and not have a mix of SPRN_* and
mt*

Ben.
