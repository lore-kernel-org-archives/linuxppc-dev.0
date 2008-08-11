Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 52050DE053
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 02:23:14 +1000 (EST)
Message-ID: <48A0676E.5020308@harris.com>
Date: Mon, 11 Aug 2008 12:23:10 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
In-Reply-To: <20080811151913.GA14690@oksana.dev.rtsoft.ru>
Content-Type: multipart/alternative;
	boundary="------------030802000304090806060306"
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030802000304090806060306
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit

Anton Vorontsov wrote:
> When no irq specified, pata_of_platform fills irq_res with -1,
> which is wrong to do for two reasons:
>
> 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
> 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
>    is unsigned type, the check will be true for `-1'.
>
> Reported-by: Steven A. Falco <sfalco@harris.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Thanks!  Your fix is better - I didn't really like the -1 stuff.

I found this bug because I had to disable the ATA interrupt on my system
in order to get a compact-flash card to work.  I am still trying to find
out why the interrupt doesn't work for me.  Here is part of the console
log with the interrupt enabled:

    Uniform Multi-Platform E-IDE driver
    ide: Assuming 33MHz system bus speed for PIO modes; override with
    idebus=xx
    Driver 'sd' needs updating - please use bus_type methods
    irq: irq_create_mapping(0xc0574900, 0x1b)
    irq: -> using host @c0574900
    irq: -> obtained virq 32
    scsi0 : pata_platform
    ata1: PATA max PIO4 mmio cmd 0x1c1000000 ctl 0x1c1000080 irq 32
    irq 32: nobody cared (try booting with the "irqpoll" option)
    Call Trace:
    [cf83fcc0] [c0005a64] show_stack+0x44/0x1ac (unreliable)
    [cf83fd00] [c00489e4] __report_bad_irq+0x34/0xb8
    [cf83fd20] [c0048cf0] note_interrupt+0x288/0x2d0
    [cf83fd50] [c0049a94] handle_level_irq+0xac/0x114
    [cf83fd60] [c0003df0] do_IRQ+0xa4/0xc8
    [cf83fd70] [c000d60c] ret_from_except+0x0/0x18
    [cf83fe30] [00000020] 0x20
    [cf83fe50] [c0003d48] do_softirq+0x54/0x58
    [cf83fe60] [c00241c0] irq_exit+0x90/0x94
    [cf83fe70] [c0003df4] do_IRQ+0xa8/0xc8
    [cf83fe80] [c000d60c] ret_from_except+0x0/0x18
    [cf83ff40] [c01b2cc0] ata_pio_task+0x48/0x104
    [cf83ff60] [c00307a0] run_workqueue+0xb8/0x148
    [cf83ff90] [c0030d54] worker_thread+0x70/0xd0
    [cf83ffd0] [c0034788] kthread+0x48/0x84
    [cf83fff0] [c000cd6c] kernel_thread+0x44/0x60
    handlers:
    [<c01b2d7c>] (ata_sff_interrupt+0x0/0x234)
    Disabling IRQ #32


So it looks like the ATA handler was attached - not sure yet why I got
the "nobody cared" message.  Also, the system hangs.  If I find
something, I'll post it.

    Steve



--------------030802000304090806060306
Content-Type: text/html; charset=windows-1251
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=windows-1251"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Anton Vorontsov wrote:
<blockquote cite="mid:20080811151913.GA14690@oksana.dev.rtsoft.ru"
 type="cite">
  <pre wrap="">When no irq specified, pata_of_platform fills irq_res with -1,
which is wrong to do for two reasons:

1. By definition, 'no irq' should be IRQ 0, not some negative integer;
2. pata_platform checks for irq_res.start &gt; 0, but since irq_res.start
   is unsigned type, the check will be true for `-1'.

Reported-by: Steven A. Falco <a class="moz-txt-link-rfc2396E" href="mailto:sfalco@harris.com">&lt;sfalco@harris.com&gt;</a>
Signed-off-by: Anton Vorontsov <a class="moz-txt-link-rfc2396E" href="mailto:avorontsov@ru.mvista.com">&lt;avorontsov@ru.mvista.com&gt;</a>
---</pre>
</blockquote>
<tt><br>
Thanks!  Your fix is better - I didn't really like the -1 stuff.<br>
<br>
I found this bug because I had to disable the ATA interrupt on my
system in order to get a compact-flash card to work.  I am still trying
to find out why the interrupt doesn't work for me.  Here is part of the
console log with the interrupt enabled:<br>
<br>
</tt>
<blockquote><tt>Uniform Multi-Platform E-IDE driver</tt><br>
  <tt>ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx</tt><br>
  <tt>Driver 'sd' needs updating - please use bus_type methods</tt><br>
  <tt>irq: irq_create_mapping(0xc0574900, 0x1b)</tt><br>
  <tt>irq: -&gt; using host @c0574900</tt><br>
  <tt>irq: -&gt; obtained virq 32</tt><br>
  <tt>scsi0 : pata_platform</tt><br>
  <tt>ata1: PATA max PIO4 mmio cmd 0x1c1000000 ctl 0x1c1000080 irq 32</tt><br>
  <tt>irq 32: nobody cared (try booting with the "irqpoll" option)</tt><br>
  <tt>Call Trace:</tt><br>
  <tt>[cf83fcc0] [c0005a64] show_stack+0x44/0x1ac (unreliable)</tt><br>
  <tt>[cf83fd00] [c00489e4] __report_bad_irq+0x34/0xb8</tt><br>
  <tt>[cf83fd20] [c0048cf0] note_interrupt+0x288/0x2d0</tt><br>
  <tt>[cf83fd50] [c0049a94] handle_level_irq+0xac/0x114</tt><br>
  <tt>[cf83fd60] [c0003df0] do_IRQ+0xa4/0xc8</tt><br>
  <tt>[cf83fd70] [c000d60c] ret_from_except+0x0/0x18</tt><br>
  <tt>[cf83fe30] [00000020] 0x20</tt><br>
  <tt>[cf83fe50] [c0003d48] do_softirq+0x54/0x58</tt><br>
  <tt>[cf83fe60] [c00241c0] irq_exit+0x90/0x94</tt><br>
  <tt>[cf83fe70] [c0003df4] do_IRQ+0xa8/0xc8</tt><br>
  <tt>[cf83fe80] [c000d60c] ret_from_except+0x0/0x18</tt><br>
  <tt>[cf83ff40] [c01b2cc0] ata_pio_task+0x48/0x104</tt><br>
  <tt>[cf83ff60] [c00307a0] run_workqueue+0xb8/0x148</tt><br>
  <tt>[cf83ff90] [c0030d54] worker_thread+0x70/0xd0</tt><br>
  <tt>[cf83ffd0] [c0034788] kthread+0x48/0x84</tt><br>
  <tt>[cf83fff0] [c000cd6c] kernel_thread+0x44/0x60</tt><br>
  <tt>handlers:</tt><br>
  <tt>[&lt;c01b2d7c&gt;] (ata_sff_interrupt+0x0/0x234)</tt><br>
  <tt>Disabling IRQ #32</tt><br>
</blockquote>
<tt><br>
So it looks like the ATA handler was attached - not sure yet why I got
the "nobody cared" message.  Also, the system hangs.  If I find
something, I'll post it.<br>
<br>
    Steve<br>
<br>
</tt><br>
</body>
</html>

--------------030802000304090806060306--
