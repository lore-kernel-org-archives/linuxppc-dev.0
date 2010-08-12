Return-Path: <dceravigupta@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) by ozlabs.org (Postfix) with ESMTP id 0A2F0B70CC
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 20:25:50 +1000 (EST)
Received: by pzk30 with SMTP id 30so627854pzk.15
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 03:25:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikNt7hrxA+QR-omUiiLKVBnjqCw+HTDQh_5B5Ff@mail.gmail.com>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
	<AANLkTikNt7hrxA+QR-omUiiLKVBnjqCw+HTDQh_5B5Ff@mail.gmail.com>
Date: Thu, 12 Aug 2010 15:55:49 +0530
Message-ID: <AANLkTi=-YiWtBqCGSt-h8dd3WwTMVJcDitvROCDBEMdw@mail.gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
From: Ravi Gupta <dceravigupta@gmail.com>
To: MJ embd <mj.embd@gmail.com>
Content-Type: multipart/alternative; boundary=00163645949445c3b4048d9dcac2
Cc: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163645949445c3b4048d9dcac2
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 11, 2010 at 9:45 PM, MJ embd <mj.embd@gmail.com> wrote:

> u can directly access GPIO registers in kernel, by ioremap of GPIO
> memory mapped registers.
> you might need to check
> - muxing of gpio
>
> -mj
>

Hi MJ,

Thanks for the reply.
I tried memory mapping but it fails, here is my code :

#include <linux/module.h>
#include <linux/errno.h>    /* error codes */
#include <linux/mm.h>

void __iomem *ioaddr = NULL;

static __init int sample_module_init(void)
{
    ioaddr = ioremap(0xFF400C00, 0x24);
    if(ioaddr == NULL) {
        printk(KERN_WARNING "ioremap failed\n");
    }
    printk(KERN_WARNING "ioremap successed\n");
    printk(KERN_WARNING "GP1DIR = %u\n", ioread32(ioaddr));
    return 0;
}

static __exit void sample_module_exit(void)
{
    iounmap(ioaddr);
}

MODULE_LICENSE("GPL");
module_init(sample_module_init);
module_exit(sample_module_exit);

As per the MPC8377ERDB data sheet default IMMRBAR address is 0xFF40_0000 and
offset of GPIO1 is 0C00 and each GPIO has programmable registers that occupy
24 bytes of memory-mapped space, so I mapped from 24bytes (0x18) starting
from 0xFF40_0C00 address. But when I tried to read the values from the
mapped memory I get the following errors. Is there something I am missing.
Any help with reference to MPC8377ERDB board will be highly appreciable.

# tftp -l ~/immrbar.ko -r immrbar.ko -g 10.20.50.70
# insmod ./immrbar.ko
[  717.825241] ioremap successed
[  717.849215] Machine check in kernel mode.
[  717.853220] Caused by (from SRR1=41000): Transfer error ack signal
[  717.859405] Oops: Machine check, sig: 7 [#1]
[  717.863668] MPC837x RDB
[  717.866106] Modules linked in: immrbar(+)
[  717.870119] NIP: 00000900 LR: d1034054 CTR: c0014d50
[  717.875079] REGS: cf895d00 TRAP: 0200   Not tainted  (2.6.28.9)
[  717.880992] MSR: 00041000 <ME>  CR: 24000082  XER: 20000000
[  717.886578] TASK = cf8e8640[647] 'insmod' THREAD: cf894000
[  717.891882] GPR00: d103404c cf895db0 cf8e8640 00000000 000023d5 ffffffff
c01e
04f4 00020000
[  717.900265] GPR08: 00000001 c0383f3c 000023d5 c0014d50 4c72ff56 10019100
1007
77e0 1007ea98
[  717.908650] GPR16: 10077834 100a0000 100a0000 100a0000 bfaf4828 00000000
1009
f23c 10000cfc
[  717.917034] GPR24: 10000d00 10000d24 10012008 c03650e8 00000000 d1034000
1001
2018 d1030000
[  717.925598] NIP [00000900] 0x900
[  717.928828] LR [d1034054] sample_module_init+0x54/0xc0 [immrbar]
[  717.934828] Call Trace:
[  717.937273] [cf895db0] [d103404c] sample_module_init+0x4c/0xc0 [immrbar]
(unr
eliable)
[  717.945115] [cf895dc0] [c00038a0] do_one_initcall+0x64/0x18c
[  717.950780] [cf895f20] [c004d7b8] sys_init_module+0xac/0x19c
[  717.956441] [cf895f40] [c00122f0] ret_from_syscall+0x0/0x38
[  717.962013] --- Exception: c01 at 0x48043f6c
[  717.962017]     LR = 0x100009cc
[  717.969407] Instruction dump:
[  717.972370] 00000000 XXXXXXXX XXXXXXXX XXXXXXXX 00000000 XXXXXXXX
XXXXXXXX XX
XXXXXX
[  717.980140] 00000000 XXXXXXXX XXXXXXXX XXXXXXXX 7d5043a6 XXXXXXXX
XXXXXXXX XX
XXXXXX
[  717.987919] ---[ end trace a47be794e2873cef ]---

Thanks in advance
Ravi Gupta

--00163645949445c3b4048d9dcac2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Aug 11, 2010 at 9:45 PM, MJ embd=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:mj.embd@gmail.com">mj.embd@gmail.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-l=
eft: 1ex;">
u can directly access GPIO registers in kernel, by ioremap of GPIO<br>
memory mapped registers.<br>
you might need to check<br>
- muxing of gpio<br>
<br>
-mj<br></blockquote><div><br>Hi MJ,<br><br>Thanks for the reply.<br>I tried=
 memory mapping but it fails, here is my code :<br><br>#include &lt;linux/m=
odule.h&gt;<br>#include &lt;linux/errno.h&gt;=A0=A0=A0 /* error codes */<br=
>
#include &lt;linux/mm.h&gt;<br><br>void __iomem *ioaddr =3D NULL;<br><br>st=
atic __init int sample_module_init(void)<br>{<br>=A0=A0=A0 ioaddr =3D iorem=
ap(0xFF400C00, 0x24);<br>=A0=A0=A0 if(ioaddr =3D=3D NULL) {<br>=A0=A0=A0=A0=
=A0=A0=A0 printk(KERN_WARNING &quot;ioremap failed\n&quot;);<br>
=A0=A0=A0 }<br>=A0=A0=A0 printk(KERN_WARNING &quot;ioremap successed\n&quot=
;);<br>=A0=A0=A0 printk(KERN_WARNING &quot;GP1DIR =3D %u\n&quot;, ioread32(=
ioaddr));<br>=A0=A0=A0 return 0;<br>}<br><br>static __exit void sample_modu=
le_exit(void)<br>{<br>
=A0=A0=A0 iounmap(ioaddr);<br>}<br><br>MODULE_LICENSE(&quot;GPL&quot;);<br>=
module_init(sample_module_init);<br>module_exit(sample_module_exit);<br><br=
>As per the MPC8377ERDB data sheet default IMMRBAR address is 0xFF40_0000 a=
nd offset of GPIO1 is 0C00 and each GPIO has programmable registers that oc=
cupy 24 bytes of memory-mapped space, so I mapped from 24bytes (0x18) start=
ing from 0xFF40_0C00 address. But when I tried to read the values from the =
mapped memory I get the following errors. Is there something I am missing. =
Any help with reference to MPC8377ERDB board will be highly appreciable.<br=
>
<br># tftp -l ~/immrbar.ko -r immrbar.ko -g 10.20.50.70<br># insmod ./immrb=
ar.ko<br>[=A0 717.825241] ioremap successed<br>[=A0 717.849215] Machine che=
ck in kernel mode.<br>[=A0 717.853220] Caused by (from SRR1=3D41000): Trans=
fer error ack signal<br>
[=A0 717.859405] Oops: Machine check, sig: 7 [#1]<br>[=A0 717.863668] MPC83=
7x RDB<br>[=A0 717.866106] Modules linked in: immrbar(+)<br>[=A0 717.870119=
] NIP: 00000900 LR: d1034054 CTR: c0014d50<br>[=A0 717.875079] REGS: cf895d=
00 TRAP: 0200=A0=A0 Not tainted=A0 (2.6.28.9)<br>
[=A0 717.880992] MSR: 00041000 &lt;ME&gt;=A0 CR: 24000082=A0 XER: 20000000<=
br>[=A0 717.886578] TASK =3D cf8e8640[647] &#39;insmod&#39; THREAD: cf89400=
0<br>[=A0 717.891882] GPR00: d103404c cf895db0 cf8e8640 00000000 000023d5 f=
fffffff c01e<br>
04f4 00020000<br>[=A0 717.900265] GPR08: 00000001 c0383f3c 000023d5 c0014d5=
0 4c72ff56 10019100 1007<br>77e0 1007ea98<br>[=A0 717.908650] GPR16: 100778=
34 100a0000 100a0000 100a0000 bfaf4828 00000000 1009<br>f23c 10000cfc<br>[=
=A0 717.917034] GPR24: 10000d00 10000d24 10012008 c03650e8 00000000 d103400=
0 1001<br>
2018 d1030000<br>[=A0 717.925598] NIP [00000900] 0x900<br>[=A0 717.928828] =
LR [d1034054] sample_module_init+0x54/0xc0 [immrbar]<br>[=A0 717.934828] Ca=
ll Trace:<br>[=A0 717.937273] [cf895db0] [d103404c] sample_module_init+0x4c=
/0xc0 [immrbar] (unr<br>
eliable)<br>[=A0 717.945115] [cf895dc0] [c00038a0] do_one_initcall+0x64/0x1=
8c<br>[=A0 717.950780] [cf895f20] [c004d7b8] sys_init_module+0xac/0x19c<br>=
[=A0 717.956441] [cf895f40] [c00122f0] ret_from_syscall+0x0/0x38<br>[=A0 71=
7.962013] --- Exception: c01 at 0x48043f6c<br>
[=A0 717.962017]=A0=A0=A0=A0 LR =3D 0x100009cc<br>[=A0 717.969407] Instruct=
ion dump:<br>[=A0 717.972370] 00000000 XXXXXXXX XXXXXXXX XXXXXXXX 00000000 =
XXXXXXXX XXXXXXXX XX<br>XXXXXX<br>[=A0 717.980140] 00000000 XXXXXXXX XXXXXX=
XX XXXXXXXX 7d5043a6 XXXXXXXX XXXXXXXX XX<br>
XXXXXX<br>[=A0 717.987919] ---[ end trace a47be794e2873cef ]---<br><br>Than=
ks in advance<br>Ravi Gupta<br></div></div>

--00163645949445c3b4048d9dcac2--
