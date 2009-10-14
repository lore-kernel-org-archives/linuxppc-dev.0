Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC4BAB7B72
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 04:23:28 +1100 (EST)
Date: Wed, 14 Oct 2009 12:23:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 0/8] Fix 8xx MMU/TLB.
Message-ID: <20091014172351.GE21215@loki.buserror.net>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 11, 2009 at 06:35:04PM +0200, Joakim Tjernlund wrote:
> This is the latest batch of mu 8xx MMU/TLB rework.
> I think this is complete now and will relax with
> other work the next few days. I hope I can get some
> testing from Scott and Rex during this time.

I applied this stack plus "Remove DIRTY pte handling in DTLB Error" (fixing
up conflicts again, as well as the noted build errors), and got this:

INIT: version 2.85 booting
Mounting /proc and /sys
Starting the hotplug events dispatcher udevd
udevd[177]: add_to_rules: unknown key 'MODALIAS' in /etc/udev/rules.d/60-pcmcia.rules:4
udevd[177]: add_to_rules: unknown key 'MODALIAS' in /etc/udev/rules.d/60-pcmcia.rules:10
udevd[177]: add_to_rules: unknown key 'MODALIAS' in /etc/udev/rules.d/60-pcmcia.rules:14
Synthesizing initial hotplug events
/etc/rc.d/init.d/udev: line 41:   187 Segmentation fault      udevsettle --timeout=300
Setting the hostname to 8xx
Running depmod
WARNING: Couldn't open directory /lib/modules/2.6.31-08384-g2cb4b47-dirty: No such file or directory
FATAL: Could not open /lib/modules/2.6.31-08384-g2cb4b47-dirty/modules.dep.tempfor writing: No such file or directory
Mounting filesystems
BUG: soft lockup - CPU#0 stuck for 61s! [cat:265]
NIP: c000f160 LR: c000f160 CTR: 00000007
REGS: c3919c70 TRAP: 0901   Not tainted  (2.6.31-08384-g2cb4b47-dirty)
MSR: 00009032 <EE,ME,IR,DR>  CR: 88008424  XER: 00000000
TASK = c3944bd0[265] 'cat' THREAD: c3918000
GPR00: c000f160 c3919d20 c3944bd0 00000000 100180fc 00000000 00000000 00000001
GPR08: c393e700 00000000 03ca9d21 00000001 48000428
NIP [c000f160] do_page_fault+0x188/0x49c
LR [c000f160] do_page_fault+0x188/0x49c
Call Trace:
[c3919d20] [c000f160] do_page_fault+0x188/0x49c (unreliable)
[c3919dd0] [c000e3f0] handle_page_fault+0xc/0x80
[c3919e90] [c008910c] seq_read+0x2a4/0x558
[c3919ee0] [c00ab7c0] proc_reg_read+0x4c/0x70
[c3919ef0] [c006f47c] vfs_read+0xb4/0x158
[c3919f10] [c006f78c] sys_read+0x4c/0x90
[c3919f40] [c000dfc0] ret_from_syscall+0x0/0x38
Instruction dump:
2f990000 419e01f0 801f0014 700a0002 418201f8 7c1900d0 541e0ffe 7fe4fb78
7f85e378 7fc6f378 7f63db78 4804c31d <70690003> 7c601b78 40820230 70690004

-Scott
