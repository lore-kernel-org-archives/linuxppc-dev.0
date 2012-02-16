Return-Path: <b-cousson@ti.com>
Message-ID: <4F3D424C.2020306@ti.com>
Date: Thu, 16 Feb 2012 18:52:12 +0100
From: "Cousson, Benoit" <b-cousson@ti.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v5 08/27] irq_domain: Move irq_domain code from powerpc
 to kernel/irq
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-9-git-send-email-grant.likely@secretlab.ca>
 <4F3D3F21.3060905@ti.com>
In-Reply-To: <4F3D3F21.3060905@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OK, forget about it, I've just seen your email on that and pulled your 
latest update.

Regards,
Benoit

On 2/16/2012 6:38 PM, Cousson, Benoit wrote:
> Hi Grant,
>
> It looks like there is a small regression in that update, it cannot
> build due to a missing semi-colon.
>
> On 2/16/2012 10:09 AM, Grant Likely wrote:
>> +/**
>> + * irq_find_mapping() - Find a linux irq from an hw irq number.
>> + * @host: domain owning this hardware interrupt
>> + * @hwirq: hardware irq number in that host space
>> + *
>> + * This is a slow path, for use by generic code. It's expected that an
>> + * irq controller implementation directly calls the appropriate low
>> level
>> + * mapping function.
>> + */
>> +unsigned int irq_find_mapping(struct irq_domain *host,
>> + irq_hw_number_t hwirq)
>> +{
>> + unsigned int i;
>> + unsigned int hint = hwirq % irq_virq_count;
>> +
>> + /* Look for default host if nececssary */
>> + if (host == NULL)
>> + host = irq_default_host;
>> + if (host == NULL)
>> + return NO_IRQ;
>> +
>> + /* legacy -> bail early */
>> + if (host->revmap_type == IRQ_DOMAIN_MAP_LEGACY)
>> + return hwirq;
>> +
>> + /* Slow path does a linear search of the map */
>> + if (hint == 0)
>> + hint = 1;
>> + i = hint;
>> + do {
>> + struct irq_data *data = irq_get_irq_data(i);
>> + if (data&& (data->domain == host)&& (data->hwirq == hwirq))
>> + return i;
>> + i++;
>> + if (i>= irq_virq_count)
>> + i = 1
>
> The ";" is missing.
>
> Regards,
> Benoit
