Return-Path: <sipcop009@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.201])
	by ozlabs.org (Postfix) with ESMTP id 56C0D67B54
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 09:33:47 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so941451nzh
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 16:33:46 -0700 (PDT)
Message-ID: <5a4792c00608281633p4921016fn62a6f7cedba9e03@mail.gmail.com>
Date: Mon, 28 Aug 2006 16:33:46 -0700
From: "SIP COP 009" <sipcop009@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MPC83xx and Gianfar Drive Oops
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_122235_25922593.1156808026636"
Cc: sipcop009@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_122235_25922593.1156808026636
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Folks,

Anyone seen this before ?

We have the MPC8349 based EVM board which has 2 GigEs. IP forwarding is
enabled on the system. The kernel/gianfar is  2.6.11 based.

We were trying to stress the GigE interfaces by sending bidirectional
smartbits traffic.

We observe the following kernel oops:
e-99-0-21-1# Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C016EB80 LR: C016EB80 SP: C0241DE0 REGS: c0241d30 TRAP: 0700
Tainted: P
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 TASK = c022bdb0[0] 'swapper'
THREAD: c0240000 Last syscall: 120
GPR00: C016EB80 C0241DE0 C022BDB0 00000030 C0263BF4 000001A1 DF700060
3B9ACA00
GPR08: C0263BF8 C023DB24 DEA5DE9C C0241CF0 00003C9B 1001A1F8 1FFF8000
00000000
GPR16: FFFFFFFF 00000001 00000000 1FFF297C 1FF9E330 00000001 007FFF00
C0230000
GPR24: 00000001 0000FFFC DFD6B800 0000003F DDC42F48 00000000 D7FA9140
DFD6BA20 Call trace: [c01495d4]  [c0149748]  [c0176078]  [c0018d34]
[c0018e00] [c0005438]  [c000460c]  [c00038ac]  [c00054d0]  [c0003928]
[c0242674] [000035fc] Kernel panic - not syncing: Aiee, killing interrupt
handler!
  <0>Rebooting in 180 seconds..

After decoding this it looks like the following:

Enter hex value: c01495d4
0xc01495d4:gfar_error(0xc01494bc)+0x118
Enter hex value: c0149748
0xc0149748:gfar_gdrvinfo(0xc0149718)+0x30
Enter hex value: c0176078
0xc0176078:dev_ioctl(0xc0175f0c)+0x16c
Enter hex value: c0018d34
0xc0018d34:__do_softirq(0xc0018cb4)+0x80
Enter hex value: c0018e00
0xc0018e00:do_softirq(0xc0018da8)+0x58
Enter hex value: c0005438
0xc0005438:do_IRQ(0xc00053b4)+0x84
Enter hex value: c000460c
0xc000460c:ret_from_except(0xc000460c)+0x0
Enter hex value: c00038ac
0xc00038ac:ppc6xx_idle(0xc00037c8)+0xe4
Enter hex value: c00054d0
0xc00054d0:cpu_idle(0xc00054a8)+0x28

Any idea on this one ? Any new fixes that went in for such issues ?

Thanks!
ashutosh

------=_Part_122235_25922593.1156808026636
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Folks,<br>
<br>
Anyone seen this before ?<br>
<br>
We have the MPC8349 based EVM board which has 2 GigEs. IP forwarding is
enabled on the system. The kernel/gianfar is&nbsp; 2.6.11 based.<br>
<br>
We were trying to stress the GigE interfaces by sending bidirectional smartbits traffic. <br>
<br>
We observe the following kernel oops:<br>
e-99-0-21-1# Oops: Exception in kernel mode, sig: 5 [#1]<br>
NIP: C016EB80 LR: C016EB80 SP: C0241DE0 REGS: c0241d30 TRAP: 0700<br>
Tainted: P<br>
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 TASK = c022bdb0[0] 'swapper' THREAD: c0240000 Last syscall: 120<br>
GPR00: C016EB80 C0241DE0 C022BDB0 00000030 C0263BF4 000001A1 DF700060 3B9ACA00<br>
GPR08: C0263BF8 C023DB24 DEA5DE9C C0241CF0 00003C9B 1001A1F8 1FFF8000 00000000<br>
GPR16: FFFFFFFF 00000001 00000000 1FFF297C 1FF9E330 00000001 007FFF00 C0230000<br>
GPR24: 00000001 0000FFFC DFD6B800 0000003F DDC42F48 00000000 D7FA9140
DFD6BA20 Call trace: [c01495d4]&nbsp; [c0149748]&nbsp; [c0176078]&nbsp;
[c0018d34]&nbsp; [c0018e00] [c0005438]&nbsp; [c000460c]&nbsp;
[c00038ac]&nbsp; [c00054d0]&nbsp; [c0003928]&nbsp; [c0242674]
[000035fc] Kernel panic - not syncing: Aiee, killing interrupt handler!<br>
&nbsp; &lt;0&gt;Rebooting in 180 seconds..<br>
<br>
After decoding this it looks like the following:<br>
<br>
Enter hex value: c01495d4<br>
0xc01495d4:gfar_error(0xc01494bc)+0x118<br>
Enter hex value: c0149748<br>
0xc0149748:gfar_gdrvinfo(0xc0149718)+0x30<br>
Enter hex value: c0176078<br>
0xc0176078:dev_ioctl(0xc0175f0c)+0x16c<br>
Enter hex value: c0018d34<br>
0xc0018d34:__do_softirq(0xc0018cb4)+0x80<br>
Enter hex value: c0018e00<br>
0xc0018e00:do_softirq(0xc0018da8)+0x58<br>
Enter hex value: c0005438<br>
0xc0005438:do_IRQ(0xc00053b4)+0x84<br>
Enter hex value: c000460c<br>
0xc000460c:ret_from_except(0xc000460c)+0x0<br>
Enter hex value: c00038ac<br>
0xc00038ac:ppc6xx_idle(0xc00037c8)+0xe4<br>
Enter hex value: c00054d0<br>
0xc00054d0:cpu_idle(0xc00054a8)+0x28<br>
<br>
Any idea on this one ? Any new fixes that went in for such issues ?<br>
<br>
Thanks!<br>
ashutosh<br>
<br>

------=_Part_122235_25922593.1156808026636--
