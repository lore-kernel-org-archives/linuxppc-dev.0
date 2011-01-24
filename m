Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5C79B1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Jan 2011 14:24:51 +1100 (EST)
Message-ID: <4D3CF158.20704@windriver.com>
Date: Mon, 24 Jan 2011 11:26:16 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Elie De Brauwer <eliedebrauwer@gmail.com>
Subject: Re: fsl-esdhc on P2020 weird endianess behavior
References: <4D39B2B0.9050207@gmail.com>
In-Reply-To: <4D39B2B0.9050207@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Elie De Brauwer wrote:
> Hello list,
> 
> I have a P2020 processor on a custom board which uses the embedded
> fsl-esdhc controller. Hardware-wise this is functional and in u-boot
> everything seems to behave (mmc part 0 gives the correct partition table
> and ext2ls/fatls are capable of reading the contents of the sd card).
> 
> However as soon as I start Linux (2.6.36), I get all sorts of unwanted
> behavior. Linux is unable to detect the partition layout (but if I do a

Can you re-partition that under Linux? i.e, you can use fdisk to do this. Then
I'm a bit curious what it'll be happened.

> hexdump of the MBR, I see the endianness is swapped (last 4 bytes are aa
> 55 00 00). Also when I try to obtain the card registers they show the
> same behavior:
> # cat ./devices/soc.0/ff72e000.sdhci/mmc_host/mmc0/mmc0:0001/scr
> 0000b50200000000
> 
> While for comparison the same value on my (x86) laptop gives:
> edb@lapedb:/sys/devices/pci0000:00/0000:00:1e.0/0000:15:00.2/mmc_host/mmc0/mmc0:0001$
> cat scr
> 02b5000000000000
> 
> In my config I have the following set:
> CONFIG_MMC_SDHCI=y
> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER=y
> # CONFIG_MMC_SDHCI_PCI is not set
> CONFIG_MMC_SDHCI_OF=y
> CONFIG_MMC_SDHCI_OF_ESDHC=y

At least looks the config is fine.

Tiejun

> 
> 
> any pointers are welcome.
> 
> gr
> E.
> 
