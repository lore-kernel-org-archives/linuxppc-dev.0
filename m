Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9FBC1DDF4B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 03:57:32 +1100 (EST)
Date: Mon, 26 Nov 2007 10:57:51 -0600
From: Scott Wood <scottwood@freescale.com>
To: vijay baskar <cn.vijaibaskar@gdatech.co.in>
Subject: Re: The question about the high memory support on MPC8360?
Message-ID: <20071126165751.GA4415@loki.buserror.net>
References: <396049508.10992@tsinghua.org.cn> <474A639A.3090006@gdatech.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <474A639A.3090006@gdatech.co.in>
Cc: =?utf-8?B?6YOt5Yqy?= <guojin02@tsinghua.org.cn>,
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

On Mon, Nov 26, 2007 at 11:41:38AM +0530, vijay baskar wrote:
> Hi friends,
> 
> Kernel virtual space is divided into 3 different zones namely ZONE_DMA, 
> ZONE_NORMAL, ZONE_HIGHMEM.Remember that the kernel follows the 3GB/1GB 
> split ie 3 GB for user space and 1  GB for kernel space. Since your ram 
> is 1 GB, 896 MB will be mapped one to one with the kernel virtual space. 
> This one to one mapping will be done in the ZONE_NORMAL and ZONE_DMA of 
> kernel virtual space.Remaining 128 MB of kernel virtual address space 
> will be used for setting up kernel  data structures and for ioremaps and 
> vmallocs that  the kernel will need to perform during boot up.  If  u 
> configure high memory this 128 MB will be used for accessing unmapped 
> memory regions in the ram and there wont be sufficient  virtual 
> addresses for ioremaps and vmallocs. Thats why your kernel did not boot 
> when high mem is configured.

1. The split is 768/256 on powerpc, not 896/128.
2. Why do you think this is insufficient?

>                    Since u want to have 1 GB of ram an alternative to 
> this is that u can try 2 GB/ 2 GB split which is configurable ie 2 GB 
> for user space and 2 GB for kernel space in your kernel.

1. He said he wanted 2GB of RAM, not 1.
2. I don't think this mode of operation has been tested very well on
powerpc.

> >=> bootm fed00000 fe900000                                                      
> >## Booting image at fed00000 ...                                                
> >   Image Name:   Linux-2.6.11                                                   
> >   Image Type:   PowerPC Linux Kernel Image (gzip compressed)                   
> >   Data Size:    1054435 Bytes =  1 MB                                          
> >   Load Address: 00000000                                                       
> >   Entry Point:  00000000                                                       
> >   Verifying Checksum ... OK                                                    
> >   Uncompressing Kernel Image ... OK                                            
> >## Loading RAMDisk Image at fe900000 ...                                        
> >   Image Name:   uboot ext2 ramdisk rootfs                                      
> >   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)                  
> >   Data Size:    3195657 Bytes =  3 MB                                          
> >   Load Address: 00000000                                                       
> >   Entry Point:  00000000                                                       
> >   Verifying Checksum ... OK                                                    
> >   Loading Ramdisk to 0fc9a000, end 0ffa6309 ... OK

Could you try with a more recent, arch/powerpc kernel?

-Scott
