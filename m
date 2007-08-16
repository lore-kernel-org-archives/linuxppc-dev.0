Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59D3EDDEE1
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 01:26:28 +1000 (EST)
Message-ID: <46C46C9A.2000107@freescale.com>
Date: Thu, 16 Aug 2007 10:26:18 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: add setmaskedbits macros
References: <11872134502476-git-send-email-timur@freescale.com>
	<2DFE7EFC-6B9F-4149-83AE-5502DD25C14C@kernel.crashing.org>
	<46C46AB7.6070903@freescale.com>
	<9CE3D32E-B9C6-43B8-B944-45CE1DCCE8A2@kernel.crashing.org>
In-Reply-To: <9CE3D32E-B9C6-43B8-B944-45CE1DCCE8A2@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>>     setmaskedbits_be32(&uccp->gumr_l,
>>         UCC_SLOW_GUMR_L_MODE_QMC | UCC_SLOW_GUMR_L_TDCR_1 |
>>         UCC_SLOW_GUMR_L_RDCR_16,
>>                 UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK |
>>         UCC_SLOW_GUMR_L_RDCR_MASK);
>>
>>     setmaskedbits_be32(&uccp->gumr_h,
>>         UCC_SLOW_GUMR_H_SUART | UCC_SLOW_GUMR_H_TRX |
>>         UCC_SLOW_GUMR_H_TTX, UCC_SLOW_GUMR_H_RFW);
> 
> Can you also show what the UCC_SLOW* values look like.

The second example is actually a trick that lets me set some bits and clear 
others in one shot, so for the gumr_h register, all of the above values are 
single bits.  I guess that's not a good example.

For gumr_l, we have:

#define UCC_SLOW_GUMR_L_TDCR_MASK	0x00030000
#define UCC_SLOW_GUMR_L_TDCR_32	        0x00030000
#define UCC_SLOW_GUMR_L_TDCR_16	        0x00020000
#define UCC_SLOW_GUMR_L_TDCR_8	        0x00010000
#define UCC_SLOW_GUMR_L_TDCR_1	        0x00000000
#define UCC_SLOW_GUMR_L_RDCR_MASK	0x0000c000
#define UCC_SLOW_GUMR_L_RDCR_32		0x0000c000
#define UCC_SLOW_GUMR_L_RDCR_16	        0x00008000
#define UCC_SLOW_GUMR_L_RDCR_8	        0x00004000
#define UCC_SLOW_GUMR_L_RDCR_1		0x00000000
#define UCC_SLOW_GUMR_L_MODE_MASK	0x0000000F
#define UCC_SLOW_GUMR_L_MODE_BISYNC	0x00000008
#define UCC_SLOW_GUMR_L_MODE_AHDLC	0x00000006
#define UCC_SLOW_GUMR_L_MODE_UART	0x00000004
#define UCC_SLOW_GUMR_L_MODE_QMC	0x00000002

So for example, I could not use setbits32 to set UCC_SLOW_GUMR_L_RDCR_16 (10) 
if it was currently UCC_SLOW_GUMR_L_RDCR_32 (11).


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
