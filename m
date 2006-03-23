Return-Path: <chris.wyse@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id AC8D7679F3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 01:23:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C64E85.0759755C"
Subject: Memory mapping PCI memory region to user space
Date: Thu, 23 Mar 2006 06:21:05 -0800
Message-ID: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
From: "Wyse, Chris" <chris.wyse@windriver.com>
To: <linuxppc-embedded@ozlabs.org>,
	"+linux-embedded" <linux-embedded@mail.wrs.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C64E85.0759755C
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I'm trying to map a PCI memory region 1 into user space from my driver
(PPC440GX, Linux 2.6.10).  Here's the mmap routine of the driver that
I'm using:
=20
=20
staticfun
int phob_mmap(struct file *filp, struct vm_area_struct *vma)
{
    struct phob_file *fptr =3D filp->private_data;
    struct phob_struct *dev =3D fptr->dev;
    struct phob_region *rptr =3D &dev->region[1];
    phys_addr_t physAddr;
=20

    physAddr =3D rptr->address + PPC44x_PCIMEM_PAGE;
    if (io_remap_page_range(vma, vma->vm_start,
                            physAddr,
                            rptr->len,
                            vma->vm_page_prot))
        return -EAGAIN;
}


Am I using the correct routine to do this?
=20
When I use this routine, the pfn_pte (pgtable.h):=20
=20
#define pfn_pte(pfn, prot)      __pte(((pfn) << PAGE_SHIFT) |
pgprot_val(prot))
=20
macro shifted out the high order bits of the pfn, which I didn't think
was correct, so I changed it to:

#define pfn_pte(pfn, prot)      __pte((((unsigned long long) (pfn)) <<
PAGE_SHIFT) | pgprot_val(prot))
=20
For reference, the call stack up to the pfn_pte macro is:
=20
remap_pte_range()
remap_pmd_range()
remap_pfn_range()
io_remap_page_range()
=20
After changing the macro, the value seems to be saved properly, and the
TLB gets updated properly when I get a TLB miss.  However, when if I try
to write to the PCI from user space, I get an error from do_wp_page()
stating that it is a bogus pfn.  If I try to read from user space, the
processor goes out to lunch and I need to reboot.
=20
Am I missing something obvious?  Anyone have any ideas on how to do this
and/or ways to debug it?
=20
Thanks.


Chris Wyse
Member of Technical Staff
Embedded Technologies
860-749-1556 office
860-978-0849 cell
413-778-9101 fax
http://www.windriver.com <http://www.windriver.com/>=20
 =20

=20

------_=_NextPart_001_01C64E85.0759755C
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D694270513-23032006>I'm =
trying to map a=20
PCI memory region 1&nbsp;into user space from my driver (PPC440GX, Linux =

2.6.10).&nbsp; Here's the mmap routine of the driver that I'm=20
using:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>staticfun<BR>int&nbsp;<SPAN=20
class=3D694270513-23032006>phob</SPAN>_mmap(struct file *filp, struct=20
vm_area_struct *vma)<BR>{<BR>&nbsp;&nbsp;&nbsp; struct phob_file *fptr =
=3D=20
filp-&gt;private_data;<BR>&nbsp;&nbsp;&nbsp; struct phob_struct *dev =3D =

fptr-&gt;dev;<BR>&nbsp;&nbsp;&nbsp; struct phob_region *rptr =3D=20
&amp;dev-&gt;region[<SPAN=20
class=3D694270513-23032006>1</SPAN>];<BR>&nbsp;&nbsp;&nbsp; phys_addr_t=20
physAddr;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>&nbsp;&nbsp;&nbsp; physAddr =3D rptr-&gt;address +=20
PPC44x_PCIMEM_PAGE;<BR>&nbsp;&nbsp;&nbsp; if (io_remap_page_range(vma,=20
vma-&gt;vm_start,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
physAddr,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
rptr-&gt;len,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
vma-&gt;vm_page_prot))<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return=20
-EAGAIN;<BR><SPAN=20
class=3D694270513-23032006>}</SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR></FONT></DIV>
<DIV><FONT><SPAN class=3D694270513-23032006><FONT face=3DArial =
size=3D2>Am I using the=20
correct routine to do this?</FONT></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D694270513-23032006><FONT face=3DArial=20
size=3D2></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D694270513-23032006><FONT face=3DArial =
size=3D2>When I use=20
this routine, the pfn_pte (pgtable.h): </FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D694270513-23032006><FONT face=3DArial =
size=3D2>#define=20
pfn_pte(pfn, prot)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __pte(((pfn) &lt;&lt;=20
PAGE_SHIFT) | pgprot_val(prot))</FONT></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D694270513-23032006><FONT face=3DArial=20
size=3D2></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D694270513-23032006><FONT face=3DArial =
size=3D2>macro shifted=20
out the high order bits of the pfn, which I didn't think was correct, so =
I=20
changed it to:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial =
size=3D2></FONT><BR><FONT=20
face=3DArial size=3D2>#define pfn_pte(pfn, =
prot)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
__pte((((unsigned long long) (pfn)) &lt;&lt; PAGE_SHIFT) |=20
pgprot_val(prot))</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D694270513-23032006></SPAN><FONT face=3DArial =
size=3D2>F<SPAN=20
class=3D694270513-23032006>or reference, the call stack up to the =
pfn_pte macro=20
is:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006>remap_pte_range()</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006>remap_pmd_range()</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006>remap_pfn_range()</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006>io_remap_page_range()</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D694270513-23032006>After =
changing the=20
macro, the value seems to be saved properly, and the TLB gets updated =
properly=20
when I get a TLB miss.&nbsp; However, when if I try to write to the PCI =
from=20
user space, I get an error from do_wp_page() stating that it is a bogus=20
pfn.&nbsp; If I try to read from user space, the processor goes out to =
lunch and=20
I need to reboot.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D694270513-23032006>Am I =
missing=20
something obvious?&nbsp; Anyone have any ideas on how to do this and/or =
ways to=20
debug it?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D694270513-23032006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D694270513-23032006>Thanks.</SPAN></DIV>
<DIV><BR></DIV></FONT></SPAN></FONT>
<DIV align=3Dleft>
<P align=3Dleft><FONT size=3D2>Chris Wyse<BR>Member of&nbsp;Technical=20
Staff<BR>Embedded Technologies<BR>860-749-1556 office<BR>860-978-0849=20
cell<BR>413-778-9101 fax<BR><A title=3Dhttp://www.windriver.com/=20
href=3D"http://www.windriver.com/"=20
target=3D_blank>http://www.windriver.com</A><BR>&nbsp;</FONT> </P></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C64E85.0759755C--
