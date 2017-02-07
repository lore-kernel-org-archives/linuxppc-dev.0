Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHhX135nKzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 22:12:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com
Subject: Re: [PATCH] drivers/misc/cxl: Avoid unnecessary error message
In-Reply-To: <43e94920-66a0-88af-81fe-5733ad7cf743@au1.ibm.com>
References: <1485834216-25191-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <43e94920-66a0-88af-81fe-5733ad7cf743@au1.ibm.com>
Date: Tue, 07 Feb 2017 22:12:48 +1100
Message-ID: <871svab6fj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> On 31/01/17 14:43, Gavin Shan wrote:
>> The following error message was observed. It's complaining M32
>> memory window is missed on virtual PHB, which is a bit confusing.
>> The problem is the memory windows are never updated from its
>> device-tree node.
>>
>>    PCI: Memory resource 0 not set for host bridge \
>>    /pciex@3fffe40000000/pci@0/device@0
>>
>> This avoids the unnecessary error message by updating the PHB's
>> memory windows with pci_process_bridge_OF_ranges(). The function
>> is exported as well.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> I talked this over with Gavin in person today.
>
> We don't set a memory window on the vPHB or its devices because it's not 
> necessary.
>
> The effect of this patch is to copy the memory resources from the *real* 
> PHB to the vPHB, as given through the device tree. It shouldn't have any 
> practical effect other than squashing this message.

It sounds a bit backward to me. If we don't need the resources then
why have them?

If we have code that thinks that's an error, than maybe that's what
needs fixing, or special casing for the vPHB?

cheers
