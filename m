Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com
	(ip67-95-226-82.z226-95-67.customer.algx.net [67.95.226.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40E38DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 02:43:10 +1000 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.5.6)
	with ESMTP id md50000412611.msg
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 09:43:07 -0700
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
From: Phil Terry <pterry@micromemory.com>
To: galak@kernel.crashing.org
In-Reply-To: <Pine.LNX.4.64.0705231119271.1028@localhost.localdomain>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
	<1179934657.11247.14.camel@pterry-fc6.micromemory.com>
	<836bca7802dca173490f4d38e0c48b7a@kernel.crashing.org>
	<1179937253.11247.44.camel@pterry-fc6.micromemory.com>
	<Pine.LNX.4.64.0705231119271.1028@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 23 May 2007 09:43:06 -0700
Message-Id: <1179938586.11247.62.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Reply-To: pterry@micromemory.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-23 at 11:20 -0500, Kumar Gala wrote:
> On Wed, 23 May 2007, Phil Terry wrote:
> 
> > On Wed, 2007-05-23 at 18:05 +0200, Segher Boessenkool wrote:
> > > >> The law should really be removed.
> > > > In my application I'm may be using a huge part of the 36-bit address
> > > > space to address multiple remote RIO boards in a peer DMA multicomputer
> > > > application. The default law just for maintenance messages isn't going
> > > > to cut it.
> > >
> > > If the firmware sets up the "law", it should put a property
> > > in the node describing the setting.  If Linux sets up the
> > > laws, there shouldn't be a property (since it is a policy
> > > decision).
> > Ooops, I just posted a question to you before I saw this pop up sorry?
> >
> > But when you say "firmware" do you mean u-boot or your kernel loading
> > code or do you mean some aspect of the hardware, eg, its EEPROM program
> > which can vary from hardware to hardware instantiation?
> >
> > If you mean u-boot I'm confused (so whats new?). AFAIK u-boot can't
> > probe and set this up and even if it did, linux in the arch's I'm
> > familiar with sets everything up anew regardless of what the boot loader
> > did. AFAIK in the freescale processors the dtb is being passed in from
> > u-boot as a supplied with the kernel build "blob" not because it built
> > it dynamically. Or again have I got hold of the wrong end of the stick?
> 
> That's mostly true, but you are looking at it from one implementations
> point of view, not from how its architected.  In the future we may (and I
> will) have u-boot capable of doing more dynamic building of the device
> tree or someother firmware.  All the kernel knows is its handed a device
> tree.

OK, but if the device tree is not allowed to dictate policy, to use
Segher's term, just hardware characteristics, how does that help us get
the embedded soc kernels away from being designed and built to specific
demo/eval board setups and make them more configurable? 

I got the impression that to some extent thats how you/we/?? were trying
to use the dts stuff. If my board is exactly like freescales xyz demo
board except I move my rio map to here, my pci map to here, change a few
sizes etc., why do I have to go and patchup the arch setup code, modify
ppc_md routines, etc. Isn't the plan that I just edit the dts, compile
with dtc and have u-boot pass in the dtb to the stock kernel and its
boots on my board? 

If dts can't do this because its not allowed policy statements then what
will do this?

What device in the dts represents the soc mpx/mpc where I can define
what the laws should be? Segher is right, its not a property of the
rapidio device, it doesn't have a BAR (though it does have ATMUs?). But
if I have a device representing the mpx/mpc (the soc itself?) then I can
specify ranges for child devices to operate in (the laws) and then in
the child device I can specify ranges for the ATMUs?

I'm probably trampling over a ton of old stuff here, sorry, excuse my
ramblings....

Please I'm not trying to start up any previous turf wars here, just
trying to understand the truce terms and the plan ahead so I can get
with the program. Appreciate the help for a newbie.

Cheers
Phil

> 
> - k
> 
>  > > Cheers
> > Phil
> >
> > >
> > > >>> The dbells and mboxs can be removed. The default setting in rio is
> > > >>> okay.
> > > >>
> > > >> this could possibly be useful.
> > >
> > > Same issue.  Even if the firmware uses a default setting,
> > > it should still put it in the device tree _iff_ it is the
> > > firmware's decision (and not the kernel's).
> > >
> > >
> > > Segher
> > >
> > >
> > >
> >
> >
> 
> 
