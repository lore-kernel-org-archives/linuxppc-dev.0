Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 967DF2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 10:56:49 +1000 (EST)
Message-ID: <5032DCC8.1040005@freescale.com>
Date: Mon, 20 Aug 2012 19:56:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH V8] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1345457161-4731-1-git-send-email-B38951@freescale.com>
 <5032B455.3080607@freescale.com>
In-Reply-To: <5032B455.3080607@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, Bradley Hughes <bhughes@silicontkx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2012 05:04 PM, Scott Wood wrote:
> On 08/20/2012 05:06 AM, Jia Hongtao wrote:
>> @@ -842,38 +839,60 @@ void __devinit fsl_pci_init(void)
>>  			node = fsl_pci_primary;
>>  
>>  			if (of_match_node(pci_ids, node))
>> -				break;
>> +				return;
>>  		}
>> -	}
>>  
>> -	node = NULL;
>> -	for_each_node_by_type(node, "pci") {
>> -		if (of_match_node(pci_ids, node)) {
>> +		node = of_find_node_by_type(NULL, "pci");
>> +		if (of_match_node(pci_ids, node))
>>
> 
> What if the node returned doesn't match?  If you're checking for this,
> handle the else-case (even if just with an error message).

Or just use of_find_matching_node().

Also, we probably need to check of_device_is_available() here (like
fsl_add_bridge does), and move on to the next PCI bus if it's disabled.

-Scott
