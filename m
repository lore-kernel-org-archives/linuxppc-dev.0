Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id AE1F0B6F2B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 08:53:35 +1100 (EST)
Date: Thu, 10 Dec 2009 00:53:34 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Mark Ware <mware@elphinstone.net>
Subject: Re: [PATCH v2] cpm2_pic: Allow correct flow_types for port C
	interrupts
Message-ID: <20091209215334.GA536@oksana.dev.rtsoft.ru>
References: <4B1EF3E9.8050005@elphinstone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4B1EF3E9.8050005@elphinstone.net>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 09, 2009 at 11:48:41AM +1100, Mark Ware wrote:
> Port C interrupts can be either falling edge, or either edge.
> Other external interrupts are either falling edge or active low.
> 
> Signed-Off-By: Mark Ware <mware@elphinstone.net>

Looks correct (checked with 8272 and 8555 specs).

Reviewed-by: Anton Vorontsov <avorontsov@ru.mvista.com>


Cosmetic nitpicks below. I tend to think they don't desire
another resend, but I couldn't resist making them anyway. ;-)

[...]
> +	if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0) {
> +		if (flow_type == IRQ_TYPE_NONE)
> +			flow_type = IRQ_TYPE_EDGE_BOTH;
> +
> +		if ((flow_type != IRQ_TYPE_EDGE_BOTH) && 
> +			(flow_type != IRQ_TYPE_EDGE_FALLING)) {

I'd place one more tab here. And parenthesis aren't actually needed.

> +			printk(KERN_ERR "CPM2 PIC: sense type 0x%x not supported\n",
> +				flow_type);
> +			return -EINVAL;
> +		}
> +	} else {
> +		if (flow_type == IRQ_TYPE_NONE)
> +			flow_type = IRQ_TYPE_LEVEL_LOW;
> +
> +		if (flow_type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH)) {
> +			printk(KERN_ERR "CPM2 PIC: sense type 0x%x not supported\n",
> +				flow_type);

pr_err is shorter. Also, this message is duplicated. Would be better
to do something like:

	if (somethingwrong)
		goto err_sense;
	...
	return 0;

err_sense:
	pr_err("CPM2 PIC: sense type 0x%x not supported\n", flow_type);
	return -EINVAL;
}

Or we may don't print any errors at all. For internal interrupts
we don't print them anyway, i.e. the current code has just

	return (flow_type & IRQ_TYPE_LEVEL_LOW) ? 0 : -EINVAL;

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
