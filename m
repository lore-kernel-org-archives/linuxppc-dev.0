Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4BF4767CAE
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 21:42:00 +1100 (EST)
Message-ID: <454DBFE7.3090800@s5r6.in-berlin.de>
Date: Sun, 05 Nov 2006 11:41:43 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle]
Content-Type: multipart/mixed; boundary="------------010707080106010402040801"
Cc: Gioele Barabucci <dev@gioelebarabucci.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010707080106010402040801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi list,
there was a bug report on ohci1394 which seems to be related to the
platform-specific code in the driver. Additional details were posted on
linux1394-user:
http://thread.gmane.org/gmane.linux.kernel.firewire.user/focus=2120
Subject: "strange interaction: ohci1394 and backlight on iBook"
Any ideas? Thanks,
-- 
Stefan Richter
-=====-=-==- =-== --=-=
http://arcgraph.de/sr/

--------------010707080106010402040801
Content-Type: message/rfc822;
 name*0="[Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="[Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle"

Return-Path: <www@osdl.org>
Received: from einhorn-in.in-berlin.de ([unix socket])
	by einhorn (Cyrus v2.1.17-IPv6-Debian-2.1.17-3) with LMTP; Mon, 30 Oct 2006 02:24:59 +0100
X-Sieve: CMU Sieve 2.2
Received: from gnu.in-berlin.de (gnu.in-berlin.de [192.109.42.4])
	by einhorn-in.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k9U1OxxZ011897
	for <stefan-r-bz@s5r6.in-berlin.de>; Mon, 30 Oct 2006 02:24:59 +0100
X-Envelope-From: www@osdl.org
X-Envelope-To: <stefan-r-bz@s5r6.in-berlin.de>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by gnu.in-berlin.de (8.13.8/8.13.8/Debian-2) with ESMTP id k9U1Os5Z025162
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT)
	for <stefan-r-bz@s5r6.in-berlin.de>; Mon, 30 Oct 2006 02:24:56 +0100
Received: from fire-2.osdl.org (localhost [127.0.0.1])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9U1OrPo030175
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <stefan-r-bz@s5r6.in-berlin.de>; Sun, 29 Oct 2006 17:24:53 -0800
Received: (from www@localhost)
	by fire-2.osdl.org (8.12.8/8.12.5/Submit) id k9U1Orae030173;
	Sun, 29 Oct 2006 17:24:53 -0800
Date: Sun, 29 Oct 2006 17:24:53 -0800
Message-Id: <200610300124.k9U1Orae030173@fire-2.osdl.org>
From: bugme-daemon@bugzilla.kernel.org
To: stefan-r-bz@s5r6.in-berlin.de
Subject: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Category: Drivers
X-Bugzilla-Component: IEEE1394
Received-SPF: pass (localhost is always allowed.)
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.4
X-Scanned-By: MIMEDefang 2.36
X-Spam-Score: (0.962) BAYES_50,NO_REAL_NAME,SPF_PASS,UNPARSEABLE_RELAY

http://bugzilla.kernel.org/show_bug.cgi?id=7431

           Summary: ohci1394 Oops after a rmmod/modprobe cycle
    Kernel Version: 2.6.18 (gentoo-sources-2.6.18)
            Status: NEW
          Severity: normal
             Owner: drivers_ieee1394@kernel-bugs.osdl.org
         Submitter: dev@gioelebarabucci.com


Distribution: Gentoo
Hardware Environment: PPC iBook G3 (PowerBook4,3)
Problem Description:

When I 'rmmod ohci1394' and then 'modprobe ohci1394', I get a "Bus error" 
message from modprobe and my backlight is set to full brightness.
dmesg reveals that an oops occurred. Here is the dmesg output after 'modprobe 
ohci1394':

| Machine check in kernel mode.
| Caused by (from SRR1=49030): Transfer error ack signal
| Oops: Machine check, sig: 7 [#1]
|
| Modules linked in: ohci1394 ipv6 af_packet radeon drm snd_seq snd_seq_device 
snd_powermac ide_cd cdrom snd_aoa_i2sbus snd_pcm airport snd_timer 
snd_page_alloc snd orinoco soundcore hermes snd_aoa_soundbus sungem ieee1394 
ohci_hcd usbcore uninorth_agp sungem_phy agpgart evdev unix
| NIP: EA08D29C LR: EA091618 CTR: C002CCB0
| REGS: cd533c80 TRAP: 0200   Not tainted  (2.6.18-gentoo)
| MSR: 00049030 <EE,ME,IR,DR>  CR: 24004482  XER: 00000000
| TASK = cd947850[8127] 'modprobe' THREAD: cd532000
| GPR00: FFFFFFFF CD533D30 CD947850 CB2B9E68 EA08E094 CB2B9F44 CC1BD7FC 
00000000
| GPR08: 0000001F EA084000 000007C0 EA084000 84004488 1001F288 0000001D 
EA08B13C
| GPR16: E7454AE0 EA0886D4 00000124 00000000 C0045298 EA088148 EA088724 
EA090000
| GPR24: CB2B8000 CB2B9EE8 CB2B9FA0 CB2B9E8C CB2B9F44 C79BA000 CB2B9E68 
00000000
| NIP [EA08D29C] ohci_soft_reset+0x50/0x78 [ohci1394]
| LR [EA091618] ohci1394_pci_probe+0x2f4/0xb90 [ohci1394]
| Call Trace:
| [CD533D30] [C79BA000] 0xc79ba000 (unreliable)
| [CD533D40] [EA091618] ohci1394_pci_probe+0x2f4/0xb90 [ohci1394]
| [CD533DA0] [C00F755C] pci_device_probe+0x84/0xa4
| [CD533DC0] [C014EE88] driver_probe_device+0x60/0x118
| [CD533DE0] [C014F0C0] __driver_attach+0xcc/0xf8
| [CD533E00] [C014E764] bus_for_each_dev+0x58/0x94
| [CD533E30] [C014ED9C] driver_attach+0x24/0x34
| [CD533E40] [C014E2CC] bus_add_driver+0x88/0x164
| [CD533E60] [C014F36C] driver_register+0x70/0xb8
| [CD533E70] [C00F7378] __pci_register_driver+0x4c/0x8c
| [CD533E80] [E900D020] ohci1394_init+0x20/0x60 [ohci1394]
| [CD533E90] [C0046214] sys_init_module+0x170/0x1544
| [CD533F40] [C000F2FC] ret_from_syscall+0x0/0x38
| --- Exception: c01 at 0xff3caac
|    LR = 0x10002e84
| Instruction dump:
| 7c0004ac 7d20052c 3be00000 48000014 4800570d 2f9f0063 3bff0001 419e0028
| 813e0008 38090050 7c0004ac 7c00042c <0c000000> 4c00012c 74090001 386003e8

Steps to reproduce:
* rmmod ohci1394
* modprobe ohci1394

In addition, it is impossible now to remove the ohci1394 module:
| # rmmod ohci1394
| ERROR: Module ohci1394 is in use

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

--------------010707080106010402040801--
