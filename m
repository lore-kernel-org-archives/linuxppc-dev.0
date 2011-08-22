Return-Path: <matthieu.castet@parrot.com>
Received: from co202.xi-lite.net (co202.xi-lite.net [149.6.83.202])
	by ozlabs.org (Postfix) with ESMTP id 7A925B6F72
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 02:13:45 +1000 (EST)
Message-ID: <4E528036.5070801@parrot.com>
Date: Mon, 22 Aug 2011 18:13:42 +0200
From: Matthieu CASTET <matthieu.castet@parrot.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
	<4E4E2571.20409@parrot.com> <4E4EA70B.9050203@freescale.com>
	<1314010719.2644.114.camel@sauron>
	<20110822152530.GA16794@parrot.com>
	<4E527E0F.1010500@freescale.com>
In-Reply-To: <4E527E0F.1010500@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem Bityutskiy <dedekind1@gmail.com>, LiuShuo <b35362@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Ivan Djelic <ivan.djelic@parrot.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood a écrit :
> On 08/22/2011 10:25 AM, Ivan Djelic wrote:
>> Did you take into account the fact that because MTD thinks this a 2K chip,
>> you will have to wait twice for the nand busy read time (typically 25 us) per
>> each 4K read. In other words, to read 4 kBytes you will do:
>>
>> 1. send read0 (00), send address, send read1 (30)
>> 2. wait tRB
>> 3. transfer 2 kBytes
>> 4. send read0 (00), send address, send read1 (30)
>> 5. wait tRB
>> 6. transfer 2 kBytes
>>
>> Same problem for writes (but rather 100 us instead of 25 us).
>>
>> How does that compare with hw ecc gain in terms of performance ?
> 
> We'd have the double-delay with the sw ecc plus buffering approach as well.
> 
> To eliminate it we'd need to do an extra data transfer without reissuing
> the command, which Shuo was unable to get to work.
> 
That's weird because our controller seems quite flexible [1].

Something like that should work ?

            out_be32(&lbc->fir,
                     (FIR_OP_CM2 << FIR_OP0_SHIFT) |
                     (FIR_OP_CA  << FIR_OP1_SHIFT) |
                     (FIR_OP_PA  << FIR_OP2_SHIFT) |
                     (FIR_OP_WB  << FIR_OP3_SHIFT));
refill FCM buffer with next 2k data

            out_be32(&lbc->fir,
                     (FIR_OP_WB  << FIR_OP3_SHIFT) |
                     (FIR_OP_CM3 << FIR_OP4_SHIFT) |
                     (FIR_OP_CW1 << FIR_OP5_SHIFT) |
                     (FIR_OP_RS  << FIR_OP6_SHIFT));



[1]
    __be32 fir;             /**< Flash Instruction Register */
#define FIR_OP0      0xF0000000
#define FIR_OP0_SHIFT        28
#define FIR_OP1      0x0F000000
#define FIR_OP1_SHIFT        24
#define FIR_OP2      0x00F00000
#define FIR_OP2_SHIFT        20
#define FIR_OP3      0x000F0000
#define FIR_OP3_SHIFT        16
#define FIR_OP4      0x0000F000
#define FIR_OP4_SHIFT        12
#define FIR_OP5      0x00000F00
#define FIR_OP5_SHIFT         8
#define FIR_OP6      0x000000F0
#define FIR_OP6_SHIFT         4
#define FIR_OP7      0x0000000F
#define FIR_OP7_SHIFT         0
#define FIR_OP_NOP   0x0    /* No operation and end of sequence */
#define FIR_OP_CA    0x1        /* Issue current column address */
#define FIR_OP_PA    0x2        /* Issue current block+page address */
#define FIR_OP_UA    0x3        /* Issue user defined address */
#define FIR_OP_CM0   0x4        /* Issue command from FCR[CMD0] */
#define FIR_OP_CM1   0x5        /* Issue command from FCR[CMD1] */
#define FIR_OP_CM2   0x6        /* Issue command from FCR[CMD2] */
#define FIR_OP_CM3   0x7        /* Issue command from FCR[CMD3] */
#define FIR_OP_WB    0x8        /* Write FBCR bytes from FCM buffer */
#define FIR_OP_WS    0x9        /* Write 1 or 2 bytes from MDR[AS] */
#define FIR_OP_RB    0xA        /* Read FBCR bytes to FCM buffer */
#define FIR_OP_RS    0xB        /* Read 1 or 2 bytes to MDR[AS] */
#define FIR_OP_CW0   0xC        /* Wait then issue FCR[CMD0] */
#define FIR_OP_CW1   0xD        /* Wait then issue FCR[CMD1] */
#define FIR_OP_RBW   0xE        /* Wait then read FBCR bytes */
#define FIR_OP_RSW   0xE        /* Wait then read 1 or 2 bytes */
