Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E92C1A07F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 23:08:42 +1100 (AEDT)
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 13 Jan 2016 10:08:36 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id E8C8D3520072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 07:08:27 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0DC9AhV3465304
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 10:09:10 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0DC8W62014770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 10:08:33 -0200
Subject: Re: [PATCH] powerpc/eeh: Validate arch in eeh_add_device_early()
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1452681487.7404.6.camel@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <56963E40.8070702@linux.vnet.ibm.com>
Date: Wed, 13 Jan 2016 10:08:32 -0200
MIME-Version: 1.0
In-Reply-To: <1452681487.7404.6.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2016 08:38 AM, Michael Ellerman wrote:
> But eeh_enabled() is still false? That seems like it's liable to cause breakage
> elsewhere.

Yes, eeh_enabled() is false as expected. Notice that eeh_enabled() is 
telling if EEH is enabled or not, and since it's not (because there's no 
PCI adapters on machine yet!), makes sense it returns false.

At the end of runs of eeh_add_device_early(), the devices are probed and 
EEH is enabled, so the function will reflect this. Notice that the 
problem addressed by this patch is the use of eeh_enabled() in hotplug 
operations only, which in my opinion is not correct. I checked every 
other use of eeh_enable() in the code, and they all seems appropriate, 
so I expect no errors at all.


> Shouldn't the PCI hotplug code instead be taught to initialise EEH correctly
> when the first device is added?

Well, for sure there are other ways to achieve this patch's goal, like 
refactor PCI hotplug code in lots of places. But notice although the 
proposed solution is simple, it solves the issue because 
eeh_add_device_early() is ultimately the function used by PCI hotplug 
mechanism (no matter if pseries/cell/etc or the type of hotplug) to 
initialize EEH by probing the devices at the moment they are added to 
the system. In my opinion, this is exactly the location we want to 
change code to address this issue.

What do you think? Thanks very much for the review.

Cheers,


Guilherme
