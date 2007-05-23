Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49943DDF2D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 02:25:24 +1000 (EST)
Date: Wed, 23 May 2007 11:20:42 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Phil Terry <pterry@micromemory.com>
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
In-Reply-To: <1179937253.11247.44.camel@pterry-fc6.micromemory.com>
Message-ID: <Pine.LNX.4.64.0705231119271.1028@localhost.localdomain>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
	<1179934657.11247.14.camel@pterry-fc6.micromemory.com>
	<836bca7802dca173490f4d38e0c48b7a@kernel.crashing.org>
	<1179937253.11247.44.camel@pterry-fc6.micromemory.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 May 2007, Phil Terry wrote:

> On Wed, 2007-05-23 at 18:05 +0200, Segher Boessenkool wrote:
> > >> The law should really be removed.
> > > In my application I'm may be using a huge part of the 36-bit address
> > > space to address multiple remote RIO boards in a peer DMA multicomputer
> > > application. The default law just for maintenance messages isn't going
> > > to cut it.
> >
> > If the firmware sets up the "law", it should put a property
> > in the node describing the setting.  If Linux sets up the
> > laws, there shouldn't be a property (since it is a policy
> > decision).
> Ooops, I just posted a question to you before I saw this pop up sorry?
>
> But when you say "firmware" do you mean u-boot or your kernel loading
> code or do you mean some aspect of the hardware, eg, its EEPROM program
> which can vary from hardware to hardware instantiation?
>
> If you mean u-boot I'm confused (so whats new?). AFAIK u-boot can't
> probe and set this up and even if it did, linux in the arch's I'm
> familiar with sets everything up anew regardless of what the boot loader
> did. AFAIK in the freescale processors the dtb is being passed in from
> u-boot as a supplied with the kernel build "blob" not because it built
> it dynamically. Or again have I got hold of the wrong end of the stick?

That's mostly true, but you are looking at it from one implementations
point of view, not from how its architected.  In the future we may (and I
will) have u-boot capable of doing more dynamic building of the device
tree or someother firmware.  All the kernel knows is its handed a device
tree.

- k

 > > Cheers
> Phil
>
> >
> > >>> The dbells and mboxs can be removed. The default setting in rio is
> > >>> okay.
> > >>
> > >> this could possibly be useful.
> >
> > Same issue.  Even if the firmware uses a default setting,
> > it should still put it in the device tree _iff_ it is the
> > firmware's decision (and not the kernel's).
> >
> >
> > Segher
> >
> >
> >
>
>
