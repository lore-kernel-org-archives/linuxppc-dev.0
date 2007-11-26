Return-Path: <MBenedict@twacs.com>
Received: from mail162-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AE605DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 07:06:57 +1100 (EST)
Received: from mail162-dub (localhost.localdomain [127.0.0.1])
	by mail162-dub-R.bigfish.com (Postfix) with ESMTP id DF4DC12C8826
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 20:06:52 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail162-dub.bigfish.com (Postfix) with ESMTP id 898BB1908050
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 20:06:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: LED heartbeat trigger - in_atomic() while allocs
Date: Mon, 26 Nov 2007 14:07:05 -0600
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2DA2@twx-exch01.twacs.local>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I was playing around with the LED heartbeat trigger and it caught the
BUG() code when trying to activate.  Does anyone know why this call
stack would be in_atomic()?  Or any ideas for a patch that would allow
the heartbeat trigger to allocate when it is not in atomic context?

BUG: sleeping function called from invalid context at mm/slab.c:3024
in_atomic():1, irqs_disabled():0
Call Trace:
[def3dd90] [c0008e60] show_stack+0x48/0x194 (unreliable)
[def3ddc0] [c0014160] __might_sleep+0xd0/0xdc
[def3dde0] [c0063e60] kmem_cache_zalloc+0xdc/0x12c
[def3de00] [c01975c0] heartbeat_trig_activate+0x24/0x80
[def3de20] [c0196844] led_trigger_set+0x128/0x160
[def3de40] [c0196988] led_trigger_store+0x10c/0x1a8
[def3deb0] [c0162f40] class_device_attr_store+0x44/0x5c
[def3dec0] [c00ae614] sysfs_write_file+0x114/0x1dc
[def3def0] [c0068ea4] vfs_write+0x9c/0x110
[def3df10] [c0068ff4] sys_write+0x4c/0x90
[def3df40] [c000fc00] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xfe83818
    LR =3D 0xfe35448

Kernel 2.6.22-4, powerpc, targeting an MPC 8347.  I don't think this
issue is PowerPC specific but I was hoping other embedded people might
have experience with the LED class driver.

Thank you,
	Michael
