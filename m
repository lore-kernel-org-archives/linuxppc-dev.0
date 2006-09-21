Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id AB4AD67BB8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 01:04:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/11] qe_lib: Add QE I/O ports API
Date: Thu, 21 Sep 2006 16:52:14 +0200
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9399B44EF@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Li Yang" <leoli@freescale.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Leo

As you know I working with your earlier patches, trying to adopt them
for
8321. Everthing works but ethernet on UCC2 and UCC4, ethernet on UCC3
works though.

Anyhow I found some minor changes I had to do to match 8321 that is
generic 83xx code.
Below is the first:
> ---
>  arch/powerpc/sysdev/qe_lib/qe_io.c |  272=20
> +#define NUM_OF_PAR_IOS  7

NUM_OF_PAR_IOS is 4 on 8321

> +static int qe_irq_ports[NUM_OF_PAR_IOS][NUM_OF_PINS] =3D {
> +	/* 0-7 */          /* 8-15 */      /* 16 - 23 */     /*=20
> 24 - 31 */
> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1, 1,0,0,0,0,0,0,0,=20
> 0,0,0,0,0,1,1,0},
> +	{0,0,0,1,0,1,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0,=20
> 0,0,1,1,0,0,0,0},
> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,=20
> 0,0,0,1,1,1,0,0},
> +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 1,1,0,0,0,0,0,0,=20
> 0,0,1,1,0,0,0,0},
> +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0,=20
> 1,1,1,1,0,0,0,1},
> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0,=20
> 0,0,0,0,0,0,0,0},
> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,=20
> 0,0,0,0,0,0,0,1}
> +};

qe_irq_ports is diffrent on 8321 not only the number of rows.

These needs to configuruable based on CPU model and/or type of board.

 Jocke
