Return-Path: <thirumalai.p@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4E7DDB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 14:18:18 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 68371DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 14:18:17 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b6so1888455ana.39
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 21:18:15 -0700 (PDT)
MIME-Version: 1.0
Sender: thirumalai.p@gmail.com
In-Reply-To: <e1ca2e7b0908192115o2cfa427fof21512757854901a@mail.gmail.com>
References: <e1ca2e7b0908192115o2cfa427fof21512757854901a@mail.gmail.com>
Date: Thu, 20 Aug 2009 12:18:15 +0800
Message-ID: <e1ca2e7b0908192118s1e97c29btdc66e44d36e8a187@mail.gmail.com>
Subject: Regarding TSI108 ethernet DMA issue
From: Thirumalai Pachamuthu <thirumalai.p@datapatterns.co.in>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: multipart/alternative; boundary=001636ed6a825de98d04718b0a6a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636ed6a825de98d04718b0a6a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

 Hi all,
      I am trying to port linux 2.6.30 for my TSI108 based custom board
where i am getting the following kernel panic message. I found that it was
due to dma allocation function call particularly dma_alloc_coherent() of
tsi108_open function. When we see the implementation of dma_alloc_coherent.
It was bit changed from the previous linux versions it seems.
      The implementation of dma_alloc_coherent was kept on the
arch/powerpc/include/asm/dma-mapping.h file. Earlier implementation is not
considering the first parameter what the tsi108 driver is passing as NULL.
But the current implementation is considering this parameter and because of
this the panic is coming what i believe.

      So kindly let me know any patches for this problem or any fixes.

------------[ cut here ]------------
Kernel BUG at c019074c [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
DPVME0447
NIP: c019074c LR: c019074c CTR: c014ea48
REGS: df82bd80 TRAP: 0700   Not tainted  (2.6.30)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24000022  XER: 20000000
TASK = df82c000[1] 'swapper' THREAD: df82a000
GPR00: c019074c df82be30 df82c000 00000030 000013e0 ffffffff c014e998
00000035
GPR08: c02f2af0 c02e7bb8 000013e0 c02cd8f4 24000042 00000000 00000002
00000000
GPR16: c02c0000 00000000 00000000 00000000 00000000 0ffaa41c c0300000
00000004
GPR24: 00000000 00000000 c02f0000 c02f0000 df821030 00000000 df821000
df821300
NIP [c019074c] tsi108_open+0x5c/0x90
LR [c019074c] tsi108_open+0x5c/0x90
Call Trace:
[df82be30] [c019074c] tsi108_open+0x5c/0x90 (unreliable)
[df82be50] [c01b1564] dev_open+0xac/0x11c
[df82be70] [c01b1464] dev_change_flags+0x160/0x1b4
[df82be90] [c02bc5f8] ip_auto_config+0x18c/0xe5c
[df82bf50] [c0003c8c] do_one_initcall+0x34/0x1a8
[df82bfd0] [c02a1848] kernel_init+0x9c/0x100
[df82bff0] [c0012064] kernel_thread+0x4c/0x68
Instruction dump:
807f003c 7fc8f378 4beb8d71 7c7d1b79 40820028 80bf003c 3c60c029 7fc6f378
386327c0 90be0028 809f0040 4be90669 <0fe00000> 48000000 80bf003c 3c60c029
---[ end trace dc633a1da0ecdafb ]---
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..

Regards,
T.

--001636ed6a825de98d04718b0a6a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">
<div>Hi all,</div>
<div>=A0=A0=A0=A0=A0 I am trying to port linux 2.6.30 for my TSI108 based c=
ustom board where i am getting the following kernel panic message. I found =
that it was due to dma allocation function call particularly dma_alloc_cohe=
rent() of tsi108_open function. When we see the implementation of dma_alloc=
_coherent. It was bit changed from the previous linux versions it seems. </=
div>

<div>=A0=A0=A0=A0=A0 The implementation of dma_alloc_coherent was kept on t=
he arch/powerpc/include/asm/dma-mapping.h file. Earlier implementation is n=
ot considering the first parameter what the tsi108 driver is passing as NUL=
L. But the current implementation is considering this parameter and because=
 of this the panic is coming what i believe.</div>

<div>=A0</div>
<div>=A0=A0=A0=A0=A0 So kindly let me know any patches for this problem or =
any fixes.</div>
<div>=A0</div>
<div>------------[ cut here ]------------<br>Kernel BUG at c019074c [verbos=
e debug info unavailable]<br>Oops: Exception in kernel mode, sig: 5 [#1]<br=
>DPVME0447<br>NIP: c019074c LR: c019074c CTR: c014ea48<br>REGS: df82bd80 TR=
AP: 0700=A0=A0 Not tainted=A0 (2.6.30)<br>
MSR: 00029032 &lt;EE,ME,CE,IR,DR&gt;=A0 CR: 24000022=A0 XER: 20000000<br>TA=
SK =3D df82c000[1] &#39;swapper&#39; THREAD: df82a000<br>GPR00: c019074c df=
82be30 df82c000 00000030 000013e0 ffffffff c014e998 00000035 <br>GPR08: c02=
f2af0 c02e7bb8 000013e0 c02cd8f4 24000042 00000000 00000002 00000000 <br>
GPR16: c02c0000 00000000 00000000 00000000 00000000 0ffaa41c c0300000 00000=
004 <br>GPR24: 00000000 00000000 c02f0000 c02f0000 df821030 00000000 df8210=
00 df821300 <br>NIP [c019074c] tsi108_open+0x5c/0x90<br>LR [c019074c] tsi10=
8_open+0x5c/0x90<br>
Call Trace:<br>[df82be30] [c019074c] tsi108_open+0x5c/0x90 (unreliable)<br>=
[df82be50] [c01b1564] dev_open+0xac/0x11c<br>[df82be70] [c01b1464] dev_chan=
ge_flags+0x160/0x1b4<br>[df82be90] [c02bc5f8] ip_auto_config+0x18c/0xe5c<br=
>
[df82bf50] [c0003c8c] do_one_initcall+0x34/0x1a8<br>[df82bfd0] [c02a1848] k=
ernel_init+0x9c/0x100<br>[df82bff0] [c0012064] kernel_thread+0x4c/0x68<br>I=
nstruction dump:<br>807f003c 7fc8f378 4beb8d71 7c7d1b79 40820028 80bf003c 3=
c60c029 7fc6f378 <br>
386327c0 90be0028 809f0040 4be90669 &lt;0fe00000&gt; 48000000 80bf003c 3c60=
c029 <br>---[ end trace dc633a1da0ecdafb ]---<br>Kernel panic - not syncing=
: Attempted to kill init!<br>Rebooting in 180 seconds.. </div>
<div>=A0</div>
<div>Regards,</div>
<div>T.</div></div><br>

--001636ed6a825de98d04718b0a6a--
