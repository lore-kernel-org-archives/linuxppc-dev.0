Return-Path: <filippo.capurso@dave-tech.it>
Received: from dave-tech.it
	(host46-203-static.38-85-b.business.telecomitalia.it [85.38.203.46])
	by ozlabs.org (Postfix) with SMTP id 2501567B40
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Jun 2006 00:53:02 +1000 (EST)
Message-ID: <449172BB.8010400@dave-tech.it>
Date: Thu, 15 Jun 2006 16:46:19 +0200
From: Filippo Capurso - DAVE srl <filippo.capurso@dave-tech.it>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Linux 2.6 on ml403 board
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Reply-To: filippo.capurso@dave-tech.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to get running linux 2.6.17-rc6 (taken from 
linux-2.6-denx.git repository) on a Xilinx ml403 board.
I have a custom design in the Virtex-4 (not the reference design) with 
U-Boot starting from flash without problems. I'm also able to download 
the kernel image via tftp and store it in the flash memory.
U-Boot boots the image correctly:

=> bootm 0xffe00000
## Booting image at ffe00000 ...
    Image Name:   Linux-2.6.17-rc5-g75429ea3-dirty
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    831805 Bytes = 812.3 kB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK

Using T32 with the JTAG ICD I've noticed that the kernel code starts its 
execution correctly (from 0x00000000), but whet it reaches the MMU 
initialization code, it gets into a loop from which it never goes out:

*** 4xx_mmu.c, line 109 ***

while (s <= (total_lowmem - LARGE_PAGE_SIZE_16M)) {
	pmd_t *pmdp;
	unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;

	pmdp = pmd_offset(pgd_offset_k(v), v);
	pmd_val(*pmdp++) = val;
	pmd_val(*pmdp++) = val;
	pmd_val(*pmdp++) = val;
	pmd_val(*pmdp++) = val;

	v += LARGE_PAGE_SIZE_16M;
	p += LARGE_PAGE_SIZE_16M;
	s += LARGE_PAGE_SIZE_16M;
}

It is difficult to understand what is really happening with the T32 
because all variables in there are cpu registers, so I can't watch them.
Any suggestion will be appreciated.
Thanks in advance

Filippo Capurso

-- 

DAVE Srl - Electronics System House
via Forniz 2/1
33080 Porcia (PN) - Italy
Telephone: +39.0434.921215
Telefax: +39.0434.1994030
Freefax: +39.02.700520062
web: www.dave-tech.it
e-mail: filippo.capurso@dave-tech.it
how to reach us: http://mail.map24.com/dave
