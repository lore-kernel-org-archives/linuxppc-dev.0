Return-Path: <mware@elphinstone.net>
Received: from ipmail02.adl6.internode.on.net (ipmail02.adl6.internode.on.net
	[203.16.214.140]) by ozlabs.org (Postfix) with ESMTP id F2D13B6F15
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 10:41:07 +1100 (EST)
Message-ID: <4B1EE410.1070404@elphinstone.net>
Date: Wed, 09 Dec 2009 10:41:04 +1100
From: Mark Ware <mware@elphinstone.net>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpm2_pic: Allow correct flow_types for port C interrupts
References: <4B0C9342.1000807@elphinstone.net>
	<4B1ED995.4060802@elphinstone.net> <4B1EDC97.6010301@freescale.com>
In-Reply-To: <4B1EDC97.6010301@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Mark Ware wrote:
>> Mark Ware wrote:
>>> CPM2 Port C interrupts can be either falling edge, or either edge.
>>> Other external interrupts are either falling edge or active low.
> [snip]
>>> +    /* Port C interrupts are either IRQ_TYPE_EDGE_FALLING or
>>> +     * IRQ_TYPE_EDGE_BOTH (default).  All others are
>>> IRQ_TYPE_EDGE_FALLING
>>> +     * or IRQ_TYPE_LEVEL_LOW (default)
>>> +     */
>>> +    if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0) {
>>> +        if (flow_type == IRQ_TYPE_NONE)
>>> +            flow_type = IRQ_TYPE_EDGE_BOTH;
>>> +
>>> +        if (flow_type & ~IRQ_TYPE_EDGE_BOTH) {
>>> +            printk(KERN_ERR "CPM2 PIC: sense type 0x%x not
>>> supported\n",
>>> +                flow_type);
>>> +            return -EINVAL;
>>> +        }
> 
> The above code looks like it would allow rising-only, which according to
> the changelog isn't supported.
> 
> -Scott
> 

Thanks Scott, you're right.  I'll update and send v2 shortly.

- Mark
