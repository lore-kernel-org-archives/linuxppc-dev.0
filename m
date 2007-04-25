Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id D5E9FDDF15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 22:11:16 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HggKz-0004cg-3C
	for linuxppc-embedded@ozlabs.org; Wed, 25 Apr 2007 14:11:09 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 3/5] [PPC] New registration for common Xilinx Virtex
	ppc405 platform devices
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<1176622070387-git-send-email-grant.likely@secretlab.ca>
Date: Wed, 25 Apr 2007 14:11:09 +0200
In-Reply-To: <1176622070387-git-send-email-grant.likely@secretlab.ca> (Grant
	Likely's message of "Sun, 15 Apr 2007 01:27:40 -0600")
Message-ID: <878xcgac2q.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

GL> Currently virtex support in mainline make use of the
GL> infrastructure in arch/ppc/syslib/ppc_sys.c for registering common
GL> devices on virtex ppc405 platforms.  The ppc_sys.c code is not
GL> well suited to the dynamic nature of FPGA designs and makes adding
GL> new board ports more complex.  This patch adds a new listing of
GL> common devices which does not depend on the ppc_sys.c
GL> infrastructure.

GL> +/* UART 8250 driver platform data table */
GL> +struct plat_serial8250_port virtex_serial_platform_data[] = {
GL> +#if defined(XPAR_UARTNS550_0_BASEADDR)
GL> +	XPAR_UART(0),
GL> +#endif
GL> +#if defined(XPAR_UARTNS550_1_BASEADDR)
GL> +	XPAR_UART(1),
GL> +#endif
GL> +#if defined(XPAR_UARTNS550_2_BASEADDR)
GL> +	XPAR_UART(2),
GL> +#endif
GL> +#if defined(XPAR_UARTNS550_3_BASEADDR)
GL> +	XPAR_UART(3),
GL> +#endif
GL> +	{ }, /* terminated by empty record */
GL> +};

Could we at the same time increase the amount of UARTs supported? We
have designs with 5 16550s.

Other than that,

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
