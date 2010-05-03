Return-Path: <xiaoxianghua@gmail.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 94B83B7D52
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 May 2010 00:19:55 +1000 (EST)
Received: by yxe8 with SMTP id 8so843800yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 May 2010 07:19:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <832265.7605.qm@web63002.mail.re1.yahoo.com>
References: <1272493790.24542.109.camel@pasglop>
	<832265.7605.qm@web63002.mail.re1.yahoo.com>
Date: Mon, 3 May 2010 09:19:53 -0500
Message-ID: <g2pe6bf505b1005030719r3194c665i61d0c5906e1d1254@mail.gmail.com>
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
From: Xianghua Xiao <xiaoxianghua@gmail.com>
To: Maindoor <sanjeevfiles@yahoo.com>
Content-Type: multipart/alternative; boundary=000e0cd6b2ec58627b0485b1495d
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd6b2ec58627b0485b1495d
Content-Type: text/plain; charset=UTF-8

On Sun, May 2, 2010 at 5:27 AM, Maindoor <sanjeevfiles@yahoo.com> wrote:

> Any updates on this ? I need something similar.
>
> Thanks,
> Maindoor.
>
> --- On *Thu, 4/29/10, Benjamin Herrenschmidt <benh@kernel.crashing.org>*wrote:
>
>
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
> To: "Xianghua Xiao" <xiaoxianghua@gmail.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
> Date: Thursday, April 29, 2010, 3:59 AM
>
> On Wed, 2010-04-28 at 14:15 -0500, Xianghua Xiao wrote:
> > This change works me on a 834x(e300) platform, tested with lmbench and
> > a production-ready application with 2.6.33.3.
>
> But have you tested that DEBUG_PAGEALLOC actually works ? :-)
>
> A way to do that is to
>
>     - get_free_pages a page
>     - read from it
>     - free it
>     - write to it
>
> It should oops on the write, and I suspect that without my patch it
> doesn't.
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org<http://mc/compose?to=Linuxppc-dev@lists.ozlabs.org>
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
> Ok here is the test result I did this morning, in short with/without Ben's
patch it will oops if you write to a freed page.

1. With DEBUG_PAGEALLOC on, after applied Ben's patch and wrote to a freed
page, it will oops:
--------------------------------------
Read from allocated page
Write to freed page
Unable to handle kernel paging request for data at address 0xce33c000
Faulting instruction address: 0xd004d07c
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT DEBUG_PAGEALLOC 834x SYS
Modules linked in: e300page(+)
NIP: d004d07c LR: d004d074 CTR: 00000001
REGS: cf231e30 TRAP: 0300   Not tainted  (2.6.33.3-rt17)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24000422  XER: 20000000
DAR: ce33c000, DSISR: 22000000
TASK = ce312e10[1395] 'insmod' THREAD: cf230000
GPR00: 00000061 cf231ee0 ce312e10 0000001a 00003b0d ffffffff c047c4d6
00004000
GPR08: c047c8c4 ce33c000 00003fff ce312e10 24000422 100bbc1c 0fffd000
ffffffff
GPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0 00000000
100b90a0
GPR24: 4800e4ac bfd2ff80 c043d388 00000000 d004d000 c0480000 cf230000
d0050000
NIP [d004d07c] e300page_init+0x7c/0xb8 [e300page]
LR [d004d074] e300page_init+0x74/0xb8 [e300page]
Call Trace:
[cf231ee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (unreliable)
[cf231ef0] [c00038b4] do_one_initcall+0x54/0x210
[cf231f20] [c0058ba4] sys_init_module+0x120/0x240
[cf231f40] [c0012afc] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xfe5baa0
    LR = 0x10027de0
Instruction dump:
4e800020 3c60d005 3863a094 48000031 807fa214 38800000 48000045 3c60d005
3863a0b4 48000019 813fa214 38000061 <98090000> 4bffffb8 00000000 3d60c035
---[ end trace 4b412bd05f6f6d8d ]---

# rmmod e300page
rmmod: e300page: Device or resource busy

2. Without Ben's patch, there is also oops observed:
# insmod ./e300page.ko
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT DEBUG_PAGEALLOC 834x SYS
Modules linked in: e300page(+)
NIP: d004d07c LR: d004d074 CTR: 00000001
REGS: ce30be30 TRAP: 0300   Not tainted  (2.6.33.3-rt17)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22000422  XER: 20000000
DAR: ce172000, DSISR: 22000000
TASK = ce306120[1392] 'insmod' THREAD: ce30a000
GPR00: 00000061 ce30bee0 ce306120 0000001a 00003b0d ffffffff c047c4d6
00004000
GPR08: c047c8c4 ce172000 00003fff ce306120 22000422 100bbc1c 0fffd000
ffffffff
GPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0 00000000
100b90a0
GPR24: 4800e4ac bf876f10 c043d388 00000000 d004d000 c0480000 ce30a000
d0050000
NIP [d004d07c] e300page_init+0x7c/0xb8 [e300page]
LR [d004d074] e300page_init+0x74/0xb8 [e300page]
Call Trace:
[ce30bee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (unreliable)
[ce30bef0] [c00038b4] do_one_initcall+0x54/0x210
[ce30bf20] [c0058bb0] sys_init_module+0x120/0x240
[ce30bf40] [c0012afc] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xfe5baa0
    LR = 0x10027de0
Instruction dump:
4e800020 3c60d005 3863a094 48000031 807fa214 38800000 48000045 3c60d005
3863a0b4 48000019 813fa214 38000061 <98090000> 4bffffb8 00000000 3d60c035
---[ end trace a05c5135ddb62734 ]---
Segmentation fault

Checking dmesg(where you can see the printk msg from the module):
Read from allocated page
Write to freed page
Unable to handle kernel paging request for data at address 0xce172000
Faulting instruction address: 0xd004d07c
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT DEBUG_PAGEALLOC 834x SYS
Modules linked in: e300page(+)
NIP: d004d07c LR: d004d074 CTR: 00000001
REGS: ce30be30 TRAP: 0300   Not tainted  (2.6.33.3-rt17)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22000422  XER: 20000000
DAR: ce172000, DSISR: 22000000
TASK = ce306120[1392] 'insmod' THREAD: ce30a000
GPR00: 00000061 ce30bee0 ce306120 0000001a 00003b0d ffffffff c047c4d6
00004000
GPR08: c047c8c4 ce172000 00003fff ce306120 22000422 100bbc1c 0fffd000
ffffffff
GPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0 00000000
100b90a0
GPR24: 4800e4ac bf876f10 c043d388 00000000 d004d000 c0480000 ce30a000
d0050000
NIP [d004d07c] e300page_init+0x7c/0xb8 [e300page]
LR [d004d074] e300page_init+0x74/0xb8 [e300page]
Call Trace:
[ce30bee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (unreliable)
[ce30bef0] [c00038b4] do_one_initcall+0x54/0x210
[ce30bf20] [c0058bb0] sys_init_module+0x120/0x240
[ce30bf40] [c0012afc] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xfe5baa0
    LR = 0x10027de0
Instruction dump:
4e800020 3c60d005 3863a094 48000031 807fa214 38800000 48000045 3c60d005
3863a0b4 48000019 813fa214 38000061 <98090000> 4bffffb8 00000000 3d60c035
---[ end trace a05c5135ddb62734 ]---

# lsmod
Module                  Size  Used by    Tainted: G
e300page                1549  1
# rmmod e300page
rmmod: e300page: Device or resource busy

Module source is below:
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/init.h>

static int __init e300page_init (void)
{
        static char *kpage;
        char ch;

        if (!(kpage = (char *)__get_free_pages (GFP_KERNEL, 0))) {
                printk (KERN_ERR " __get_free_pages failed\n");
                return 0;
        }

        printk(KERN_INFO "Read from allocated page\n");
        ch = kpage[0];
        free_pages ((unsigned long)kpage, 0);
        printk(KERN_INFO "Write to freed page\n");
        kpage[0]='a';

        return 0;
}
static void __exit e300page_exit (void)
{
        printk (KERN_INFO "e300page exiting\n");
}

module_init (e300page_init);
module_exit (e300page_exit);

MODULE_AUTHOR ("Xianghua Xiao");
MODULE_DESCRIPTION ("Test PageAlloc on e300");
MODULE_LICENSE ("GPL v2");

--000e0cd6b2ec58627b0485b1495d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sun, May 2, 2010 at 5:27 AM, Maindoor <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:sanjeevfiles@yahoo.com">sanjeevfiles@yahoo=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td styl=
e=3D"font-family: inherit; font-style: inherit; font-variant: inherit; font=
-weight: inherit; font-size: inherit; line-height: inherit; font-size-adjus=
t: inherit; font-stretch: inherit;" valign=3D"top">
Any updates on this ? I need something similar.<br><br>Thanks,<br>Maindoor.=
<br><br>--- On <b>Thu, 4/29/10, Benjamin Herrenschmidt <i>&lt;<a href=3D"ma=
ilto:benh@kernel.crashing.org" target=3D"_blank">benh@kernel.crashing.org</=
a>&gt;</i></b> wrote:<br>
<blockquote style=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: =
5px; padding-left: 5px;"><br>From: Benjamin Herrenschmidt &lt;<a href=3D"ma=
ilto:benh@kernel.crashing.org" target=3D"_blank">benh@kernel.crashing.org</=
a>&gt;<br>
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300<br>To: &quot;Xianghua =
Xiao&quot; &lt;<a href=3D"mailto:xiaoxianghua@gmail.com" target=3D"_blank">=
xiaoxianghua@gmail.com</a>&gt;<br>Cc: &quot;linuxppc-dev&quot; &lt;<a href=
=3D"mailto:linuxppc-dev@lists.ozlabs.org" target=3D"_blank">linuxppc-dev@li=
sts.ozlabs.org</a>&gt;<br>
Date: Thursday, April 29, 2010, 3:59 AM<br><br><div>On Wed, 2010-04-28 at 1=
4:15 -0500, Xianghua Xiao wrote:<br>&gt; This change works me on a 834x(e30=
0) platform, tested with lmbench and<br>&gt; a production-ready application=
 with 2.6.33.3.<br>
<br>But have you tested that DEBUG_PAGEALLOC actually works ? :-)<br><br>A =
way to do that
 is to<br><br>=C2=A0=C2=A0=C2=A0 - get_free_pages a page<br>=C2=A0=C2=A0=C2=
=A0 - read from it<br>=C2=A0=C2=A0=C2=A0 - free it<br>=C2=A0=C2=A0=C2=A0 - =
write to it<br><br>It should oops on the write, and I suspect that without =
my patch it<br>doesn&#39;t.<br><br>Cheers,<br>Ben.<br><br>
<br>_______________________________________________<br>Linuxppc-dev mailing=
 list<br><a href=3D"http://mc/compose?to=3DLinuxppc-dev@lists.ozlabs.org" t=
arget=3D"_blank">Linuxppc-dev@lists.ozlabs.org</a><br><a href=3D"https://li=
sts.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank">https://lists.ozlab=
s.org/listinfo/linuxppc-dev</a><br>
</div></blockquote></td></tr></tbody></table><br></blockquote><div>Ok here =
is the test result I did this morning, in short with/without Ben&#39;s patc=
h it will oops if you write to a freed page.<br><br>1. With DEBUG_PAGEALLOC=
 on, after applied Ben&#39;s patch and wrote to a freed page, it will oops:=
<br>
--------------------------------------<br>Read from allocated page<br>Write=
 to freed page<br>Unable to handle kernel paging request for data at addres=
s 0xce33c000<br>Faulting instruction address: 0xd004d07c<br>Oops: Kernel ac=
cess of bad area, sig: 11 [#1]<br>
PREEMPT DEBUG_PAGEALLOC 834x SYS<br>Modules linked in: e300page(+)<br>NIP: =
d004d07c LR: d004d074 CTR: 00000001<br>REGS: cf231e30 TRAP: 0300=C2=A0=C2=
=A0 Not tainted=C2=A0 (2.6.33.3-rt17)<br>MSR: 00009032 &lt;EE,ME,IR,DR&gt;=
=C2=A0 CR: 24000422=C2=A0 XER: 20000000<br>
DAR: ce33c000, DSISR: 22000000<br>TASK =3D ce312e10[1395] &#39;insmod&#39; =
THREAD: cf230000<br>GPR00: 00000061 cf231ee0 ce312e10 0000001a 00003b0d fff=
fffff c047c4d6 00004000 <br>GPR08: c047c8c4 ce33c000 00003fff ce312e10 2400=
0422 100bbc1c 0fffd000 ffffffff <br>
GPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0 00000000 100b9=
0a0 <br>GPR24: 4800e4ac bfd2ff80 c043d388 00000000 d004d000 c0480000 cf2300=
00 d0050000 <br>NIP [d004d07c] e300page_init+0x7c/0xb8 [e300page]<br>LR [d0=
04d074] e300page_init+0x74/0xb8 [e300page]<br>
Call Trace:<br>[cf231ee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (un=
reliable)<br>[cf231ef0] [c00038b4] do_one_initcall+0x54/0x210<br>[cf231f20]=
 [c0058ba4] sys_init_module+0x120/0x240<br>[cf231f40] [c0012afc] ret_from_s=
yscall+0x0/0x38<br>
--- Exception: c01 at 0xfe5baa0<br>=C2=A0=C2=A0=C2=A0 LR =3D 0x10027de0<br>=
Instruction dump:<br>4e800020 3c60d005 3863a094 48000031 807fa214 38800000 =
48000045 3c60d005 <br>3863a0b4 48000019 813fa214 38000061 &lt;98090000&gt; =
4bffffb8 00000000 3d60c035 <br>
---[ end trace 4b412bd05f6f6d8d ]---<br><br># rmmod e300page<br>rmmod: e300=
page: Device or resource busy<br><br>2. Without Ben&#39;s patch, there is a=
lso oops observed:<br># insmod ./e300page.ko <br>Oops: Kernel access of bad=
 area, sig: 11 [#1]<br>
PREEMPT DEBUG_PAGEALLOC 834x SYS<br>Modules linked in: e300page(+)<br>NIP: =
d004d07c LR: d004d074 CTR: 00000001<br>REGS: ce30be30 TRAP: 0300=C2=A0=C2=
=A0 Not tainted=C2=A0 (2.6.33.3-rt17)<br>MSR: 00009032 &lt;EE,ME,IR,DR&gt;=
=C2=A0 CR: 22000422=C2=A0 XER: 20000000<br>
DAR: ce172000, DSISR: 22000000<br>TASK =3D ce306120[1392] &#39;insmod&#39; =
THREAD: ce30a000<br>GPR00: 00000061 ce30bee0 ce306120 0000001a 00003b0d fff=
fffff c047c4d6 00004000 <br>GPR08: c047c8c4 ce172000 00003fff ce306120 2200=
0422 100bbc1c 0fffd000 ffffffff <br>
GPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0 00000000 100b9=
0a0 <br>GPR24: 4800e4ac bf876f10 c043d388 00000000 d004d000 c0480000 ce30a0=
00 d0050000 <br>NIP [d004d07c] e300page_init+0x7c/0xb8 [e300page]<br>LR [d0=
04d074] e300page_init+0x74/0xb8 [e300page]<br>
Call Trace:<br>[ce30bee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (un=
reliable)<br>[ce30bef0] [c00038b4] do_one_initcall+0x54/0x210<br>[ce30bf20]=
 [c0058bb0] sys_init_module+0x120/0x240<br>[ce30bf40] [c0012afc] ret_from_s=
yscall+0x0/0x38<br>
--- Exception: c01 at 0xfe5baa0<br>=C2=A0=C2=A0=C2=A0 LR =3D 0x10027de0<br>=
Instruction dump:<br>4e800020 3c60d005 3863a094 48000031 807fa214 38800000 =
48000045 3c60d005 <br>3863a0b4 48000019 813fa214 38000061 &lt;98090000&gt; =
4bffffb8 00000000 3d60c035 <br>
---[ end trace a05c5135ddb62734 ]---<br>Segmentation fault<br><br>Checking =
dmesg(where you can see the printk msg from the module):<br>Read from alloc=
ated page<br>Write to freed page<br>Unable to handle kernel paging request =
for data at address 0xce172000<br>
Faulting instruction address: 0xd004d07c<br>Oops: Kernel access of bad area=
, sig: 11 [#1]<br>PREEMPT DEBUG_PAGEALLOC 834x SYS<br>Modules linked in: e3=
00page(+)<br>NIP: d004d07c LR: d004d074 CTR: 00000001<br>REGS: ce30be30 TRA=
P: 0300=C2=A0=C2=A0 Not tainted=C2=A0 (2.6.33.3-rt17)<br>
MSR: 00009032 &lt;EE,ME,IR,DR&gt;=C2=A0 CR: 22000422=C2=A0 XER: 20000000<br=
>DAR: ce172000, DSISR: 22000000<br>TASK =3D ce306120[1392] &#39;insmod&#39;=
 THREAD: ce30a000<br>GPR00: 00000061 ce30bee0 ce306120 0000001a 00003b0d ff=
ffffff c047c4d6 00004000 <br>
GPR08: c047c8c4 ce172000 00003fff ce306120 22000422 100bbc1c 0fffd000 fffff=
fff <br>GPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0 000000=
00 100b90a0 <br>GPR24: 4800e4ac bf876f10 c043d388 00000000 d004d000 c048000=
0 ce30a000 d0050000 <br>
NIP [d004d07c] e300page_init+0x7c/0xb8 [e300page]<br>LR [d004d074] e300page=
_init+0x74/0xb8 [e300page]<br>Call Trace:<br>[ce30bee0] [d004d074] e300page=
_init+0x74/0xb8 [e300page] (unreliable)<br>[ce30bef0] [c00038b4] do_one_ini=
tcall+0x54/0x210<br>
[ce30bf20] [c0058bb0] sys_init_module+0x120/0x240<br>[ce30bf40] [c0012afc] =
ret_from_syscall+0x0/0x38<br>--- Exception: c01 at 0xfe5baa0<br>=C2=A0=C2=
=A0=C2=A0 LR =3D 0x10027de0<br>Instruction dump:<br>4e800020 3c60d005 3863a=
094 48000031 807fa214 38800000 48000045 3c60d005 <br>
3863a0b4 48000019 813fa214 38000061 &lt;98090000&gt; 4bffffb8 00000000 3d60=
c035 <br>---[ end trace a05c5135ddb62734 ]---<br><br># lsmod<br>Module=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used by=C2=A0=C2=A0=C2=A0 Tainted: G=C2=
=A0 <br>e300page=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1549=C2=A0 1 <br>
# rmmod e300page<br>rmmod: e300page: Device or resource busy<br><br>Module =
source is below:<br>#include &lt;linux/module.h&gt;<br>#include &lt;linux/s=
lab.h&gt;<br>#include &lt;linux/init.h&gt;<br><br>static int __init e300pag=
e_init (void)<br>
{<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static char *kpage;<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char ch;<br><br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (!(kpage =3D (char *)__get_free_pages (GFP_KERN=
EL, 0))) {<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk (KERN_ERR &quot; __get_free_pages fai=
led\n&quot;);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br><br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 printk(KERN_INFO &quot;Read from allocated page\n&quo=
t;);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch =3D kpage[0];<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_pages ((unsigned long)kpage, 0=
);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk(KERN_INFO &quot;Wri=
te to freed page\n&quot;);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kpage[0]=3D&#39;a&#39;;<br><br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>}<br>static void __=
exit e300page_exit (void)<br>{<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 printk (KERN_INFO &quot;e300page exiting\n&quot;);<br>}<br><br>module_i=
nit (e300page_init);<br>module_exit (e300page_exit);<br>
<br>MODULE_AUTHOR (&quot;Xianghua Xiao&quot;);<br>MODULE_DESCRIPTION (&quot=
;Test PageAlloc on e300&quot;);<br>MODULE_LICENSE (&quot;GPL v2&quot;);<br>=
<br></div></div>

--000e0cd6b2ec58627b0485b1495d--
