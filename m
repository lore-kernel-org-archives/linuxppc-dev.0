Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 471CB2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 03:28:15 +1000 (EST)
Message-ID: <50102C9C.7030508@freescale.com>
Date: Wed, 25 Jul 2012 12:27:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH 3/6] powerpc/fsl-pci: Determine primary bus by looking
 for ISA node
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-3-git-send-email-B38951@freescale.com>
 <500EEDD9.8050507@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A276B1@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A276B1@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2012 04:01 AM, Jia Hongtao-B38951 wrote:
>>> +/*
>>> + * Recursively scan all the children nodes of parent and find out if
>> there
>>> + * is "isa" node. Return 1 if parent has isa node otherwise return 0.
>>> + */
>>> +int has_isa_node(struct device_node *parent)
>>> +{
>>> +	static int result;
>>> +	struct device_node *cur_child;
>>> +
>>> +	cur_child = NULL;
>>> +	result = 0;
>>> +	while (!result && (cur_child = of_get_next_child(parent,
>> cur_child))) {
>>> +		/* Get "isa" node and return 1 */
>>> +		if (of_node_cmp(cur_child->type, "isa") == 0)
>>> +			return result = 1;
>>> +		has_isa_node(cur_child);
>>> +	}
>>> +
>>> +	return result;
>>> +}
>>
>> Why are you reimplementing this?  It's already in Linus's tree.  See
>> fsl_pci_init().
>>
>> Plus, your version is recursive which is unacceptable in kernel code
>> with a small stack (outside of a few rare examples where the depth has a
>> small fixed upper bound), and once it finds an ISA node, it returns 1
>> forever, regardless of what node you pass in in the future.
>>
>> -Scott
> 
> Yes, recursive function is not recommended for kernel but maybe it's not unacceptable.
> This function is not so deep stacked and simple. In my opinion this is acceptable.

The depth is limited not by code, but by externally provided data.

Granted a bad device tree can mess the kernel up in far worse ways, but
still it's a bad idea and totally unnecessary.

-Scott
