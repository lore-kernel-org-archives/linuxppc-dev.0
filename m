Return-Path: <jdub@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FEA767BEB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 23:28:28 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87DSPRU031938
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 09:28:25 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k87DSPPq272494
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 07:28:25 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k87DSPpj009111
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 07:28:25 -0600
Subject: Re: [PATCH] [v2] PPC 4xx: Enable XMON on PPC 4xx boards
From: Josh Boyer <jdub@us.ibm.com>
To: Matt Porter <mporter@embeddedalley.com>
In-Reply-To: <20060907132319.GA476@matthew-porters-computer.local>
References: <1157632424.6098.32.camel@zod.rchland.ibm.com>
	<20060907132319.GA476@matthew-porters-computer.local>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 08:29:53 -0500
Message-Id: <1157635794.6098.45.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 09:23 -0400, Matt Porter wrote:
> 
> These can be represented with CONFIG_44x. Though it doesn't work for
> 440EP since it doesn't have the 36-bit memory map. It should be:
> 
> +#elif ( defined(CONFIG_44x) && !defined(CONFIG_440EP) )
> +     sccd = (volatile unsigned char *) ioremap64(0x0000000140000200ULL, 8);
> +     sccc = sccd + 5;
> +     TXRDY = 0x20;
> +     RXRDY = 1;
> +     DLAB = 0x80;

Right.  I don't have access to a 440EP board anymore, so I couldn't test
it.

> Adding in another case would enable 440EP as well:
> 
> +#elif ( defined(CONFIG_440EP) )
> +     sccd = (volatile unsigned char *) ioremap(0xef600300, 8);
> +     sccc = sccd + 5;
> +     TXRDY = 0x20;
> +     RXRDY = 1;
> +     DLAB = 0x80;

That seems correct to me.  I'll add that and send out another version
shortly.

josh
