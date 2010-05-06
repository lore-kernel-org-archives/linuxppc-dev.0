Return-Path: <sanjeevfiles@yahoo.com>
Received: from web63002.mail.re1.yahoo.com (web63002.mail.re1.yahoo.com
	[69.147.96.213]) by ozlabs.org (Postfix) with SMTP id 6DA52B7D52
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 May 2010 18:23:24 +1000 (EST)
Message-ID: <250576.54231.qm@web63002.mail.re1.yahoo.com>
Date: Thu, 6 May 2010 01:23:22 -0700 (PDT)
From: Maindoor <sanjeevfiles@yahoo.com>
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
To: Xianghua Xiao <xiaoxianghua@gmail.com>
In-Reply-To: <g2pe6bf505b1005030719r3194c665i61d0c5906e1d1254@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-636872414-1273134202=:54231"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-636872414-1273134202=:54231
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I'm not sure how good of a test this is. I tried the same thing and it seem=
s to workimmediately ie. it gives an oops as soon as "I change the attribut=
e and write to thepage". But when I try to write to it at a later stage as =
part of an ioctl or after about5 mins, this feature does not seem to work.=
=A0What if the page is brought in again due to a fault, does the attribute =
remain=A0the =A0same ? How can I verify this ?=A0
RegardsMaindoor.



--- On Mon, 5/3/10, Xianghua Xiao <xiaoxianghua@gmail.com> wrote:

From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
To: "Maindoor" <sanjeevfiles@yahoo.com>
Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Date: Monday, May 3, 2010, 7:49 PM

On Sun, May 2, 2010 at 5:27 AM, Maindoor <sanjeevfiles@yahoo.com> wrote:
=0A=0AAny updates on this ? I need something similar.

Thanks,
Maindoor.

--- On Thu, 4/29/10, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrot=
e:
=0A
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
=0ASubject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
To: "Xianghua Xiao" <xiaoxianghua@gmail.com>
Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
=0ADate: Thursday, April 29, 2010, 3:59 AM

On Wed, 2010-04-28 at 14:15 -0500, Xianghua Xiao wrote:
> This change works me on a 834x(e300) platform, tested with lmbench and
> a production-ready application with 2.6.33.3.
=0A
But have you tested that DEBUG_PAGEALLOC actually works ? :-)

A way to do that=0A is to

=A0=A0=A0 - get_free_pages a page
=A0=A0=A0 - read from it
=A0=A0=A0 - free it
=A0=A0=A0 - write to it

It should oops on the write, and I suspect that without my patch it
doesn't.

Cheers,
Ben.

=0A
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
=0A
Ok here is the test result I did this morning, in short with/without Ben's =
patch it will oops if you write to a freed page.

1. With DEBUG_PAGEALLOC on, after applied Ben's patch and wrote to a freed =
page, it will oops:
=0A--------------------------------------
Read from allocated page
Write to freed page
Unable to handle kernel paging request for data at address 0xce33c000
Faulting instruction address: 0xd004d07c
Oops: Kernel access of bad area, sig: 11 [#1]
=0APREEMPT DEBUG_PAGEALLOC 834x SYS
Modules linked in: e300page(+)
NIP: d004d07c LR: d004d074 CTR: 00000001
REGS: cf231e30 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.33.3-rt17)
MSR: 00009032 <EE,ME,IR,DR>=A0 CR: 24000422=A0 XER: 20000000
=0ADAR: ce33c000, DSISR: 22000000
TASK =3D ce312e10[1395] 'insmod' THREAD: cf230000
GPR00: 00000061 cf231ee0 ce312e10 0000001a 00003b0d ffffffff c047c4d6 00004=
000=20
GPR08: c047c8c4 ce33c000 00003fff ce312e10 24000422 100bbc1c 0fffd000 fffff=
fff=20
=0AGPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0 00000000 10=
0b90a0=20
GPR24: 4800e4ac bfd2ff80 c043d388 00000000 d004d000 c0480000 cf230000 d0050=
000=20
NIP [d004d07c] e300page_init+0x7c/0xb8 [e300page]
LR [d004d074] e300page_init+0x74/0xb8 [e300page]
=0ACall Trace:
[cf231ee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (unreliable)
[cf231ef0] [c00038b4] do_one_initcall+0x54/0x210
[cf231f20] [c0058ba4] sys_init_module+0x120/0x240
[cf231f40] [c0012afc] ret_from_syscall+0x0/0x38
=0A--- Exception: c01 at 0xfe5baa0
=A0=A0=A0 LR =3D 0x10027de0
Instruction dump:
4e800020 3c60d005 3863a094 48000031 807fa214 38800000 48000045 3c60d005=20
3863a0b4 48000019 813fa214 38000061 <98090000> 4bffffb8 00000000 3d60c035=
=20
=0A---[ end trace 4b412bd05f6f6d8d ]---

# rmmod e300page
rmmod: e300page: Device or resource busy

2. Without Ben's patch, there is also oops observed:
# insmod ./e300page.ko=20
Oops: Kernel access of bad area, sig: 11 [#1]
=0APREEMPT DEBUG_PAGEALLOC 834x SYS
Modules linked in: e300page(+)
NIP: d004d07c LR: d004d074 CTR: 00000001
REGS: ce30be30 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.33.3-rt17)
MSR: 00009032 <EE,ME,IR,DR>=A0 CR: 22000422=A0 XER: 20000000
=0ADAR: ce172000, DSISR: 22000000
TASK =3D ce306120[1392] 'insmod' THREAD: ce30a000
GPR00: 00000061 ce30bee0 ce306120 0000001a 00003b0d ffffffff c047c4d6 00004=
000=20
GPR08: c047c8c4 ce172000 00003fff ce306120 22000422 100bbc1c 0fffd000 fffff=
fff=20
=0AGPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0 00000000 10=
0b90a0=20
GPR24: 4800e4ac bf876f10 c043d388 00000000 d004d000 c0480000 ce30a000 d0050=
000=20
NIP [d004d07c] e300page_init+0x7c/0xb8 [e300page]
LR [d004d074] e300page_init+0x74/0xb8 [e300page]
=0ACall Trace:
[ce30bee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (unreliable)
[ce30bef0] [c00038b4] do_one_initcall+0x54/0x210
[ce30bf20] [c0058bb0] sys_init_module+0x120/0x240
[ce30bf40] [c0012afc] ret_from_syscall+0x0/0x38
=0A--- Exception: c01 at 0xfe5baa0
=A0=A0=A0 LR =3D 0x10027de0
Instruction dump:
4e800020 3c60d005 3863a094 48000031 807fa214 38800000 48000045 3c60d005=20
3863a0b4 48000019 813fa214 38000061 <98090000> 4bffffb8 00000000 3d60c035=
=20
=0A---[ end trace a05c5135ddb62734 ]---
Segmentation fault

Checking dmesg(where you can see the printk msg from the module):
Read from allocated page
Write to freed page
Unable to handle kernel paging request for data at address 0xce172000
=0AFaulting instruction address: 0xd004d07c
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT DEBUG_PAGEALLOC 834x SYS
Modules linked in: e300page(+)
NIP: d004d07c LR: d004d074 CTR: 00000001
REGS: ce30be30 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.33.3-rt17)
=0AMSR: 00009032 <EE,ME,IR,DR>=A0 CR: 22000422=A0 XER: 20000000
DAR: ce172000, DSISR: 22000000
TASK =3D ce306120[1392] 'insmod' THREAD: ce30a000
GPR00: 00000061 ce30bee0 ce306120 0000001a 00003b0d ffffffff c047c4d6 00004=
000=20
=0AGPR08: c047c8c4 ce172000 00003fff ce306120 22000422 100bbc1c 0fffd000 ff=
ffffff=20
GPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0 00000000 100b9=
0a0=20
GPR24: 4800e4ac bf876f10 c043d388 00000000 d004d000 c0480000 ce30a000 d0050=
000=20
=0ANIP [d004d07c] e300page_init+0x7c/0xb8 [e300page]
LR [d004d074] e300page_init+0x74/0xb8 [e300page]
Call Trace:
[ce30bee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (unreliable)
[ce30bef0] [c00038b4] do_one_initcall+0x54/0x210
=0A[ce30bf20] [c0058bb0] sys_init_module+0x120/0x240
[ce30bf40] [c0012afc] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xfe5baa0
=A0=A0=A0 LR =3D 0x10027de0
Instruction dump:
4e800020 3c60d005 3863a094 48000031 807fa214 38800000 48000045 3c60d005=20
=0A3863a0b4 48000019 813fa214 38000061 <98090000> 4bffffb8 00000000 3d60c03=
5=20
---[ end trace a05c5135ddb62734 ]---

# lsmod
Module=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Size=A0 Used by=
=A0=A0=A0 Tainted: G=A0=20
e300page=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1549=A0 1=20
=0A# rmmod e300page
rmmod: e300page: Device or resource busy

Module source is below:
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/init.h>

static int __init e300page_init (void)
=0A{
=A0=A0=A0=A0=A0=A0=A0 static char *kpage;
=A0=A0=A0=A0=A0=A0=A0 char ch;

=A0=A0=A0=A0=A0=A0=A0 if (!(kpage =3D (char *)__get_free_pages (GFP_KERNEL,=
 0))) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk (KERN_ERR " __get_free=
_pages failed\n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
=0A=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0 printk(KERN_INFO "Read from allocated page\n");
=A0=A0=A0=A0=A0=A0=A0 ch =3D kpage[0];
=A0=A0=A0=A0=A0=A0=A0 free_pages ((unsigned long)kpage, 0);
=A0=A0=A0=A0=A0=A0=A0 printk(KERN_INFO "Write to freed page\n");
=0A=A0=A0=A0=A0=A0=A0=A0 kpage[0]=3D'a';

=A0=A0=A0=A0=A0=A0=A0 return 0;
}
static void __exit e300page_exit (void)
{
=A0=A0=A0=A0=A0=A0=A0 printk (KERN_INFO "e300page exiting\n");
}

module_init (e300page_init);
module_exit (e300page_exit);
=0A
MODULE_AUTHOR ("Xianghua Xiao");
MODULE_DESCRIPTION ("Test PageAlloc on e300");
MODULE_LICENSE ("GPL v2");

=0A
-----Inline Attachment Follows-----

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev=0A=0A=0A      
--0-636872414-1273134202=:54231
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">I'm not sure how good of a test this is. I tr=
ied the same thing and it seems to work<div>immediately ie. it gives an oop=
s as soon as "I change the attribute and write to the</div><div>page". But =
when I try to write to it at a later stage as part of an ioctl or after abo=
ut</div><div>5 mins, this feature does not seem to work.&nbsp;</div><div>Wh=
at if the page is brought in again due to a fault, does the attribute remai=
n&nbsp;</div><div>the &nbsp;same ? How can I verify this ?&nbsp;</div><div>=
<br></div><div>Regards</div><div>Maindoor.</div><div><br></div><div><br><br=
><div><br>--- On <b>Mon, 5/3/10, Xianghua Xiao <i>&lt;xiaoxianghua@gmail.co=
m&gt;</i></b> wrote:<br><blockquote style=3D"border-left: 2px solid rgb(16,=
 16, 255); margin-left: 5px; padding-left: 5px;"><br>From: Xianghua Xiao &l=
t;xiaoxianghua@gmail.com&gt;<br>Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on
 603/e300<br>To: "Maindoor" &lt;sanjeevfiles@yahoo.com&gt;<br>Cc: "linuxppc=
-dev" &lt;linuxppc-dev@lists.ozlabs.org&gt;<br>Date: Monday, May 3, 2010, 7=
:49 PM<br><br><div id=3D"yiv1471012639"><div class=3D"gmail_quote">On Sun, =
May 2, 2010 at 5:27 AM, Maindoor <span dir=3D"ltr">&lt;<a rel=3D"nofollow" =
ymailto=3D"mailto:sanjeevfiles@yahoo.com" target=3D"_blank" href=3D"/mc/com=
pose?to=3Dsanjeevfiles@yahoo.com">sanjeevfiles@yahoo.com</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"border-left:1px solid rgb=
(204, 204, 204);margin:0pt 0pt 0pt 0.8ex;padding-left:1ex;">=0A<table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td style=3D"font-fa=
mily:inherit;font-style:inherit;font-variant:inherit;font-weight:inherit;fo=
nt-size:inherit;line-height:inherit;font-size-adjust:inherit;font-stretch:i=
nherit;" valign=3D"top">=0AAny updates on this ? I need something similar.<=
br><br>Thanks,<br>Maindoor.<br><br>--- On <b>Thu, 4/29/10, Benjamin Herrens=
chmidt <i>&lt;<a rel=3D"nofollow" ymailto=3D"mailto:benh@kernel.crashing.or=
g" target=3D"_blank" href=3D"/mc/compose?to=3Dbenh@kernel.crashing.org">ben=
h@kernel.crashing.org</a>&gt;</i></b> wrote:<br>=0A<blockquote style=3D"bor=
der-left:2px solid rgb(16, 16, 255);margin-left:5px;padding-left:5px;"><br>=
From: Benjamin Herrenschmidt &lt;<a rel=3D"nofollow" ymailto=3D"mailto:benh=
@kernel.crashing.org" target=3D"_blank" href=3D"/mc/compose?to=3Dbenh@kerne=
l.crashing.org">benh@kernel.crashing.org</a>&gt;<br>=0ASubject: Re: [PATCH]=
 Fix DEBUG_PAGEALLOC on 603/e300<br>To: "Xianghua Xiao" &lt;<a rel=3D"nofol=
low" ymailto=3D"mailto:xiaoxianghua@gmail.com" target=3D"_blank" href=3D"/m=
c/compose?to=3Dxiaoxianghua@gmail.com">xiaoxianghua@gmail.com</a>&gt;<br>Cc=
: "linuxppc-dev" &lt;<a rel=3D"nofollow" ymailto=3D"mailto:linuxppc-dev@lis=
ts.ozlabs.org" target=3D"_blank" href=3D"/mc/compose?to=3Dlinuxppc-dev@list=
s.ozlabs.org">linuxppc-dev@lists.ozlabs.org</a>&gt;<br>=0ADate: Thursday, A=
pril 29, 2010, 3:59 AM<br><br><div>On Wed, 2010-04-28 at 14:15 -0500, Xiang=
hua Xiao wrote:<br>&gt; This change works me on a 834x(e300) platform, test=
ed with lmbench and<br>&gt; a production-ready application with 2.6.33.3.<b=
r>=0A<br>But have you tested that DEBUG_PAGEALLOC actually works ? :-)<br><=
br>A way to do that=0A is to<br><br>&nbsp;&nbsp;&nbsp; - get_free_pages a p=
age<br>&nbsp;&nbsp;&nbsp; - read from it<br>&nbsp;&nbsp;&nbsp; - free it<br=
>&nbsp;&nbsp;&nbsp; - write to it<br><br>It should oops on the write, and I=
 suspect that without my patch it<br>doesn't.<br><br>Cheers,<br>Ben.<br><br=
>=0A<br>_______________________________________________<br>Linuxppc-dev mai=
ling list<br><a rel=3D"nofollow" target=3D"_blank" href=3D"http://mc/compos=
e?to=3DLinuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a><br>=
<a rel=3D"nofollow" target=3D"_blank" href=3D"https://lists.ozlabs.org/list=
info/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>=
=0A</div></blockquote></td></tr></tbody></table><br></blockquote><div>Ok he=
re is the test result I did this morning, in short with/without Ben's patch=
 it will oops if you write to a freed page.<br><br>1. With DEBUG_PAGEALLOC =
on, after applied Ben's patch and wrote to a freed page, it will oops:<br>=
=0A--------------------------------------<br>Read from allocated page<br>Wr=
ite to freed page<br>Unable to handle kernel paging request for data at add=
ress 0xce33c000<br>Faulting instruction address: 0xd004d07c<br>Oops: Kernel=
 access of bad area, sig: 11 [#1]<br>=0APREEMPT DEBUG_PAGEALLOC 834x SYS<br=
>Modules linked in: e300page(+)<br>NIP: d004d07c LR: d004d074 CTR: 00000001=
<br>REGS: cf231e30 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.33.3-rt17)=
<br>MSR: 00009032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 24000422&nbsp; XER: 2000000=
0<br>=0ADAR: ce33c000, DSISR: 22000000<br>TASK =3D ce312e10[1395] 'insmod' =
THREAD: cf230000<br>GPR00: 00000061 cf231ee0 ce312e10 0000001a 00003b0d fff=
fffff c047c4d6 00004000 <br>GPR08: c047c8c4 ce33c000 00003fff ce312e10 2400=
0422 100bbc1c 0fffd000 ffffffff <br>=0AGPR16: 00000001 00000000 007fff00 00=
000000 00000000 0fffa1a0 00000000 100b90a0 <br>GPR24: 4800e4ac bfd2ff80 c04=
3d388 00000000 d004d000 c0480000 cf230000 d0050000 <br>NIP [d004d07c] e300p=
age_init+0x7c/0xb8 [e300page]<br>LR [d004d074] e300page_init+0x74/0xb8 [e30=
0page]<br>=0ACall Trace:<br>[cf231ee0] [d004d074] e300page_init+0x74/0xb8 [=
e300page] (unreliable)<br>[cf231ef0] [c00038b4] do_one_initcall+0x54/0x210<=
br>[cf231f20] [c0058ba4] sys_init_module+0x120/0x240<br>[cf231f40] [c0012af=
c] ret_from_syscall+0x0/0x38<br>=0A--- Exception: c01 at 0xfe5baa0<br>&nbsp=
;&nbsp;&nbsp; LR =3D 0x10027de0<br>Instruction dump:<br>4e800020 3c60d005 3=
863a094 48000031 807fa214 38800000 48000045 3c60d005 <br>3863a0b4 48000019 =
813fa214 38000061 &lt;98090000&gt; 4bffffb8 00000000 3d60c035 <br>=0A---[ e=
nd trace 4b412bd05f6f6d8d ]---<br><br># rmmod e300page<br>rmmod: e300page: =
Device or resource busy<br><br>2. Without Ben's patch, there is also oops o=
bserved:<br># insmod ./e300page.ko <br>Oops: Kernel access of bad area, sig=
: 11 [#1]<br>=0APREEMPT DEBUG_PAGEALLOC 834x SYS<br>Modules linked in: e300=
page(+)<br>NIP: d004d07c LR: d004d074 CTR: 00000001<br>REGS: ce30be30 TRAP:=
 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.33.3-rt17)<br>MSR: 00009032 &lt;EE=
,ME,IR,DR&gt;&nbsp; CR: 22000422&nbsp; XER: 20000000<br>=0ADAR: ce172000, D=
SISR: 22000000<br>TASK =3D ce306120[1392] 'insmod' THREAD: ce30a000<br>GPR0=
0: 00000061 ce30bee0 ce306120 0000001a 00003b0d ffffffff c047c4d6 00004000 =
<br>GPR08: c047c8c4 ce172000 00003fff ce306120 22000422 100bbc1c 0fffd000 f=
fffffff <br>=0AGPR16: 00000001 00000000 007fff00 00000000 00000000 0fffa1a0=
 00000000 100b90a0 <br>GPR24: 4800e4ac bf876f10 c043d388 00000000 d004d000 =
c0480000 ce30a000 d0050000 <br>NIP [d004d07c] e300page_init+0x7c/0xb8 [e300=
page]<br>LR [d004d074] e300page_init+0x74/0xb8 [e300page]<br>=0ACall Trace:=
<br>[ce30bee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (unreliable)<b=
r>[ce30bef0] [c00038b4] do_one_initcall+0x54/0x210<br>[ce30bf20] [c0058bb0]=
 sys_init_module+0x120/0x240<br>[ce30bf40] [c0012afc] ret_from_syscall+0x0/=
0x38<br>=0A--- Exception: c01 at 0xfe5baa0<br>&nbsp;&nbsp;&nbsp; LR =3D 0x1=
0027de0<br>Instruction dump:<br>4e800020 3c60d005 3863a094 48000031 807fa21=
4 38800000 48000045 3c60d005 <br>3863a0b4 48000019 813fa214 38000061 &lt;98=
090000&gt; 4bffffb8 00000000 3d60c035 <br>=0A---[ end trace a05c5135ddb6273=
4 ]---<br>Segmentation fault<br><br>Checking dmesg(where you can see the pr=
intk msg from the module):<br>Read from allocated page<br>Write to freed pa=
ge<br>Unable to handle kernel paging request for data at address 0xce172000=
<br>=0AFaulting instruction address: 0xd004d07c<br>Oops: Kernel access of b=
ad area, sig: 11 [#1]<br>PREEMPT DEBUG_PAGEALLOC 834x SYS<br>Modules linked=
 in: e300page(+)<br>NIP: d004d07c LR: d004d074 CTR: 00000001<br>REGS: ce30b=
e30 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.33.3-rt17)<br>=0AMSR: 000=
09032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 22000422&nbsp; XER: 20000000<br>DAR: ce=
172000, DSISR: 22000000<br>TASK =3D ce306120[1392] 'insmod' THREAD: ce30a00=
0<br>GPR00: 00000061 ce30bee0 ce306120 0000001a 00003b0d ffffffff c047c4d6 =
00004000 <br>=0AGPR08: c047c8c4 ce172000 00003fff ce306120 22000422 100bbc1=
c 0fffd000 ffffffff <br>GPR16: 00000001 00000000 007fff00 00000000 00000000=
 0fffa1a0 00000000 100b90a0 <br>GPR24: 4800e4ac bf876f10 c043d388 00000000 =
d004d000 c0480000 ce30a000 d0050000 <br>=0ANIP [d004d07c] e300page_init+0x7=
c/0xb8 [e300page]<br>LR [d004d074] e300page_init+0x74/0xb8 [e300page]<br>Ca=
ll Trace:<br>[ce30bee0] [d004d074] e300page_init+0x74/0xb8 [e300page] (unre=
liable)<br>[ce30bef0] [c00038b4] do_one_initcall+0x54/0x210<br>=0A[ce30bf20=
] [c0058bb0] sys_init_module+0x120/0x240<br>[ce30bf40] [c0012afc] ret_from_=
syscall+0x0/0x38<br>--- Exception: c01 at 0xfe5baa0<br>&nbsp;&nbsp;&nbsp; L=
R =3D 0x10027de0<br>Instruction dump:<br>4e800020 3c60d005 3863a094 4800003=
1 807fa214 38800000 48000045 3c60d005 <br>=0A3863a0b4 48000019 813fa214 380=
00061 &lt;98090000&gt; 4bffffb8 00000000 3d60c035 <br>---[ end trace a05c51=
35ddb62734 ]---<br><br># lsmod<br>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nb=
sp; Used by&nbsp;&nbsp;&nbsp; Tainted: G&nbsp; <br>e300page&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1549&nbsp; 1 <br>=0A# rmmod e300page<br>rmmod: e300page: Device or resource=
 busy<br><br>Module source is below:<br>#include &lt;linux/module.h&gt;<br>=
#include &lt;linux/slab.h&gt;<br>#include &lt;linux/init.h&gt;<br><br>stati=
c int __init e300page_init (void)<br>=0A{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; static char *kpage;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; char ch;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(kpage =
=3D (char *)__get_free_pages (GFP_KERNEL, 0))) {<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk =
(KERN_ERR " __get_free_pages failed\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>=
=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; printk(KERN_INFO "Read from allocated page\n");<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch =3D kpage[0];<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_pages ((unsigned long)kpage, 0);<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_INFO "Write to freed pag=
e\n");<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kpage[0]=3D'a';<br>=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>}<br>static voi=
d __exit e300page_exit (void)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; printk (KERN_INFO "e300page exiting\n");<br>}<br><br>module_init (e30=
0page_init);<br>module_exit (e300page_exit);<br>=0A<br>MODULE_AUTHOR ("Xian=
ghua Xiao");<br>MODULE_DESCRIPTION ("Test PageAlloc on e300");<br>MODULE_LI=
CENSE ("GPL v2");<br><br></div></div>=0A</div><br>-----Inline Attachment Fo=
llows-----<br><br><div class=3D"plainMail">________________________________=
_______________<br>Linuxppc-dev mailing list<br><a ymailto=3D"mailto:Linuxp=
pc-dev@lists.ozlabs.org" href=3D"/mc/compose?to=3DLinuxppc-dev@lists.ozlabs=
.org">Linuxppc-dev@lists.ozlabs.org</a><br><a href=3D"https://lists.ozlabs.=
org/listinfo/linuxppc-dev" target=3D"_blank">https://lists.ozlabs.org/listi=
nfo/linuxppc-dev</a></div></blockquote></div></div></td></tr></table><br>=
=0A=0A      
--0-636872414-1273134202=:54231--
