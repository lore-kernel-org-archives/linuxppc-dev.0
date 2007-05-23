Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com
	(ip67-95-226-82.z226-95-67.customer.algx.net [67.95.226.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD4DCDDED3
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 01:37:42 +1000 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.5.6)
	with ESMTP id md50000412550.msg
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 08:37:39 -0700
Subject: RE: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
From: Phil Terry <pterry@micromemory.com>
To: galak@kernel.crashing.org
In-Reply-To: <Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 23 May 2007 08:37:37 -0700
Message-Id: <1179934657.11247.14.camel@pterry-fc6.micromemory.com>
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

On Wed, 2007-05-23 at 09:21 -0500, Kumar Gala wrote:
> On Wed, 23 May 2007, Zhang Wei-r63237 wrote:
> 
> > > So I'm taking the boot/dts/mpc8641_hpcn.dts and producing a new
> > > mpc8641D_umem.dts with the following addition to the soc.
> > >
> > > srio@c0000 {
> > >                 device_type = "srio";
> > >                 compatible = "86xx,85xx";
> 
> We really need to think about this, is their really any difference between
> srio and prio from a software view point?
I didn't mean to imply that, the above was just my strawman for
discussion purposes in my overview question. As per a suggestion I was
now calling it rapidio@c0000.

But maybe this is moot, the patches are on their way (yippee) Thanks
Zhang.

> 
> > > 		reg = <c0000 20000>;
> > > 		law = <400000000 e00000000>;
> >
> > Please use range = <0 address_start size>
> 
> The law should really be removed.
In my application I'm may be using a huge part of the 36-bit address
space to address multiple remote RIO boards in a peer DMA multicomputer
application. The default law just for maintenance messages isn't going
to cut it. Now I suppose we could say that my DMA oriented driver should
be responsible for another law for that purpose but that seemed wasteful
to me, there aren't that many laws to go around. So I wanted to hijack
and make this one configurable. But this was just my first idea so I'm
open to suggestions.

> 
> >
> > > 		dbells = <0 ffff>;
> > > 		mboxs = <0 4>;
> >
> > The dbells and mboxs can be removed. The default setting in rio is okay.
> 
> this could possibly be useful.

Again, the current setup seems to be the minimum required to support
rionet. The hardware can support multiple mailboxes as is not just mbox
0 used by rionet. As I understand it one message unit is dedicated to
mbox 0 and mboxes 1 to 63 are used by the second message unit. I want in
my application to use the "clean" mbox 0 for my apps messaging and
relegate rionet to mbox 1. So in the interests of generality I wanted to
make the number of mboxes supported configurable. Is this something I
should not do in dts but relegate somewhere else?

The doorbells is debatable. There is only a single unit supporting all
doorbells in extant hardware (AFAIK) so this was again for generality in
case a dual doorbell hw unit arrives.
> 
> >
> > >                 interrupt-parent = <&mpic>;
> > >                 interrupts = <30 1 31 1 32 1 35 1 36 1 37 1 38 1>;
> > >               };
> > >
> > Do you really use all of this interrupts? In my test, three <32 2 35 2
> > 36 2> are okay, and the sense is 2.
> 
> I think we need to list all the interrupts possible from RIO, not just the
> ones the driver happens to use.
Sorry about the senses, again I just threw that in the email as a
strawman to kick off discussion (which now seems moot as Wei has the
patches (yippee)). The second set of interrupts 37 and 38 are for the
second message unit which I want to use (see above). 30 is for
port-write/error which I will be using to get interrupts from my
switches for topology changes. 31 is the out doorbell done which the
driver doesn't use cos of the synchronous nature of the out doorbell I
suppose.
> 
> - k
> 
> 
