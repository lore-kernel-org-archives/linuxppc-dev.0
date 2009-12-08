Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70BB5B6F08
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 10:10:07 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB8N9mDD012851
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2009 16:09:59 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nB8N9oPJ017670
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2009 17:09:51 -0600 (CST)
Message-ID: <4B1EDC97.6010301@freescale.com>
Date: Tue, 08 Dec 2009 17:09:11 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mark Ware <mware@elphinstone.net>
Subject: Re: [PATCH] cpm2_pic: Allow correct flow_types for port C interrupts
References: <4B0C9342.1000807@elphinstone.net>
	<4B1ED995.4060802@elphinstone.net>
In-Reply-To: <4B1ED995.4060802@elphinstone.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Ware wrote:
> Mark Ware wrote:
>> CPM2 Port C interrupts can be either falling edge, or either edge.
>> Other external interrupts are either falling edge or active low.
[snip]
>> +	/* Port C interrupts are either IRQ_TYPE_EDGE_FALLING or
>> +	 * IRQ_TYPE_EDGE_BOTH (default).  All others are IRQ_TYPE_EDGE_FALLING
>> +	 * or IRQ_TYPE_LEVEL_LOW (default)
>> +	 */
>> +	if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0) {
>> +		if (flow_type == IRQ_TYPE_NONE)
>> +			flow_type = IRQ_TYPE_EDGE_BOTH;
>> +
>> +		if (flow_type & ~IRQ_TYPE_EDGE_BOTH) {
>> +			printk(KERN_ERR "CPM2 PIC: sense type 0x%x not supported\n",
>> +				flow_type);
>> +			return -EINVAL;
>> +		}

The above code looks like it would allow rising-only, which according to 
the changelog isn't supported.

-Scott
