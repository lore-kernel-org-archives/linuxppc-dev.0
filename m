Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08A9468186
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 13:59:43 +1000 (EST)
Date: Tue, 30 Aug 2005 00:53:38 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jeff Garzik <jgarzik@pobox.com>
Message-ID: <20050830035338.GA5755@dmt.cnet>
References: <20050830024840.GA5381@dmt.cnet> <4313D4D6.7080108@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4313D4D6.7080108@pobox.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 29, 2005 at 11:39:02PM -0400, Jeff Garzik wrote:
> Marcelo Tosatti wrote:
> >+static int voltage_set(int slot, int vcc, int vpp)
> >+{
> >+	u_int reg = 0;
> >+
> >+	switch(vcc) {
> >+	case 0: break;
> >+	case 33:
> >+		reg |= BCSR1_PCVCTL4;
> >+		break;
> >+	case 50: 
> >+		reg |= BCSR1_PCVCTL5;
> >+		break;
> >+	default: 
> >+		return 1;
> >+	}
> >+
> >+	switch(vpp) {
> >+	case 0: break;
> >+	case 33: 
> >+	case 50:
> >+		if(vcc == vpp)
> >+			reg |= BCSR1_PCVCTL6;
> >+		else
> >+			return 1;
> >+		break;
> >+	case 120: 
> >+		reg |= BCSR1_PCVCTL7;
> >+	default:
> >+		return 1;
> >+	}
> >+
> >+	if(!((vcc == 50) || (vcc == 0)))
> >+		return 1;
> >+
> >+	/* first, turn off all power */
> >+
> >+	*((uint *)RPX_CSR_ADDR) &= ~(BCSR1_PCVCTL4 | BCSR1_PCVCTL5
> >+				     | BCSR1_PCVCTL6 | BCSR1_PCVCTL7);
> >+
> >+	/* enable new powersettings */
> >+
> >+	*((uint *)RPX_CSR_ADDR) |= reg;
> 
> Should use bus read/write functions, such as foo_readl() or iowrite32().

The memory map structure which contains device configuration/registers
is _always_ directly mapped with pte's (the 8xx is a chip with builtin
UART/network/etc functionality).

I don't think there is a need to use read/write acessors.

> Don't use weird types in kernel code such as 'uint'.  Use the more 
> explicitly-sized u32.

OK, will fix the types and address the rest of your comments.

Thanks!
