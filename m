Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE1B9DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 03:50:12 +1100 (EST)
Message-ID: <47388431.3020609@freescale.com>
Date: Mon, 12 Nov 2007 10:49:53 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] powerpc: Add EXPORT_SYMBOL for symbols required by fs_enet
	and cpm_uart
References: <47373571.3070605@scram.de> <20071111201503.GA18749@infradead.org>
In-Reply-To: <20071111201503.GA18749@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-kernel@vger.kernel.org, paulus@samba.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Sun, Nov 11, 2007 at 06:01:37PM +0100, Jochen Friedrich wrote:
>> --- a/arch/powerpc/sysdev/commproc.c
>> +++ b/arch/powerpc/sysdev/commproc.c
>> @@ -51,6 +51,8 @@ static void m8xx_cpm_dpinit(void);
>> static uint host_buffer; /* One page of host buffer */
>> static uint host_end;    /* end + 1 */
>> cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
>> +EXPORT_SYMBOL(cpmp);
> 
> Sorry, but this is a nightmare waiting to happen.  Please define
> proper accessors instead.

We have proper accessors: in_be32, out_be16, etc.

Now, is the huge struct encompassing all of immr space a bad idea? 
Sure.  Are we working towards getting rid of it?  Yes.  Is that a reason 
to keep modules from working in the meantime?  No.

> (And get rid of the typedef while you're at it)

Again, changing all the users is a bit beyond the scope of this patch.

-Scott
