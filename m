Return-Path: <cml3227@eircom.net>
Received: from stanley (unknown [193.120.93.48])
	by ozlabs.org (Postfix) with ESMTP id 237882BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Oct 2004 18:36:15 +1000 (EST)
Message-ID: <4174D1F4.2050506@eircom.net>
Date: Tue, 19 Oct 2004 09:36:04 +0100
From: Conor McLoughlin <cml3227@eircom.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <1098072098.751.32.camel@nighteyes.localdomain>
	<41738D27.4060007@eircom.net>
	<BE328096-211A-11D9-8079-003065F9B7DC@embeddededge.com>
In-Reply-To: <BE328096-211A-11D9-8079-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: Does kmalloc on MPC82xx work correctly with GFP_DMA?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for your response Dan, but there is still something that I
am not seeing correctly here.

> No, the kmalloc() space is not covered by BATs (but, that isn't
> relevant for this discussion).

On my board, I can use  my BDI2000 to look at the BAT registers.
DBAT2U is 0xC00003FE and DBAT0L is 0x00000002.

To me this looks like all of my SDRAM starting at effective address
0xC0000000 is handled by DBAT2 with cache enabled.
If I look at where it is allocating the memory with kmalloc, it is
in this area. I do get a different area of memory assigned depending
on whether or not I use GPF_DMA, but it is still in this effective area
covered by DBAT2.  What am I missing here?

 > Yes, it is DMA safe.  That's why this driver works :-)

Just because it works doesn't mean that there might not be a bug
lurking there.
I agree that it is unlikely, but I don't understand how an area of
memory at effective address 0xCxxxxxxx is not covered by the BATs.

--Conor
