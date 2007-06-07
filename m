Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 671A3DDEF6
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:42:47 +1000 (EST)
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <af3aa7bd5ff385f5ad94aa7c1d456a35@kernel.crashing.org>
References: <1181147415.5674.108.camel@rhino>
	<af3aa7bd5ff385f5ad94aa7c1d456a35@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:42:45 -0700
Message-Id: <1181234565.5674.182.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 15:01 +0200, Segher Boessenkool wrote:
> > +	/* enable superio @ 0x4e and keyboard/mouse address decoding */
> > +	pci_write_config_byte(dev, 0x63, 0x90);
> 
> I doubt that comment is accurate.

m1575 legacy interface device register 0x63 is the legacy I/O decoding
control.

Writing 0x90 enables ports 0x4e and 0x4f for Super I/O configuration and
ports 0x60 and 0x64 for keyboard/mouse.

> 
> > +	outb(0x07, 0x4e);	/* device selector register */
> > +	outb(0x07, 0x4f);	/* select keyboard registers (device 7) */
> 
> Please abstract out the 4e,4f access sequence, so
> you can just say  write_sio(0x30, 1);  or similar.

Sure.

> 
> > +	/* Enable superio runtime registers for gpio in pci i/o space */
> > +	outb(0x20, 0x4e);	/* device id register */
> 
> This write is superfluous as far as I can see.

Yes, it appears so.  I'll remove it.

--Wade
