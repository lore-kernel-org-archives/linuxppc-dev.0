Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F71EB6F89
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 11:58:23 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110614182517.776d7e77@schlenkerla.am.freescale.net>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Jun 2011 11:58:11 +1000
Message-ID: <1308103091.2635.13.camel@pasglop>
Mime-Version: 1.0
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-06-14 at 18:25 -0500, Scott Wood wrote:
> On Tue, 14 Jun 2011 18:15:26 -0500
> Timur Tabi <timur@freescale.com> wrote:
> 
> > Scott Wood wrote:
> > > FWIW, it's not supported under KVM either -- though we don't support an SMP
> > > guest under KVM yet, and KVM silently ignores it rather than logs errors as
> > > the FSL HV does.
> > 
> > Does KVM set the root compatible to "fsl,P4080DS-hv"?
> 
> No, Qemu/KVM like to pretend they're fully emulating concrete hardware,
> even though there's stuff missing.
> 
> The only upstream e500 KVM platform is currently mpc8544ds.
> 
> For now, there's no SMP KVM guest support.  Maybe kexec can be fixed to not
> hard-reset the core by the time that changes. :-)

We might want to generically have a CPU feature bit indicating we are
running in guest vs. HV mode. I know Paulus is planning to introduce one
so you may want to sync with him.

Cheers,
Ben.
