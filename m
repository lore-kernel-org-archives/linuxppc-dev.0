Return-Path: <Bo.Liu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DF26CB7BCA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 Nov 2009 15:24:02 +1100 (EST)
Message-ID: <4AF0E4A0.30802@windriver.com>
Date: Wed, 04 Nov 2009 10:19:12 +0800
From: Tonyliu <Bo.Liu@windriver.com>
MIME-Version: 1.0
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: DMA to User-Space
References: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Bo.Liu@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jonathan Haws wrote:
> All,
>
> I have what may be an unconventional question:
>
> Our application consists of data being captured by an FPGA, processed, and transferred to SDRAM.  I simply give the FPGA an address of where I want it stored in SDRAM and it simply DMAs the data over and interrupts me when finished.  I then take that data and store it to disk.
>
> I have code in user space that handles all of the writing to disk nicely and fast enough for my application (I am capturing data at about 35-40 Mbytes/sec).
>
> My question is this:  is it possible to give a user-space pointer to the FPGA to DMA to?  It seems like I would have problems with alignment, address manipulation, and a whole slew of other issues.
>   
> What would be the best way to accomplish something like that?  I want to handle all the disk access in user-space, but I do not want to have to copy 40 MB/s from kernel space to user-space either.
>   
You can maintain a DMA buffer in kernel, then mmap to user space. And 
maybe you need some handshake between FPGA and the apps to balance input 
datas  with datas to disk.
> I can maintain an allocated, DMA-safe buffer in kernel space if needed.  Can I simply get a user-space pointer to that buffer?  What calls are needed to translate addresses?
>   
Use remap_pfn_range()  in your kernel DMA buffer manipulation driver 
.mmap() handler to export DMA  buffer address to user space.

Tony
> Thanks for the help!  I am still a newbie when it comes to kernel programming, so I really appreciate the help!
>
> Jonathan
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>   


-- 
Tony Liu | Liu Bo
-------------------------------------------------------------
WIND RIVER | China Development Center
Tel: 86-10-8477-8542 ext: 8542 |  Fax: 86-10-64790367
(M): 86-136-7117-3612
Address: 15/F, Wangjing TowerB, Chaoyang District, Beijing, P.R.China
