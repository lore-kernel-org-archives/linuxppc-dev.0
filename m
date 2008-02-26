Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D2EF2DDE34
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 23:27:44 +1100 (EST)
Message-ID: <47C40548.4080608@ru.mvista.com>
Date: Tue, 26 Feb 2008 15:25:44 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [RFC][PATCH] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock
	workaround
References: <1203634340.10422.203.camel@pasglop>	<20080222192817.GA26211@ru.mvista.com>
	<20080222144919.3ded7c54@weaponx>
In-Reply-To: <20080222144919.3ded7c54@weaponx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Fri, 22 Feb 2008 22:28:17 +0300
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
>> This patch adds ibm_newemac phy clock workaround for 440EP/440GR emacs.
>> The code is based on the previous ibm_emac driver stuff. The 440EP/440GR
>> allows controlling each EMAC clock spearately as opposed to global clock
>> selection for 440GX.
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> ---
> 
> [snip]
> 
>> +/* EMAC PHY clock workaround:
>> + * 440EP/440GR has more sane SDR0_MFR register implementation than 440GX,
>> + * which allows controlling each EMAC clock
>> + */
>> +static inline void emac_rx_clk_tx(struct emac_instance *dev)
>> +{
>> +	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX)) {
>> +		unsigned long flags;
>> +
>> +		local_irq_save(flags);
>> +		mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) |
>> +					(SDR0_MFR_ECS >> dev->cell_index));
>> +		local_irq_restore(flags);
>> +	}
>> +}
>> +
>> +static inline void emac_rx_clk_default(struct emac_instance *dev)
>> +{
>> +	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX)) {
>> +		unsigned long flags;
>> +
>> +		local_irq_save(flags);
>> +		mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) &
>> +					~(SDR0_MFR_ECS >> dev->cell_index));
>> +		local_irq_restore(flags);
>> +	}
>> +}
> 
> Why did you do local_irq_save in these two functions?  mtdcri already
> does spin_lock_irqsave...
> 
> josh

Oops, this got copy-pasted from the older ibm_emac.
Thanks,
Valentine.
