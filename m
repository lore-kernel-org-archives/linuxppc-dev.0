Return-Path: <Ulrich.Kunkel@hbm.com>
Received: from mail.medianet-world.de (mail.medianet-world.de [213.157.0.167])
	by ozlabs.org (Postfix) with SMTP id 66DBC67FB7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 18:47:25 +1000 (EST)
Message-ID: <D3524C0FFDC6A54F9D7B6BBEECD341D505618A78@hbmntx0.da.hbm.com>
From: "Kunkel, Ulrich" <Ulrich.Kunkel@hbm.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Mon, 22 Aug 2005 10:47:39 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5A6F6.26E5B0C0"
Subject: MPC5200 mmap, ioremap
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5A6F6.26E5B0C0
Content-Type: text/plain

Hello,

  

I am using a Motorola PPC Hardware (MPC5200) with linux kernel 2.4.25 and 32
MB RAM.

 

I  would like to map a large contiguous kernel memory buffer (6 MB) into
user space with mmap and remap_page_range. For this action I reserved memory
at the end of the phyiscal memory at boot time. (Kernel boot option mem =12
M) Now, the kernel only knows about 20 MB of memory. The high_memory border
is at 0x1400000 (physical address).

I have to do a ioremap() on the high_memory (0x1400000) to map the high
physical memory into a virtual kernel memory.

 

ioremap_ptr = ioremap_nocache (__pa(high_memory), 6*1024*1024);  //6 MB

 

ioremap_ptr is a virtual kernel address.

 

Now I do a mem_map_reserve () on every page in this memory block.

 

On the ioremap ptr I do a memset to check the data in user space later.

 

memset(ioremap_ptr, 0xAB, 6*1024*1024);

 

With bdi2000 I looked to the memory values at 0x1400000 and everything is
ok, I see 0xABABABAB.

 

If I do a virt_to_phys() on ioremap_ptr, I get a really strange address. I
expected to get the physical address 0x1400000.

 

Example:

 

__pa(high_memory): 0x1400000

ioremap_ptr: 0xc22a4000

virt_to_phys(ioremap_ptr): 0x22a4000

virt_to_bus(ioremap_ptr): 0x22a4000

 

 

Now I want to map the buffer into to user space with mmap and
remap_page_range.

 

 

static int mmmap (struct file *file, struct vm_area_struct *vma)

{

      unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;

      int error;

      unsigned long start = (unsigned long)vma->vm_start;

      unsigned long size = (unsigned long)(vma->vm_end - vma->vm_start);

 

 

 

      if (offset != 0)

      {

        printk ("rt_iso1394_mmap: invalid offset: must be 0\n");

        return -ENXIO;

      }

      

 

if(size == PAGE_ALIGN(6*1024*1024)

{

  start,virt_to_phys(shared_buffer_ptr), size, protect);

  error = remap_page_range (vma->vm_start, 0x1400000 , size, PAGE_SHARED);

          

  if (error)

   {

     printk ("rt_iso1394_mmap: remap_page_range failed\n");

     return -EAGAIN;

   }

 }

 

 else

 {

 

  printk ("rt_iso1394_mmap: invalid mmap size, size is: %d\n", (int) size);

  return -EAGAIN;

  }

 

 

      return 0;

}

 

 

The function returned with no errors. 

 

If I call mmap () in user space, the function returnes a virtual user
address. But if do a read on this memory, I don't see the data I have
written in the kernel data block in kernel space. I only get zeros. It seems
that remap_page_range maps a completely different data block.

 

Are the any ideas to solve the problem? What I am doing wrong? What is
missing? Where ist the problem with the addresses???

 

Thanks for your help 

 

 

 

Ulrich Kunkel

Hottinger Baldwin Messtechnik GmbH



------_=_NextPart_001_01C5A6F6.26E5B0C0
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=US-ASCII">


<META content="MSHTML 6.00.2800.1505" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN 
class=648504208-22082005>Hello,</SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><?xml:namespace prefix = o ns = 
"urn:schemas-microsoft-com:office:office" /><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>I am using a Motorola PPC Hardware (MPC5200) with linux kernel 2.4.25 and 
32 MB RAM.</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>I<SPAN style="mso-spacerun: yes">&nbsp; </SPAN>would like to map a large 
contiguous kernel memory buffer (6 MB) into user space with mmap and 
remap_page_range. For this action I reserved memory at the end of the phyiscal 
memory at boot time. (Kernel boot option mem =12 M) Now, the kernel only knows 
about 20 MB of memory. The high_memory border is at 0x1400000 (physical 
address).</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>I have to do a ioremap() on the high_memory (0x1400000) to map the high 
physical memory into a virtual kernel memory.</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>ioremap_ptr = ioremap_nocache (__pa(high_memory), 6*1024*1024);<SPAN 
style="mso-spacerun: yes">&nbsp; </SPAN>//6 MB</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>ioremap_ptr is a virtual kernel address.</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>Now I do a mem_map_reserve () on every page in this memory 
block.</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>On the ioremap ptr I do a memset to check the data in user space 
later.</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>memset(ioremap_ptr, 0xAB, 6*1024*1024);</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>With bdi2000 I looked to the memory values at 0x1400000 and everything is 
ok, I see 0xABABABAB.</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>If I do a virt_to_phys() on ioremap_ptr, I get a really strange address. 
I expected to get the physical address 0x1400000.</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>Example:</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>__pa(high_memory): 0x1400000</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>ioremap_ptr: 0xc22a4000</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>virt_to_phys(ioremap_ptr): 0x22a4000</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>virt_to_bus(ioremap_ptr): 0x22a4000</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>Now I want to map the buffer into to user space with mmap and 
remap_page_range.</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><o:p><FONT 
face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT 
face="Courier New">static int mmmap (struct file *file, struct vm_area_struct 
*vma)</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT 
face="Courier New">{</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>unsigned long 
offset = vma-&gt;vm_pgoff &lt;&lt; PAGE_SHIFT;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>int 
error;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>unsigned long 
start = (unsigned long)vma-&gt;vm_start;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>unsigned long 
size = (unsigned long)(vma-&gt;vm_end - vma-&gt;vm_start);</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><o:p><FONT 
face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><o:p><FONT 
face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><o:p><FONT 
face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>if (offset != 
0)</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>{</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN 
style="mso-spacerun: yes">&nbsp; </SPAN>printk ("rt_iso1394_mmap: invalid 
offset: must be 0\n");</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN 
style="mso-spacerun: yes">&nbsp; </SPAN>return -ENXIO;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>}</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><SPAN 
style="mso-spacerun: yes"><FONT 
face="Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><o:p><FONT 
face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT 
face="Courier New">if(size == PAGE_ALIGN(6*1024*1024)</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT 
face="Courier New">{</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp; </SPAN>start,virt_to_phys(shared_buffer_ptr), 
size, protect);</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>error = remap_page_range 
(vma-&gt;vm_start, 0x1400000 , size, PAGE_SHARED);</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt; tab-stops: 302.25pt"><SPAN 
style="mso-spacerun: yes"><FONT 
face="Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</FONT></SPAN></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp; </SPAN>if (error)</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>{</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>printk 
("rt_iso1394_mmap: remap_page_range failed\n");</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>return 
-EAGAIN;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;&nbsp; </SPAN>}</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>}</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><o:p><FONT 
face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>else</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>{</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><o:p><FONT 
face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp; </SPAN>printk ("rt_iso1394_mmap: invalid mmap 
size, size is: %d\n", (int) size);</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp; </SPAN>return -EAGAIN;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-spacerun: yes">&nbsp; </SPAN>}</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><o:p><FONT 
face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><o:p><FONT 
face="Courier New">&nbsp;</FONT></o:p></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT face="Courier New"><SPAN 
style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>return 
0;</FONT></P>
<P class=MsoPlainText style="MARGIN: 0cm 0cm 0pt"><FONT 
face="Courier New">}</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>The function returned with no errors. </FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>If I call mmap () in user space, the function returnes a virtual user 
address. But if do a read on this memory, I don't see the data I have written in 
the kernel data block in kernel space. I only get zeros. It seems that 
remap_page_range maps a co<SPAN class=648504208-22082005>m</SPAN>pletely 
different data block.</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT face="Times New Roman" 
size=3>Are the any ideas to solve the problem? What I am doing wrong? What is 
missing? Where ist the&nbsp;<SPAN class=648504208-22082005>p</SPAN>roblem with 
the addresses???</FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3><SPAN class=648504208-22082005><FONT face=Arial size=2>Thanks for your 
help</FONT></SPAN>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><o:p><FONT face="Times New Roman" 
size=3>&nbsp;</FONT></o:p></P></FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV align=left>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt; tab-stops: 42.6pt" align=left><B 
style="mso-bidi-font-weight: normal"><SPAN 
style="FONT-FAMILY: Arial; mso-bidi-font-family: 'Times New Roman'"><FONT 
size=2>Ulrich Kunkel</FONT></SPAN></B></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt; tab-stops: 42.6pt"><SPAN 
style="FONT-FAMILY: Arial; mso-bidi-font-family: 'Times New Roman'"><FONT 
size=2><B style="mso-bidi-font-weight: normal">Hottinger Baldwin Messtechnik 
GmbH</B></FONT></SPAN><SPAN 
style="FONT-SIZE: 8pt; FONT-FAMILY: Arial; mso-bidi-font-family: 'Times New Roman'"><BR></SPAN></P></DIV></BODY></HTML>

------_=_NextPart_001_01C5A6F6.26E5B0C0--
