Return-Path: <MBenedict@twacs.com>
Received: from outbound3-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 735BDDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 12:30:03 +1100 (EST)
Received: from outbound3-va3.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-va3-R.bigfish.com (Postfix) with ESMTP id 6E9666E97D0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 01:02:19 +0000 (UTC)
Received: from mail117-va3-R.bigfish.com (si1-va3 [10.7.14.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by outbound3-va3.bigfish.com (Postfix) with ESMTP id 6D5821380064
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 01:02:19 +0000 (UTC)
Received: from mail117-va3 (localhost.localdomain [127.0.0.1])
	by mail117-va3-R.bigfish.com (Postfix) with ESMTP id 566FB1CB824A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 01:02:19 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail117-va3.bigfish.com (Postfix) with ESMTP id 2C677188006A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 01:02:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: LED heartbeat trigger - in_atomic() while allocs
Date: Mon, 26 Nov 2007 19:02:31 -0600
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2DA5@twx-exch01.twacs.local>
In-Reply-To: <20071126203649.GD29155@localdomain>
References: <BAF8B1E0BB28024A90895E746A3B610D1C2DA2@twx-exch01.twacs.local>
	<20071126203649.GD29155@localdomain>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: "Nathan Lynch" <ntl@pobox.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks, yeah I see that now.  I just changed the alloc to be GPF_ATOMIC
for now, but I don't really know how this was intended to work.
	-Michael=20

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+mbenedict=3Dtwacs.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+mbenedict=3Dtwacs.com@ozlabs.o
rg] On Behalf Of Nathan Lynch
> Sent: Monday, November 26, 2007 2:37 PM
> To: Benedict, Michael
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: LED heartbeat trigger - in_atomic() while allocs
>=20
> Benedict, Michael wrote:
> > I was playing around with the LED heartbeat trigger and it=20
> caught the
> > BUG() code when trying to activate.  Does anyone know why this call
> > stack would be in_atomic()?  Or any ideas for a patch that=20
> would allow
> > the heartbeat trigger to allocate when it is not in atomic context?
> >=20
> > BUG: sleeping function called from invalid context at mm/slab.c:3024
> > in_atomic():1, irqs_disabled():0
> > Call Trace:
> > [def3dd90] [c0008e60] show_stack+0x48/0x194 (unreliable)
> > [def3ddc0] [c0014160] __might_sleep+0xd0/0xdc
> > [def3dde0] [c0063e60] kmem_cache_zalloc+0xdc/0x12c
> > [def3de00] [c01975c0] heartbeat_trig_activate+0x24/0x80
> > [def3de20] [c0196844] led_trigger_set+0x128/0x160
> > [def3de40] [c0196988] led_trigger_store+0x10c/0x1a8
> > [def3deb0] [c0162f40] class_device_attr_store+0x44/0x5c
> > [def3dec0] [c00ae614] sysfs_write_file+0x114/0x1dc
> > [def3def0] [c0068ea4] vfs_write+0x9c/0x110
> > [def3df10] [c0068ff4] sys_write+0x4c/0x90
> > [def3df40] [c000fc00] ret_from_syscall+0x0/0x38
> > --- Exception: c01 at 0xfe83818
> >     LR =3D 0xfe35448
> >=20
> > Kernel 2.6.22-4, powerpc, targeting an MPC 8347.
>=20
> From a brief glance at the code, looks like led_trigger_store is
> holding a rwlock while calling led_trigger_set.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
