Return-Path: <SRS0=2k7H=2A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB88C43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 23:59:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5330B206A1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 23:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5330B206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47XcVW3n96zDqW5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 10:59:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=cxmp=2a=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47XcPH0gRwzDqcN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2019 10:54:58 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 205099] KASAN hit at raid6_pq: BUG: Unable to handle kernel
 data access at 0x00f0fd0d
Date: Tue, 10 Dec 2019 23:54:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-32
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version see_also
Message-ID: <bug-205099-206035-PIyJinbXTE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205099-206035@https.bugzilla.kernel.org/>
References: <bug-205099-206035@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D205099

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|5.4-rc1                     |5.5-rc1
           See Also|https://bugzilla.kernel.org |
                   |/show_bug.cgi?id=3D204479     |

--- Comment #5 from Erhard F. (erhard_f@mailbox.org) ---
Unchanged in 5.5-rc1.

[..]
[   19.425679] BUG: Unable to handle kernel data access on read at 0x00f0fd=
0d
[   19.425693] Faulting instruction address: 0xf165a560
[   19.426731] Oops: Kernel access of bad area, sig: 11 [#1]
[   19.426745] BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 DEBUG_PAGEALLOC=
 PowerMac
[   19.426757] Modules linked in: raid6_pq(+) zlib_inflate ehci_pci(+) ohci=
_hcd
hwmon ehci_hcd i2c_algo_bit drm_kms_helper sungem syscopyarea sungem_phy
sysfillrect firewire_ohci firewire_core sysimgblt crc_itu_t sr_mod fb_sys_f=
ops
usbcore ttm cdrom snd_aoa_i2sbus snd_aoa_soundbus usb_common snd_pcm snd_ti=
mer
snd soundcore drm ssb pcmcia drm_panel_orientation_quirks pcmcia_core
uninorth_agp agpgart
[   19.426986] CPU: 1 PID: 127 Comm: modprobe Tainted: G        W=20=20=20=
=20=20=20=20=20
5.5.0-rc1-PowerMacG4 #3
[   19.426997] NIP:  f165a560 LR: f165a4e8 CTR: c0247f54
[   19.427009] REGS: e86d9740 TRAP: 0300   Tainted: G        W=20=20=20=20=
=20=20=20=20=20
(5.5.0-rc1-PowerMacG4)
[   19.427014] MSR:  02009032 <VEC,EE,ME,IR,DR,RI>  CR: 22228828  XER: 0000=
0000
[   19.427048] DAR: 00f0fd0d DSISR: 40000000=20
               GPR00: e86d9998 e86d97f8 ee26c720 f166d070 00000010 00000000
f165a4e8 00000000=20
               GPR08: 00000000 00f0fd0d e7171aea fffffff0 c0247f54 00b25ff4
00000060 00000050=20
               GPR16: f166d000 ec077000 ec076000 00000070 00000060 00000050
00000040 00000030=20
               GPR24: 00000020 00000010 00000012 e86d9a84 e86d9a48 ec077010
ec076010 00000000=20
[   19.427198] NIP [f165a560] raid6_altivec8_gen_syndrome_real+0x3c0/0x480
[raid6_pq]
[   19.427228] LR [f165a4e8] raid6_altivec8_gen_syndrome_real+0x348/0x480
[raid6_pq]
[   19.427234] Call Trace:
[   19.427242] [e86d97f8] [0000000a] 0xa (unreliable)
[   19.427277] [e86d99e8] [f165a654] raid6_altivec8_gen_syndrome+0x34/0x58
[raid6_pq]
[   19.427309] [e86d9a08] [f15d83d8] init_module+0x3d8/0x528 [raid6_pq]
[   19.427334] [e86d9b18] [c0005828] do_one_initcall+0xb8/0x36c
[   19.427355] [e86d9be8] [c010e5e0] do_init_module+0xa8/0x2c4
[   19.427369] [e86d9c18] [c01114c0] load_module+0x2be4/0x2d68
[   19.427383] [e86d9e18] [c01118b8] sys_finit_module+0x100/0x138
[   19.427397] [e86d9f38] [c001a274] ret_from_syscall+0x0/0x34
[   19.427410] --- interrupt: c01 at 0x96ff78
                   LR =3D 0xafda14
[   19.427416] Instruction dump:
[   19.427429] 1304c4c4 7d2048ce 39210090 1325ccc4 7d6048ce 1346d4c4 812100=
88
1367dcc4=20
[   19.427463] 7d1098ce 115f5b06 116b5800 8141008c <7c0048ce> 392100a0 7d80=
48ce
392100b0=20
[   19.427505] ---[ end trace 161d8d283bc9b7b8 ]---

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=
