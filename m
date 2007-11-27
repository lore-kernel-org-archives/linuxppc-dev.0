Return-Path: <cn.vijaibaskar@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 26C19DDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 15:23:16 +1100 (EST)
Received: from [172.29.36.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id EA7EB8780B7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 20:23:13 -0800 (PST)
Received: from mail.gdatech.co.in (unknown [172.29.36.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 5C16F8780B6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 20:23:13 -0800 (PST)
Message-ID: <474B9CC0.2000803@gdatech.co.in>
Date: Tue, 27 Nov 2007 09:57:44 +0530
From: vijay baskar <cn.vijaibaskar@gdatech.co.in>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: The question about the high memory support on MPC8360?
References: <396049508.10992@tsinghua.org.cn> <474A639A.3090006@gdatech.co.in>
	<20071126165751.GA4415@loki.buserror.net>
In-Reply-To: <20071126165751.GA4415@loki.buserror.net>
Content-Type: text/html; charset=UTF-8
Cc: =?UTF-8?B?6YOt5Yqy?= <guojin02@tsinghua.org.cn>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"=
>
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Scott Wood wrote:
<blockquote cite=3D"mid20071126165751.GA4415@loki.buserror.net"
 type=3D"cite">
  <pre wrap=3D"">On Mon, Nov 26, 2007 at 11:41:38AM +0530, vijay baskar w=
rote:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">Hi friends,

Kernel virtual space is divided into 3 different zones namely ZONE_DMA,=20
ZONE_NORMAL, ZONE_HIGHMEM.Remember that the kernel follows the 3GB/1GB=20
split ie 3 GB for user space and 1  GB for kernel space. Since your ram=20
is 1 GB, 896 MB will be mapped one to one with the kernel virtual space.=20
This one to one mapping will be done in the ZONE_NORMAL and ZONE_DMA of=20
kernel virtual space.Remaining 128 MB of kernel virtual address space=20
will be used for setting up kernel  data structures and for ioremaps and=20
vmallocs that  the kernel will need to perform during boot up.  If  u=20
configure high memory this 128 MB will be used for accessing unmapped=20
memory regions in the ram and there wont be sufficient  virtual=20
addresses for ioremaps and vmallocs. Thats why your kernel did not boot=20
when high mem is configured.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
1. The split is 768/256 on powerpc, not 896/128.
2. Why do you think this is insufficient?
  </pre>
</blockquote>
=C2=A0=C2=A0=C2=A0 <br>
<pre wrap=3D"">The kernel maps the last 1 GB of the virtual address space=
 one to one
to the physical memory. This is called the kernel space. After the one
to one mapping is done for the available physical memory, the
remaining virtual addresses are used for vmalloc and ioremap.

The kernel also allows hardcoded mapping
of IO regions into its virtual address space through the
io_block_mapping interface. Many boards use the block IO mapping to
map the CCSRBAR/IMMR into the kernel address space, such that the
physical address and the virutal address is the same. Virtual
addresses beyond these hardcoded mappings cannot be used by
vmalloc/ioremap.

Now as more and more memory is added to the system the addresses
available for vmalloc and ioremap gets reduced, and memory allocations
start to fail, due to the lack of availability of virtual addresses.</pre=
>
<br>
<br>
<blockquote cite=3D"mid20071126165751.GA4415@loki.buserror.net"
 type=3D"cite">
  <pre wrap=3D"">
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">                   Since u want to have 1 GB of ram an=
 alternative to=20
this is that u can try 2 GB/ 2 GB split which is configurable ie 2 GB=20
for user space and 2 GB for kernel space in your kernel.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
1. He said he wanted 2GB of RAM, not 1.
2. I don't think this mode of operation has been tested very well on
powerpc.

  </pre>
  <blockquote type=3D"cite">
    <blockquote type=3D"cite">
      <pre wrap=3D"">=3D&gt; bootm fed00000 fe900000                     =
                                =20
## Booting image at fed00000 ...                                         =
      =20
  Image Name:   Linux-2.6.11                                             =
     =20
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)             =
     =20
  Data Size:    1054435 Bytes =3D  1 MB                                  =
       =20
  Load Address: 00000000                                                 =
     =20
  Entry Point:  00000000                                                 =
     =20
  Verifying Checksum ... OK                                              =
     =20
  Uncompressing Kernel Image ... OK                                      =
     =20
## Loading RAMDisk Image at fe900000 ...                                 =
      =20
  Image Name:   uboot ext2 ramdisk rootfs                                =
     =20
  Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)            =
     =20
  Data Size:    3195657 Bytes =3D  3 MB                                  =
       =20
  Load Address: 00000000                                                 =
     =20
  Entry Point:  00000000                                                 =
     =20
  Verifying Checksum ... OK                                              =
     =20
  Loading Ramdisk to 0fc9a000, end 0ffa6309 ... OK
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=3D""><!---->
Could you try with a more recent, arch/powerpc kernel?

-Scott


  </pre>
</blockquote>
<br>
</body>
</html>
