Return-Path: <eliedebrauwer@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51A6FB7121
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Jan 2011 03:22:16 +1100 (EST)
Received: by wyi11 with SMTP id 11so1956811wyi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 08:22:11 -0800 (PST)
Message-ID: <4D39B2B0.9050207@gmail.com>
Date: Fri, 21 Jan 2011 17:22:08 +0100
From: Elie De Brauwer <eliedebrauwer@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: fsl-esdhc on P2020 weird endianess behavior
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello list,

I have a P2020 processor on a custom board which uses the embedded 
fsl-esdhc controller. Hardware-wise this is functional and in u-boot 
everything seems to behave (mmc part 0 gives the correct partition table 
and ext2ls/fatls are capable of reading the contents of the sd card).

However as soon as I start Linux (2.6.36), I get all sorts of unwanted 
behavior. Linux is unable to detect the partition layout (but if I do a 
hexdump of the MBR, I see the endianness is swapped (last 4 bytes are aa 
55 00 00). Also when I try to obtain the card registers they show the 
same behavior:
# cat ./devices/soc.0/ff72e000.sdhci/mmc_host/mmc0/mmc0:0001/scr
0000b50200000000

While for comparison the same value on my (x86) laptop gives:
edb@lapedb:/sys/devices/pci0000:00/0000:00:1e.0/0000:15:00.2/mmc_host/mmc0/mmc0:0001$ 
cat scr
02b5000000000000

In my config I have the following set:
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER=y
# CONFIG_MMC_SDHCI_PCI is not set
CONFIG_MMC_SDHCI_OF=y
CONFIG_MMC_SDHCI_OF_ESDHC=y


any pointers are welcome.

gr
E.

-- 
Elie De Brauwer
