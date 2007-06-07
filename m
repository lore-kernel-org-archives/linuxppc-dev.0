Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6AB88DDED9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 23:01:27 +1000 (EST)
In-Reply-To: <1181147415.5674.108.camel@rhino>
References: <1181147415.5674.108.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <af3aa7bd5ff385f5ad94aa7c1d456a35@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
Date: Thu, 7 Jun 2007 15:01:20 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	/* enable superio @ 0x4e and keyboard/mouse address decoding */
> +	pci_write_config_byte(dev, 0x63, 0x90);

I doubt that comment is accurate.

> +	outb(0x07, 0x4e);	/* device selector register */
> +	outb(0x07, 0x4f);	/* select keyboard registers (device 7) */

Please abstract out the 4e,4f access sequence, so
you can just say  write_sio(0x30, 1);  or similar.

> +	/* Enable superio runtime registers for gpio in pci i/o space */
> +	outb(0x20, 0x4e);	/* device id register */

This write is superfluous as far as I can see.


Segher
