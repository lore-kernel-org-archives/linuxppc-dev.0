Subject: Re: MVME2100 patch
From: Adrian Cox <adrian@humboldt.co.uk>
To: okorpil@fh-landshut.de
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.58.0404071641050.16422@ppcproject1>
References: <Pine.LNX.4.58.0404071641050.16422@ppcproject1>
Content-Type: text/plain
Message-Id: <1081428630.19021.55.camel@newt>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 13:50:30 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-04-07 at 15:51, okorpil@fh-landshut.de wrote:

> Was wrong about IRQ stuff last time - I'm off course operation in serial
> IRQ mode here, because there is a serial IRQ source (8259(attached to the
> IRQO of the OpenPIC, giving me the 12 (16 in total, 4 unused) IRQs I care
> about. But no cascade within that 16 lines, so no cascade hook.

I'm not sure what you mean here. The presence of an i8259 cascade is
independent of the EPIC serial mode. EPIC serial mode is a hardware
design decision, which is required if you need to feed more than 5
sources into the EPIC. An i8259 is just another source, and as far as I
can tell, there is no i8259 on the MVME2100.

The RTC is probably connected to IRQ 8 because you set CONFIG_RTC=y. Use
CONFIG_GEN_RTC instead.

- Adrian Cox


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
