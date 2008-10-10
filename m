Return-Path: <xcarandiru@gmail.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.188])
	by ozlabs.org (Postfix) with ESMTP id E5409DE3DA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Oct 2008 23:58:29 +1100 (EST)
Received: by gv-out-0910.google.com with SMTP id y18so151094gvf.14
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Oct 2008 05:58:28 -0700 (PDT)
Message-ID: <d970ff420810100558i126acd8cof9e6dcd564931933@mail.gmail.com>
Date: Fri, 10 Oct 2008 09:58:27 -0300
From: Alemao <xcarandiru@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MTD map drivers (FSL UPM NAND)
In-Reply-To: <48EE74FF.9000809@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <d970ff420810091404j49492e80xcd9250d0ffdcd592@mail.gmail.com>
	<48EE74FF.9000809@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>
>> Hi all,
>>
>> Im trying to use a physmap driver for NOR and NAND flash devices.
>
> You can't use physmap with NAND.
>

Bu I have here physmap with NAND working,
but not using UPM

>>  ranges = <0 0 ff000000 1000000     // nor flash,  16 MB
>>                    1 0 60000000 4000000>;   // nand flash, 64 MB
>
> Is your NAND window really that large?  I'm not too familiar with UPM, but
> typically it'd only be a few KiB.
>

I always thought here was the memory size... =)

But how can I calculate the window size?

I think the concept of window size is not so clear to me...

>> So, how can I load the UPM driver before physmap?
>
> Just stop pointing physmap at the NAND.
>
> -Scott
>

Here is an output from someone using it:

-----

070500 U-Boot 1.1.2 (May 30 2007 - 20:20:09)

Motorola PowerPC
Board: GDA Technologies CSC-PP MPC8560 [PowerQUICC III]
CPU: 660 MHz
CCB: 330 MHz
DDR: 165 MHz

Creating 7 MTD partitions on "CSC flash":
0x00f80000-0x01000000 : "uboot"
0x00d00000-0x00e00000 : "kernel0"
0x00e00000-0x00f00000 : "kernel1"
0x00700000-0x00d00000 : "app"
0x00000000-0x00380000 : "root0"
0x00380000-0x00700000 : "root1"
0x00f00000-0x00f80000 : "env"

NAND device: Manufacturer ID: 0x2c, Chip ID: 0xca
Scanning device for bad blocks
Bad eraseblock 1780 at 0x0de80000
Creating 1 MTD partitions on "NAND 256MiB 3,3V 16-bit":
0x00000000-0x10000000 : "NAND Partition"

-----

Thats exactly what I want to do. If you say not to use physmap with
NAND, how he is doing this? Through the device tree source?


Huge thanks,

--
Alemao
