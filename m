Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56CC2681A7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 14:33:09 +1000 (EST)
Message-ID: <4313E17C.4040401@pobox.com>
Date: Tue, 30 Aug 2005 00:33:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20050830024840.GA5381@dmt.cnet> <4313D4D6.7080108@pobox.com>
	<20050830035338.GA5755@dmt.cnet>
In-Reply-To: <20050830035338.GA5755@dmt.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Marcelo Tosatti wrote:
> On Mon, Aug 29, 2005 at 11:39:02PM -0400, Jeff Garzik wrote:
> 
>>Marcelo Tosatti wrote:
>>
>>>+static int voltage_set(int slot, int vcc, int vpp)
>>>+{
>>>+	u_int reg = 0;
>>>+
>>>+	switch(vcc) {
>>>+	case 0: break;
>>>+	case 33:
>>>+		reg |= BCSR1_PCVCTL4;
>>>+		break;
>>>+	case 50: 
>>>+		reg |= BCSR1_PCVCTL5;
>>>+		break;
>>>+	default: 
>>>+		return 1;
>>>+	}
>>>+
>>>+	switch(vpp) {
>>>+	case 0: break;
>>>+	case 33: 
>>>+	case 50:
>>>+		if(vcc == vpp)
>>>+			reg |= BCSR1_PCVCTL6;
>>>+		else
>>>+			return 1;
>>>+		break;
>>>+	case 120: 
>>>+		reg |= BCSR1_PCVCTL7;
>>>+	default:
>>>+		return 1;
>>>+	}
>>>+
>>>+	if(!((vcc == 50) || (vcc == 0)))
>>>+		return 1;
>>>+
>>>+	/* first, turn off all power */
>>>+
>>>+	*((uint *)RPX_CSR_ADDR) &= ~(BCSR1_PCVCTL4 | BCSR1_PCVCTL5
>>>+				     | BCSR1_PCVCTL6 | BCSR1_PCVCTL7);
>>>+
>>>+	/* enable new powersettings */
>>>+
>>>+	*((uint *)RPX_CSR_ADDR) |= reg;
>>
>>Should use bus read/write functions, such as foo_readl() or iowrite32().
> 
> 
> The memory map structure which contains device configuration/registers
> is _always_ directly mapped with pte's (the 8xx is a chip with builtin
> UART/network/etc functionality).
> 
> I don't think there is a need to use read/write acessors.

There are multiple reasons:

* Easier reviewing.  One cannot easily distinguish between writing to 
normal kernel virtual memory and "magic" memory that produces magicaly 
side effects such as initiating DMA of a net packet.

* Compiler safety.  As the code is written now, you have no guarantees 
that the compiler won't combine two stores to the same location, etc. 
Accessor macros are a convenient place to add compiler barriers or 
'volatile' notations that the MPC8xx code lacks.

* Maintainable.  foo_read[bwl] or foo_read{8,16,32} are preferred 
because that's the way other bus accessors look like -- yes even 
embedded SoC buses benefit from these code patterns.  You want your 
driver to look like other drivers as much as possible.

* Convenience.  The accessors can be a zero overhead memory read/write 
at a minimum.  But they can also be convenient places to use special 
memory read/write instructions that specify uncached memop, compiler 
barriers, memory barriers, etc.

Regards,

	Jeff
