Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s37.bay0.hotmail.com (bay0-omc3-s37.bay0.hotmail.com
	[65.54.246.237]) by ozlabs.org (Postfix) with ESMTP id 9A782DDE45
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 May 2008 04:42:12 +1000 (EST)
Message-ID: <BAY138-W36C7249F532D111A1DC508B2D00@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_9477b6e8-e42b-4bc8-bc0d-67739e52e665_"
From: MingLiu <eemingliu@hotmail.com>
To: Dave Cogley <dcogley@uslinc.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: mmap problem in device driver and application program.
Date: Thu, 8 May 2008 18:42:10 +0000
In-Reply-To: <1210266109.3755.8.camel@localhost.localdomain>
References: <BAY138-W55519F961B3A01D0B8A167B2D00@phx.gbl>
	<1210266109.3755.8.camel@localhost.localdomain>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_9477b6e8-e42b-4bc8-bc0d-67739e52e665_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear Dave,
 
Thanks for your answer first. However I am very confused. It seems that I understand the memory-mapping-related functions completely wrong. Here comes more questions. > The address you are passing to mmap is where the pointer will be mapped> in virtual address space. You need to determine the DMA memory address> page number down in the actual mmap call.> > int foo_mmap(struct file* filep, struct vm_area_struct* vma)> {> unsigned long dma_addr = 0x03000000;> unsigned long dma_size = 0x00200000;> unsigned long pfn;> > // convert the DMA address to page number> pfn = virt_to_phys(dma_addr) >> PAGE_SHIFT;
Shall I use virt_to_phys? dma_addr is already exactly physical address which is used to initiate DMA transfers. 
 
> // remap our page frame to the vma offset> remap_pfn_range(vma, vma->vm_start, pfn, > dma_size, vma->vm_page_prot);> }> > Change the address parameter from 0x03000000 to 0:> > lut_mem_base = (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, > PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
Previously I used "remap_page_range(vma, vma->vm_start, physical_addr, vm_size, vma->vm_page_prot)" in the device driver, where physical_addr is 0x03000000. In the application program, I used "lut_mem_base = (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);". I think it is correct but it doesn't work. I heard that in the new kernels, remap_page_range is not supported any more. However when I compile the driver, nothing was shown to complain that. I am using 2.6.10 kernel. Any hint for this?
 
Thank you for your help to make me understand. 
 
BR
Ming
_________________________________________________________________
Windows Live Photo gallery 数码相机的超级伴侣，轻松管理和编辑照片，还能制作全景美图！
http://get.live.cn/product/photo.html
--_9477b6e8-e42b-4bc8-bc0d-67739e52e665_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 9pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class='hmmessage'>
Dear Dave,<BR>
&nbsp;<BR>
Thanks for your answer first. However I am&nbsp;very confused. It seems that I understand the memory-mapping-related functions completely wrong. Here comes more questions. <BR><BR><BR>&gt; The address you are passing to mmap is where the pointer will be mapped<BR>&gt; in virtual address space. You need to determine the DMA memory address<BR>&gt; page number down in the actual mmap call.<BR>&gt; <BR>&gt; int foo_mmap(struct file* filep, struct vm_area_struct* vma)<BR>&gt; {<BR>&gt; unsigned long dma_addr = 0x03000000;<BR>&gt; unsigned long dma_size = 0x00200000;<BR>&gt; unsigned long pfn;<BR>&gt; <BR>&gt; // convert the DMA address to page number<BR>&gt; pfn = virt_to_phys(dma_addr) &gt;&gt; PAGE_SHIFT;<BR><BR>
Shall I use virt_to_phys? dma_addr is already exactly physical address which is used to initiate DMA transfers. <BR>
&nbsp;<BR>
&gt; // remap our page frame to the vma offset<BR>&gt; remap_pfn_range(vma, vma-&gt;vm_start, pfn, <BR>&gt; dma_size, vma-&gt;vm_page_prot);<BR>&gt; }<BR>&gt; <BR>&gt; Change the address parameter from 0x03000000 to 0:<BR>&gt; <BR>&gt; lut_mem_base = (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, <BR>&gt; PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);<BR><BR>
Previously I used "remap_page_range(vma, vma-&gt;vm_start, physical_addr, vm_size, vma-&gt;vm_page_prot)" in the device driver, where physical_addr is 0x03000000. In the application program, I used "lut_mem_base = (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);". I think it is correct but it doesn't work. I heard that in the new kernels, remap_page_range is not supported any more. However when I compile the driver, nothing was shown to complain that. I am using 2.6.10 kernel. Any hint for this?<BR>
&nbsp;<BR>
Thank you for your help to make me understand. <BR>
&nbsp;<BR>
BR<BR>
Ming<BR><br /><hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://messenger.live.cn/' target='_new'>立即体验！</a></body>
</html>
--_9477b6e8-e42b-4bc8-bc0d-67739e52e665_--
