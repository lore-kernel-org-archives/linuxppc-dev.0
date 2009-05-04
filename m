Return-Path: <JuddG@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 71A0FDDDB2
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 05:07:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9CCE9.EC603C88"
Subject: Setting Kernel Allocated Memory Uncached on the PPC460
Date: Mon, 4 May 2009 13:55:42 -0500
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A01351C87@tanisys-ex2.Tanisys.Local>
From: "Judd Gilbert" <JuddG@tanisys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9CCE9.EC603C88
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
=20
This is my first post to this list, so hopefully I read all the
instructions correctly and am posting to the correct list.
=20
I have a driver which maps some kernel allocated memory to user space
which works, and now I am trying to set that memory non-cacheable, on a
power PC using the Denx ELDK (linux-2.6.24) on a PPC460ex.
=20
I have attempted several ways of doing this:
=20
1. Calling the macro SetPageUncached() in linux/page-flags.h. This fails
because for some reason the bit PG_uncached is only defined for
processors whose BITS_PER_LONG > 32.
2. Calling the macro pgprot_noncached() in asm/pgtable-ppc32.h. This
just doesn't seem to have any effect.
3. Setting flags in the struct vm_area_struct->vm_flags before calling
remap_pfn_range(). This doesn't work because the flag I expected to find
VM_NONCACHED is not defined anywhere.
4. Calling the function dma_alloc_coherent() instead of kmalloc() to
allocate the memory(). This causes some kind of bus error or exception
in the kernel - I believe because I passed in NULL for the device which
I read is a bug with the kernel.
=20
Has anyone done this successfuly on a PPC440 or PPC460?
=20
Any tips would be appreciated. Code snippets below...
=20
Thanks!
=20
//
// allocating the memory in the kernel
//
static int __init mapper_init_module(void)
{
  int rc;
  unsigned int i =3D 0;
  phys_addr_t phys_addr;
=20
  MDEBUG("Initializing module...\n");
  /* allocate the memory and pad with pages so that we can=20
   * make sure to page align
   */
  km.raw =3D kmalloc((2*PAGE_COUNT+1)*PAGE_SIZE, GFP_KERNEL);
  if (!km.raw)=20
    return -ENOMEM;
=20
  /* now need to adjust our other pointer to page align to 64 Kb
boundary*/
=20
  /* Note, that we just do the mal and set pal to it since if it is 64Kb
aligned
   * then it is also page aligned
   */
  km.mal =3D  (int *)((((unsigned long)km.raw) + ((1<<16) - 1)) &
0xFFFF0000);
  /*km.pal =3D  (int *)((((unsigned long)km.raw) + (PAGE_SIZE - 1)) &
PAGE_MASK);*/
  km.pal =3D km.mal;
  MDEBUG("Allocated %ld bytes of kernel space for driver at kernel
logical address %p...\n",=20
         PAGE_COUNT*PAGE_SIZE, km.raw);
  MDEBUG("page aligned =3D %p   64k aligned =3D %p\n", km.pal, km.mal);
  MDEBUG("Physical address =3D 0x%lx...\n", __pa(km.raw));
     =20
      .
      .
      .  =20
      .
=20
  /* lock down / reserve the pages in memory */
  {
    int k;
    for (k=3D0; k<PAGE_COUNT*PAGE_SIZE; k+=3DPAGE_SIZE)
      {
        struct page* pg =3D virt_to_page(((unsigned long)km.pal) + k); =20
        SetPageReserved(pg); =20
        //SetPageUncached(pg);
      }
  }
      .    =20
      .
      .
      .
}
=20
//
// mapping the kernel space to user space
//
static int mapper_mmap(struct file *fip, struct vm_area_struct *vma)
{
  int rc;
 =20
  /*=20
   * make sure to allocate the proper number of pages when using
   * mmap.  We check it for correctness here.
   */ =20
  unsigned long len =3D vma->vm_end - vma->vm_start;
=20
  /* if user tries to map bigger space than we have, error */
 if (PAGE_COUNT * PAGE_SIZE < len)=20
    return -EIO;
=20
 pgprot_noncached(vma->vm_page_prot);
 //vma->vm_flags |=3D VM_NONCACHED | VM_RESERVED;
 vma->vm_flags |=3D VM_RESERVED;
=20
  /* map the physical area into one buffer */
  rc =3D remap_pfn_range(vma, vma->vm_start,=20
                   virt_to_phys( (void*)km.pal)>>PAGE_SHIFT,
                   len,
                   vma->vm_page_prot);
  MDEBUG("Mapped %ld bytes at virt address 0x%lx to mapper file
descriptor...\n", len, vma->vm_start);
=20
  /* return an error to the caller if remap fails */
  return (rc < 0 ? rc : 0);
}

------_=_NextPart_001_01C9CCE9.EC603C88
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C9CCC0.04F6F390">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.code, li.code, div.code
	{mso-style-name:code;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;
	color:navy;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Hello Everyone,<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>This is my first post to this list, so =
hopefully I
read all the instructions correctly and am posting to the correct =
list.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>I have a driver which maps some kernel =
allocated
memory to user space which works, and now I am trying to set that memory =
non-cacheable,
on a power PC using the <span class=3DSpellE>Denx</span> ELDK =
(linux-2.6.24) on a
PPC460ex.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>I have attempted several ways of doing =
this:<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>1. Calling the macro <span =
class=3DSpellE><span
class=3DGramE>SetPageUncached</span></span><span class=3DGramE>(</span>) =
in <span
class=3DSpellE>linux/page-flags.h</span>. This fails because for some =
reason the
bit <span class=3DSpellE>PG_uncached</span> is only defined for =
processors whose
BITS_PER_LONG &gt; 32.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>2. Calling the macro <span =
class=3DSpellE>pgprot_<span
class=3DGramE>noncached</span></span><span class=3DGramE>(</span>) in
asm/pgtable-ppc32.h. This just doesn't seem to have any =
effect.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>3. Setting flags in the <span =
class=3DSpellE>struct</span>
<span class=3DSpellE>vm_area_struct</span>-&gt;<span =
class=3DSpellE>vm_flags</span>
before calling <span class=3DSpellE>remap_pfn_<span =
class=3DGramE>range</span></span><span
class=3DGramE>(</span>). This doesn't work because the flag I expected =
to find
VM_NONCACHED is not defined anywhere.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>4. Calling the function <span =
class=3DSpellE>dma_alloc_<span
class=3DGramE>coherent</span></span><span class=3DGramE>(</span>) =
instead of <span
class=3DSpellE>kmalloc</span>() to allocate the memory(). This causes =
some kind of
bus error or exception in the kernel - I believe because I passed in =
NULL for
the device which I read is a bug with the =
kernel.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Has anyone done this <span =
class=3DSpellE>successfuly</span>
on a PPC440 or PPC460?<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Any tips would be appreciated. Code snippets =
below&#8230;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Thanks!<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>//<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>// allocating the memory in the =
kernel<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>//<o:p></o:p></span></font></p>

<p class=3Dcode><span class=3DGramE><font size=3D2 color=3Dnavy =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>static</span></font></span> <span =
class=3DSpellE>int</span>
__init <span =
class=3DSpellE>mapper_init_module</span>(void)<o:p></o:p></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>{<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DSpellE><span class=3DGramE>int</span></span> <span =
class=3DSpellE>rc</span>;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DGramE>unsigned</span> <span class=3DSpellE>int</span> <span =
class=3DSpellE>i</span>
=3D 0;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DSpellE>phys_addr_t</span> <span =
class=3DSpellE>phys_addr</span>;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DGramE>MDEBUG(</span>&quot;Initializing =
module...\n&quot;);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>/*
allocate the memory and pad with pages so that we can =
<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>*
make sure to page align<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>*/<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DSpellE>km.raw</span> =3D <span class=3DSpellE><span =
class=3DGramE>kmalloc</span></span><span
class=3DGramE>(</span>(2*PAGE_COUNT+1)*PAGE_SIZE, =
GFP_KERNEL);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DGramE>if</span> (!<span class=3DSpellE>km.raw</span>) =
<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;
</span><span class=3DGramE>return</span> =
-ENOMEM;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>/* now
need to adjust our other pointer to page align to 64 Kb =
boundary*/<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>/* Note,
that we just do the mal and set pal to it since if it is 64Kb =
aligned<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>* <span
class=3DGramE>then</span> it is also page =
aligned<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>*/<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DSpellE>km.mal</span> <span class=3DGramE>=3D<span
style=3D'mso-spacerun:yes'>&nbsp; </span>(</span><span =
class=3DSpellE>int</span>
*)((((unsigned long)<span class=3DSpellE>km.raw</span>) + ((1&lt;&lt;16) =
- 1))
&amp; 0xFFFF0000);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>/*<span
class=3DSpellE>km.pal</span> <span class=3DGramE>=3D<span
style=3D'mso-spacerun:yes'>&nbsp; </span>(</span><span =
class=3DSpellE>int</span>
*)((((unsigned long)<span class=3DSpellE>km.raw</span>) + (PAGE_SIZE - =
1)) &amp;
PAGE_MASK);*/<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DSpellE>km.pal</span> =3D <span =
class=3DSpellE>km.mal</span>;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DGramE>MDEBUG(</span>&quot;Allocated %ld bytes of kernel space =
for driver
at kernel logical address %p...\n&quot;, <o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;
</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>PAGE_COUN=
T*PAGE_SIZE,
<span class=3DSpellE>km.raw</span>);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DGramE>MDEBUG(</span>&quot;page aligned =3D %p<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>64k aligned =3D =
%p\n&quot;, <span
class=3DSpellE>km.pal</span>, <span =
class=3DSpellE>km.mal</span>);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DGramE>MDEBUG(</span>&quot;Physical address =3D 0x%lx...\n&quot;, =
__pa(<span
class=3DSpellE>km.raw</span>));<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>.<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>/* lock
down / reserve the pages in memory */<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>{<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;
</span><span class=3DSpellE><span class=3DGramE>int</span></span> =
k;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;
</span><span class=3DGramE>for</span> (k=3D0; k&lt;PAGE_COUNT*PAGE_SIZE;
k+=3DPAGE_SIZE)<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>{<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span
class=3DSpellE><span class=3DGramE>struct</span></span> page* pg =3D =
<span
class=3DSpellE>virt_to_page</span>(((unsigned long)<span =
class=3DSpellE>km.pal</span>)
+ k);<span style=3D'mso-spacerun:yes'>&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span
class=3DSpellE><span class=3DGramE>SetPageReserved</span></span><span =
class=3DGramE>(</span>pg);<span
style=3D'mso-spacerun:yes'>&nbsp; </span><o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
style=3D'mso-spacerun:yes'>&nbsp; </span>//<span class=3DSpellE><span =
class=3DGramE>SetPageUncached</span></span><span
class=3DGramE>(</span>pg);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>}<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>}<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>.<span
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>}<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>//<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>// mapping the kernel space to user =
space<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>//<o:p></o:p></span></font></p>

<p class=3Dcode><span class=3DGramE><font size=3D2 color=3Dnavy =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>static</span></font></span> <span =
class=3DSpellE>int</span>
<span class=3DSpellE>mapper_mmap</span>(<span =
class=3DSpellE>struct</span> file *<span
class=3DSpellE>fip</span>, <span class=3DSpellE>struct</span> <span =
class=3DSpellE>vm_area_struct</span>
*<span class=3DSpellE>vma</span>)<o:p></o:p></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>{<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DSpellE><span class=3DGramE>int</span></span> <span =
class=3DSpellE>rc</span>;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>/* <o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>*
make sure to allocate the proper number of pages when =
using<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>* <span
class=3DSpellE><span class=3DGramE>mmap</span></span>.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>We check it for correctness =
here.<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>*/<span
style=3D'mso-spacerun:yes'>&nbsp; </span><o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DGramE>unsigned</span> long <span class=3DSpellE>len</span> =3D =
<span
class=3DSpellE>vma</span>-&gt;<span class=3DSpellE>vm_end</span> - <span
class=3DSpellE>vma</span>-&gt;<span =
class=3DSpellE>vm_start</span>;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>/* if
user tries to map bigger space than we have, error =
*/<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><span
class=3DGramE>if</span> (PAGE_COUNT * PAGE_SIZE &lt; <span =
class=3DSpellE>len</span>)
<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;
</span><span class=3DGramE>return</span> =
-EIO;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><span
class=3DSpellE>pgprot_<span class=3DGramE>noncached</span></span><span =
class=3DGramE>(</span><span
class=3DSpellE>vma</span>-&gt;<span =
class=3DSpellE>vm_page_prot</span>);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span>//<span
class=3DSpellE>vma</span>-&gt;<span class=3DSpellE>vm_flags</span> |=3D =
VM_NONCACHED |
VM_RESERVED;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><span
class=3DSpellE><span class=3DGramE>vma</span></span>-&gt;<span =
class=3DSpellE>vm_flags</span>
|=3D VM_RESERVED;<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>/* map
the physical area into one buffer */<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DSpellE><span class=3DGramE>rc</span></span> =3D <span =
class=3DSpellE>remap_pfn_range</span>(<span
class=3DSpellE>vma</span>, <span class=3DSpellE>vma</span>-&gt;<span =
class=3DSpellE>vm_start</span>,
<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; </span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span
class=3DSpellE>virt_to_<span class=3DGramE>phys</span></span><span =
class=3DGramE>(</span>
(void*)<span =
class=3DSpellE>km.pal</span>)&gt;&gt;PAGE_SHIFT,<o:p></o:p></span></font>=
</p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; </span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span
class=3DSpellE><span =
class=3DGramE>len</span></span>,<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span =
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; </span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span
class=3DSpellE><span class=3DGramE>vma</span></span>-&gt;<span =
class=3DSpellE>vm_page_prot</span>);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DGramE>MDEBUG(</span>&quot;Mapped %ld bytes at <span =
class=3DSpellE>virt</span>
address 0x%lx to <span class=3DSpellE>mapper</span> file =
descriptor...\n&quot;, <span
class=3DSpellE>len</span>, <span class=3DSpellE>vma</span>-&gt;<span =
class=3DSpellE>vm_start</span>);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>/* return
an error to the caller if remap fails */<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span><span
class=3DGramE>return</span> (<span class=3DSpellE>rc</span> &lt; 0 ? =
<span
class=3DSpellE>rc</span> : 0);<o:p></o:p></span></font></p>

<p class=3Dcode><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt'>}</span></font><font color=3Dblack><span
style=3D'color:windowtext'><o:p></o:p></span></font></p>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C9CCE9.EC603C88--
