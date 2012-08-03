Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D5CF2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 02:45:03 +1000 (EST)
Message-ID: <501C0007.8070209@freescale.com>
Date: Fri, 3 Aug 2012 11:44:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt support.
References: <1343745764-3788-1-git-send-email-Varun.Sethi@freescale.com>
 <609EA81E-EC64-4539-B36B-E57525CE2492@kernel.crashing.org>
In-Reply-To: <609EA81E-EC64-4539-B36B-E57525CE2492@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2012 08:19 AM, Kumar Gala wrote:
> 
> On Jul 31, 2012, at 9:42 AM, Varun Sethi wrote:
>> +	/* ioremap'ed base for error interrupt registers */
>> +	u32 __iomem	*err_regs;
>> +	/* error interrupt config */
>> +	u32			err_int_config_done;
>> +
> 
> Is this really needed ?

Probably a left over from when it was done on demand.

> 
>> 	/* Protected sources */
>> 	unsigned long		*protected;
>>
>> @@ -370,6 +381,8 @@ struct mpic
>> #define MPIC_NO_RESET			0x00004000
>> /* Freescale MPIC (compatible includes "fsl,mpic") */
>> #define MPIC_FSL			0x00008000
>> +/* Freescale MPIC supports EIMR (error interrupt mask register)*/
>> +#define MPIC_FSL_HAS_EIMR		0x00010000
> 
> Can't we use BRR for this?

BRR is used, and this is set as a result.  Better than opencoding a BRR
check a bunch of places...

-Scott
