Return-Path: <bigeasy@linutronix.de>
Message-ID: <4F46AE07.2000105@linutronix.de>
Date: Thu, 23 Feb 2012 22:22:15 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 22/25] irq_domain/x86: Convert x86 (embedded) to use
 common irq_domain
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <1327700179-17454-23-git-send-email-grant.likely@secretlab.ca>
 <20120128164405.GA20763@linutronix.de>
 <20120130195842.GT28397@ponder.secretlab.ca>
 <20120201141705.GF9587@linutronix.de>
 <CACxGe6vZxWXUG-WJFWDaoH3+PYBGWOXb291_jn9TdjrSF=p_JQ@mail.gmail.com>
 <CACxGe6tQvBZBMynXbknWx1o1s5TPEN7rXrNOOAjC5F_dz9B51w@mail.gmail.com>
In-Reply-To: <CACxGe6tQvBZBMynXbknWx1o1s5TPEN7rXrNOOAjC5F_dz9B51w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Milton Miller <miltonm@bga.com>,
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

On 02/23/2012 08:56 PM, Grant Likely wrote:
> On Wed, Feb 1, 2012 at 11:06 AM, Grant Likely<grant.likely@secretlab.ca>  wrote:
>> On Wed, Feb 1, 2012 at 7:17 AM, Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>  wrote:
>>> * Grant Likely | 2012-01-30 12:58:42 [-0700]:
>>>
>>>> Ugh.  This isn't easy.  The legacy mapping really needs all the
>>>
>>> Feel free to merge this patch. I don't have the time to look at this now
>>> so I take a look at the ioapic later.
>>
>> There's no rush here.  I can leave it as-is with IRQ_DOMAIN turned off
>> for x86 for now.
>
> Turns out I have to enable IRQ_DOMAIN for x86 because the TI TWL4030
> driver needs it.  I do need to apply this patch.  Until something
> better can be implemented, can I change ioapic_add_ofnode() so that it
> allocates all irq_descs immediately.  It's not ideal, but every other
> approach I've looked at results in nasty hacks.
>
> Looking at the ioapic code, it appears to handle preallocated
> irq_descs gracefully.

Please merge your initial patch as-it.

> Does adding this loop help (apologies if it is whitespace damaged, I
> cut&paste it):
>
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 3ae2ced..89c1310 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -345,7 +345,7 @@ const struct irq_domain_ops ioapic_irq_domain_ops = {
>   static void __init ioapic_add_ofnode(struct device_node *np)
>   {
>   	struct resource r;
> -	int i, ret;
> +	int i, j, ret;
>
>   	ret = of_address_to_resource(np, 0,&r);
>   	if (ret) {
> @@ -361,6 +361,14 @@ static void __init ioapic_add_ofnode(struct
> device_node *np)
>
>   			gsi_cfg = mp_ioapic_gsi_routing(i);
>
> +			/*
> +			 * Preallocate irq_descs so that the legacy mapping
> +			 * works, but don't set them up.
> +			 * io_apic_setup_irq_pin_once() will finish the set up.
> +			 */
> +			for (j = 0; j<  32; j++)

It is not 32. If I remember correctly the first ioapic had 24 pins so
did the second. This is ioapic specifc.


>
> g.

Sebastian
