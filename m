Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A9A2FB70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 21:11:00 +1000 (EST)
Subject: Re: Can't boot 2.6.30 powerpc kernel under qemu.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1246321478.4621.11.camel@concordia>
References: <200906281033.09842.jk@ozlabs.org>
	<200906291834.07902.rob@landley.net>
	<1246321478.4621.11.camel@concordia>
Content-Type: text/plain
Date: Tue, 30 Jun 2009 20:50:20 +1000
Message-Id: <1246359020.31413.12.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org,
	Jeremy Kerr <jk@ozlabs.org>, Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-06-30 at 10:24 +1000, Michael Ellerman wrote:
> On Mon, 2009-06-29 at 18:34 -0500, Rob Landley wrote:
> > Which suggested that the problem was the new CONFIG_PPC_OF_BOOT_TRAMPOLINE 
> > symbol wasn't set, and once I switched that on it started working again.
> 
> What defconfig are you using? It sounds like maybe something should be
> 'select'ing OF_BOOT_TRAMPOLINE.

Right, pmac, pseries and chrp probably ... though I don't like select
for a user-visible option, I'd rather fix things if I inadvertently
forgot the "default y" here, after all, one may want to do a minimum
kdump kernel without prom_init.c in it.

Cheers,
Ben.

> 
> > > linuxppc-dev@lists.ozlabs.org is the one you want for this:
> > >
> > >  https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> > Cool!  Is there a reason it's hidden?  (Or at least not listed in either 
> > vger.kernel.org's list info page or in the "Maling lists" page linked from 
> > ozlabs.org's top level web page.)  Just curious, I couldn't find it when I 
> > looked in the obvious (to me) places.
> 
> It's not hidden, it's just in the process of moving from ozlabs.org to
> lists.ozlabs.org - and it's a bit hard to find in the process. I've
> updated the ozlabs.org page to point to it in the meantime.
> 
> It's also in maintainers :D
> 
> LINUX FOR POWERPC (32-BIT AND 64-BIT)                                                                          
> P:      Benjamin Herrenschmidt
> M:      benh@kernel.crashing.org
> P:      Paul Mackerras
> M:      paulus@samba.org
> W:      http://www.penguinppc.org/
> L:      linuxppc-dev@ozlabs.org
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
> S:      Supported
> 
> 
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
