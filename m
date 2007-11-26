Return-Path: <ntl@pobox.com>
Received: from lollipop.listbox.com (lollipop.listbox.com [208.210.124.78])
	by ozlabs.org (Postfix) with ESMTP id 2D6DCDDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 10:21:37 +1100 (EST)
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by lollipop.listbox.com (Postfix) with ESMTP id B4ECD43AC8D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 15:37:42 -0500 (EST)
Date: Mon, 26 Nov 2007 14:36:49 -0600
From: Nathan Lynch <ntl@pobox.com>
To: "Benedict, Michael" <MBenedict@twacs.com>
Subject: Re: LED heartbeat trigger - in_atomic() while allocs
Message-ID: <20071126203649.GD29155@localdomain>
References: <BAF8B1E0BB28024A90895E746A3B610D1C2DA2@twx-exch01.twacs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAF8B1E0BB28024A90895E746A3B610D1C2DA2@twx-exch01.twacs.local>
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

Benedict, Michael wrote:
> I was playing around with the LED heartbeat trigger and it caught the
> BUG() code when trying to activate.  Does anyone know why this call
> stack would be in_atomic()?  Or any ideas for a patch that would allow
> the heartbeat trigger to allocate when it is not in atomic context?
> 
> BUG: sleeping function called from invalid context at mm/slab.c:3024
> in_atomic():1, irqs_disabled():0
> Call Trace:
> [def3dd90] [c0008e60] show_stack+0x48/0x194 (unreliable)
> [def3ddc0] [c0014160] __might_sleep+0xd0/0xdc
> [def3dde0] [c0063e60] kmem_cache_zalloc+0xdc/0x12c
> [def3de00] [c01975c0] heartbeat_trig_activate+0x24/0x80
> [def3de20] [c0196844] led_trigger_set+0x128/0x160
> [def3de40] [c0196988] led_trigger_store+0x10c/0x1a8
> [def3deb0] [c0162f40] class_device_attr_store+0x44/0x5c
> [def3dec0] [c00ae614] sysfs_write_file+0x114/0x1dc
> [def3def0] [c0068ea4] vfs_write+0x9c/0x110
> [def3df10] [c0068ff4] sys_write+0x4c/0x90
> [def3df40] [c000fc00] ret_from_syscall+0x0/0x38
> --- Exception: c01 at 0xfe83818
>     LR = 0xfe35448
> 
> Kernel 2.6.22-4, powerpc, targeting an MPC 8347.

>From a brief glance at the code, looks like led_trigger_store is
holding a rwlock while calling led_trigger_set.
