Return-Path: <martijn.de.gouw@prodrive-technologies.com>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by lists.ozlabs.org (Postfix) with ESMTP id 164181A0156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 23:57:28 +1000 (EST)
Message-ID: <53A83243.1080605@prodrive-technologies.com>
Date: Mon, 23 Jun 2014 15:57:23 +0200
From: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
MIME-Version: 1.0
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Subject: Re: [PATCH] fsl-rio: add support for mapping inbound windows
References: <1402657758-3019-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
 <8D983423E7EDF846BB3056827B8CC5D15CC9575C@corpmail1.na.ads.idt.com>
In-Reply-To: <8D983423E7EDF846BB3056827B8CC5D15CC9575C@corpmail1.na.ads.idt.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
 "stef.van.os@prodrive-technologies.com"
 <stef.van.os@prodrive-technologies.com>,
 Martijn de Gouw <martijn.de.gouw@prodrive.nl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Wood,
 Barry" <Barry.Wood@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/18/2014 05:17 PM, Bounine, Alexandre wrote:
> On Friday, June 13, 2014 7:09 AM Martijn de Gouw [mailto:martijn.de.gouw@prodrive-
> technologies.com] wrote:
>
>> Add support for mapping and unmapping of inbound rapidio windows.
>>
>> Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive.nl>
>> ---
> ... skip ...
>
>> +
>> +int fsl_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
>> +	u64 rstart, u32 size, u32 flags)
>> +{
>> +	struct rio_priv *priv = mport->priv;
>> +	u32 base_size;
>> +	unsigned int base_size_log;
>> +	u64 win_start, win_end;
>> +	u32 riwar;
>> +	int i;
>> +
>> +	base_size_log = __ilog2(size) + ((size & (size - 1)) != 0);
>> +	base_size = 1 << base_size_log;
>> +
>> +	for (i = 0; i < RIO_INB_ATMU_COUNT; i++) {
>> +		riwar = in_be32(&priv->inb_atmu_regs[i].riwar);
>> +		if ((riwar & RIWAR_ENABLE) == 0)
>> +			break;
>> +		/* check conflicting ranges */
>> +		win_start = ((u64)(in_be32(&priv->inb_atmu_regs[i].riwbar) & RIWBAR_BADD_MASK))
>> +			<< RIWBAR_BADD_VAL_SHIFT;
>> +		win_end = win_start + ((1 << ((riwar & RIWAR_SIZE_MASK) + 1)) - 1);
>> +		if (rstart < win_end && (rstart + size) > win_start)
>> +			return -EINVAL;
>> +	}
>
> It looks like the check for conflicting ranges assumes sequential mapping requests only.
> This check will be missed if ATMU windows are dynamically mapped/unmapped out-of-order.
> Because the unmap callback is implemented please consider possibility of using ATMU windows
> in any order.
>

You are correct. I'll send a new patch which first check all enabled 
windows for conflicts, before is searches for a free ATMU.


-- 
Martijn de Gouw
Engineer
Prodrive Technologies B.V.
Mobile: +31 63 17 76 161
Phone:  +31 40 26 76 200
