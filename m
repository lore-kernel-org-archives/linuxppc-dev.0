Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60E78DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Sep 2008 23:58:43 +1000 (EST)
Received: from [172.26.6.73] ([172.26.6.73]) (authenticated bits=0)
	by xseries02.selcomgroup.com (8.13.4/8.13.4) with ESMTP id
	m84Dbf5D006092
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 Sep 2008 15:37:42 +0200
Message-ID: <48BFE4A5.4000200@selcomgroup.com>
Date: Thu, 04 Sep 2008 15:37:41 +0200
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5121e port status
References: <6e36f2f00808271507w5b58d646w66c73c5af5931e50@mail.gmail.com>
	<200809021250.52802.david.jander@protonic.nl>
In-Reply-To: <200809021250.52802.david.jander@protonic.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
we are using freescale's distro, but we're having some issues with the 
socketcan driver provided in the kernel.

Basically, sometimes while we're transmitting a high bandwidth, we get a 
"BUG! Tx Ring full when queue awake!" and if we open it more than once, 
then sometimes the bandwidth setting IOCTL fails with "no such device"

Unfortunately, the MPC5121 mscan driver patch which is included in 
freescale, was not made against either the kernel root or the socketcan 
project, so it's not easy to port it anywhere.

Has anyone got that working, in a way or the other?

Thanks,
Matteo

David Jander ha scritto:
> On Thursday 28 August 2008 00:07:11 Andrés Calderón wrote:
>   
>> Is the mpc5121e kernel port mature enough to be used in commercial
>> appliance?
>>     
>
> That depends. For any use of the linux kernel in a "commercial appliance", the 
> manufacturer of the appliance has the sole responsibility of testing for 
> stability and fitness.
>
> That said, the status of MPC5121e support in the linux kernel is as follows:
>
> Latest mainline (git) kernel: Only basic CPU support, almost no drivers for 
> anything.
>
> LTIB distribution from Freescale (downloadable on Freescale web-page of the 
> MPC5121e), latest version: kernel 2.6.24.5 with a lot of drivers for (among 
> other things): DIU, NAND-flash, PSC-I2C, PSC-Uarts, CAN, DMA, Ethernet, USB 
> (ehci host works well), etc....
> Notably missing from this version is support for MBX, SATA and SDHC.
> One thing that you shouldn't count on quite yet is the MBX (3D-acceleration), 
> because it will not have open-source drivers in any forseeable time AFAIK 
> (probably never)... only some promise of a commercial driver and OpenGL-ES 
> library which probably will be more of a hassle than useful to anyone.
>
> We have a custom board running the LTIB version of the kernel, and the 
> existing drivers work surprisingly well, but are IMHO not useable for 
> production right out of the box. The NAND-flash driver for instance is broken 
> for most uses, and the DIU driver has some cache-related issues (glitches in 
> the image). Those problems are more or less easily fixed however. Ethernet 
> and USB (host) seem pretty stable however (I am running on NFS-root all the 
> time).
>
> There are effords underway to get the drivers ported and fixed for mainline 
> linux, but the process is quite slow at the moment. That has us for instance 
> locked in the ancient 2.6.24.5 version of the kernel.
>
> Best regards,
>
>   
