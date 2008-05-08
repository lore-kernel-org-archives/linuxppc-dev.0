Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s25.bay0.hotmail.com (bay0-omc2-s25.bay0.hotmail.com
	[65.54.246.161]) by ozlabs.org (Postfix) with ESMTP id 03637DE17F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 May 2008 01:33:08 +1000 (EST)
Message-ID: <BAY138-W55519F961B3A01D0B8A167B2D00@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_85d97792-c533-49c7-9c61-1e8dda54c0d3_"
From: MingLiu <eemingliu@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: mmap problem in device driver and application program.
Date: Thu, 8 May 2008 15:33:06 +0000
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

--_85d97792-c533-49c7-9c61-1e8dda54c0d3_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear all,
I had some problem when I use mmap() file operation in the device driver file operation. My situation can be described as:
 
1. I reserve 2MB DDR memory as a look-up-table (LUT) for my customized device. The physical start address in the memory is 0x03000000 and the size is 2MB. 
 
2. In the device driver, I use mmap file operation to make this memory area directly accessible by application programs. In the mmap file operation, it looks like:
 
  if(remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, vma->vm_end - vma->vm_start, vma->vm_page_prot)){     return -EAGAIN;   }
 
3. In the application program, I read from a file and initialize the LUT area. I use the following sentence to mmap the physical address into a virtual one which could be accessed by the application:
 
  // the physical address is from 0x03000000 with a size of LUT_SIZE_IN_BYTE equal to 2MB
  lut_mem_base = (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0x03000000);
 
Then, I initialize the LUT area with the virtual address specified by lut_mem_base. 
 
  for(i=0;;i++){
    fread(&buf, sizeof(unsigned int), 1, fp);
    *(lut_mem_base + i) = buf;
    if(feop(fp)){
       break;
    }
  }
 
4. After the initialization of the LUT memory area, in the device driver, DMA transfer will be enabled using the physical address of 0x03000000 as the source address. The destination is a register in my customized device. The data is fed from the memory to my device register. 
 
HOWEVER, I found that the data fed to the device register is not the same as the one used to initialize the LUT memory. Maybe the DMA fetches wrong data from different addresses and feeds to my device. Since this is my first time to use mmap, I am not self-confident to my program, both in the device driver and in the application. Is there anything wrong with my mmap part? I will appreciate so much if some experts could give me some hints. Thanks in advance.
 
BR
Ming
 
 
 
 
 
 
_________________________________________________________________
用手机MSN聊天写邮件看空间，无限沟通，分享精彩！
http://mobile.msn.com.cn/
--_85d97792-c533-49c7-9c61-1e8dda54c0d3_
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
Dear all,<BR>
I had some problem when I use mmap() file operation in the device driver file operation. My situation can be described as:<BR>
&nbsp;<BR>
1. I reserve 2MB DDR memory as a look-up-table (LUT)&nbsp;for my customized device. The physical start&nbsp;address in the memory is 0x03000000 and the size is 2MB. <BR>
&nbsp;<BR>
2. In the device driver, I use mmap file operation to make this memory area directly accessible by application programs. In the mmap file operation, it looks like:<BR>
&nbsp;<BR>
&nbsp; if(remap_pfn_range(vma, vma-&gt;vm_start, vma-&gt;vm_pgoff, vma-&gt;vm_end - vma-&gt;vm_start, vma-&gt;vm_page_prot)){<BR>&nbsp;&nbsp;&nbsp;&nbsp; return -EAGAIN;<BR>&nbsp;&nbsp; }<BR>
&nbsp;<BR>
3. In the application program, I read from a file and initialize the LUT area. I use the following sentence to mmap the physical address into a virtual one which could be accessed by the application:<BR>
&nbsp;<BR>
&nbsp; // the physical address is from 0x03000000 with a size of LUT_SIZE_IN_BYTE equal to 2MB<BR>
&nbsp; lut_mem_base = (unsigned int *) mmap(0, LUT_SIZE_IN_BYTE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0x03000000);<BR>
&nbsp;<BR>
Then, I initialize the LUT area with the virtual address specified by lut_mem_base. <BR>
&nbsp;<BR>
&nbsp; for(i=0;;i++){<BR>
&nbsp;&nbsp;&nbsp; fread(&amp;buf, sizeof(unsigned int), 1, fp);<BR>
&nbsp;&nbsp;&nbsp; *(lut_mem_base + i) = buf;<BR>
&nbsp;&nbsp;&nbsp; if(feop(fp)){<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&nbsp;&nbsp;&nbsp; }<BR>
&nbsp; }<BR>
&nbsp;<BR>
4. After the initialization of the LUT memory area, in the device driver, DMA transfer will be enabled using the physical address of 0x03000000 as the source address. The destination is a register in my customized device. The data is fed from the memory to my device register. <BR>
&nbsp;<BR>
HOWEVER, I found that the data fed to the device register is not the same as the one used to initialize the LUT memory. Maybe the DMA fetches wrong data from different addresses and feeds to my device. Since this is my first time to use mmap, I am not self-confident to my program, both in the device driver and in the application. Is there anything wrong with my mmap part? I will appreciate so much if some experts could give me some hints. Thanks in advance.<BR>
&nbsp;<BR>
BR<BR>
Ming<BR>
&nbsp;<BR>
&nbsp;<BR>
&nbsp;<BR>
&nbsp;<BR>
&nbsp;<BR>
&nbsp;<BR><br /><hr />Windows Live Writer，支持离线撰写博客内容，随时随地想写就写。 <a href='http://get.live.cn/product/writer.html' target='_new'>立即使用！</a></body>
</html>
--_85d97792-c533-49c7-9c61-1e8dda54c0d3_--
