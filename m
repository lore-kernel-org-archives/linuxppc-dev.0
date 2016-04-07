Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgNc32HBHzDq6F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 10:23:30 +1000 (AEST)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 21:23:28 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 714C4352005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 20:23:14 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u36NNSVu24904004
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 20:23:28 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u370NPCM002562
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 21:23:25 -0300
Subject: Re: [PATCH 2/2] powerpc/pseries: Check if EEH is enabled on DDW
 mechanism code
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1453234700-27593-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160202234811.GA17911@gwshan> <56B1F1FC.1080403@linux.vnet.ibm.com>
 <20160204053023.GB16304@gwshan>
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Michael Ellerman <mpe@ellerman.id.au>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5705A87C.2010901@linux.vnet.ibm.com>
Date: Wed, 6 Apr 2016 21:23:24 -0300
MIME-Version: 1.0
In-Reply-To: <20160204053023.GB16304@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/04/2016 03:30 AM, Gavin Shan wrote:
> On Wed, Feb 03, 2016 at 10:26:36AM -0200, Guilherme G. Piccoli wrote:
>> On 02/02/2016 09:48 PM, Gavin Shan wrote:
>>
>> Gavin, thanks very much for the clarification. So, we can interchange
>> edev->config_addr with pdn->pci_ext_config_space ?
>> This would solve the issue with DDW being enabled when EEH is not.
>>
>> I hit the issue on PowerVM (PHyp). I wasn't able to perform hotplug in qemu
>> that time I was testing this - I can re-test on qemu. Can we use pci_dn
>> config address in qemu guest too?
>>
>
> On PowerKVM, QEMU can't recognize (1). pHyp is expected to support both
> of them. Please have a try with (1) when eeh_enabled() returns false.
> The address (1) can be retrieved from pci_dn as below:
>
> 	(pdn->busno << 8) | (pdn->devfn)
>
> Thanks,
> Gavin
>

Gavin, thanks very much for your advice. And sorry for my huge delay in 
replying this...

I tested the pci_dn's busno/devfn solution in both PHyp and qemu and it 
worked fine - DDW was enabled with success.

I just sent v2 patches to the list - your review is much appreciated.

Thanks,


Guilherme
