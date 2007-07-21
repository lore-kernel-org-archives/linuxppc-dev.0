Return-Path: <xiay@nari-relays.com>
Received: from mail.nari-relays.com (mail.nari-relays.com [218.94.131.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Domain-Confidentiality-authority",
	Issuer "Domain-Confidentiality-authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 73368DDECE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 11:53:52 +1000 (EST)
From: =?gb2312?B?z8TT6g==?= <xiay@nari-relays.com>
To: <lokowich@acdstar.com>
References: <mailman.1484.1184968961.8639.linuxppc-embedded@ozlabs.org>
Subject: Re: SDRAM failures on MPC5200B (Xia Yu)
Date: Sat, 21 Jul 2007 09:48:06 +0800
Message-ID: <000601c7cb39$2f4390c0$596657c6@rcs9000.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
In-Reply-To: <mailman.1484.1184968961.8639.linuxppc-embedded@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi! According to the MPC5200B user's manual, you should define the S-delay
register(MBAR + 0x0190) to 0x04 ,and the initialization sequence of the DDR
should be modified according to the data sheet from MICRON. I have rewrite
the function as below:
static void sdram_start (int hi_addr)
{
	long hi_addr_bit = hi_addr ? 0x01000000 : 0;

	/* unlock mode register */
	*(vu_long *)MPC5XXX_SDRAM_CTRL = (SDRAM_CONTROL & 0xefffffff)|
0x80000000 | hi_addr_bit;
	__asm__ volatile ("sync");

	/* precharge all banks */
	*(vu_long *)MPC5XXX_SDRAM_CTRL = (SDRAM_CONTROL & 0xefffffff)|
0x80000002 | hi_addr_bit;
	__asm__ volatile ("sync");

#if SDRAM_DDR
	/* set mode register: extended mode */
	*(vu_long *)MPC5XXX_SDRAM_MODE = SDRAM_EMODE;
	__asm__ volatile ("sync");

	/* set mode register: reset DLL */
	*(vu_long *)MPC5XXX_SDRAM_MODE = SDRAM_MODE | 0x04000000;
	__asm__ volatile ("sync");
#endif

	/* precharge all banks */
	*(vu_long *)MPC5XXX_SDRAM_CTRL = (SDRAM_CONTROL & 0xefffffff) |
0x80000002 | hi_addr_bit;
	__asm__ volatile ("sync");

	/* auto refresh */
	*(vu_long *)MPC5XXX_SDRAM_CTRL = (SDRAM_CONTROL & 0xefffffff) |
0x80000004 | hi_addr_bit;
	__asm__ volatile ("sync");
	
	/* auto refresh */
	*(vu_long *)MPC5XXX_SDRAM_CTRL = (SDRAM_CONTROL & 0xefffffff) |
0x80000004 | hi_addr_bit;
	__asm__ volatile ("sync");
	
	/* set mode register */
	*(vu_long *)MPC5XXX_SDRAM_MODE = SDRAM_MODE;
	__asm__ volatile ("sync");

	/* normal operation */
	*(vu_long *)MPC5XXX_SDRAM_CTRL = SDRAM_CONTROL | hi_addr_bit;
	__asm__ volatile ("sync");
	
	udelay(3); //delay 400clks;

}

Hope to be helpful!
