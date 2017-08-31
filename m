Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjd3h53ygzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 19:53:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Question: handling early hotplug interrupts
In-Reply-To: <5de488df-5bf0-8e91-8b11-4a36228a5183@linux.vnet.ibm.com>
References: <e5975dfb-6609-a3b1-7ea7-b9e8fe31b669@linux.vnet.ibm.com>
 <1504043700.2358.37.camel@au1.ibm.com>
 <518374ee-43bd-f873-7742-6c0d42db68d8@linux.vnet.ibm.com>
 <87378937tk.fsf@concordia.ellerman.id.au>
 <5de488df-5bf0-8e91-8b11-4a36228a5183@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 19:53:18 +1000
Message-ID: <87fuc8t65t.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> On 08/30/2017 01:09 AM, Michael Ellerman wrote:
...
>> 
>> So this is simply a case of the init calls being out of order.
>> 
>> We either need to create the pseries_hp_wq earlier, or register the
>> event sources IRQs later. I'm not sure which is better.
>
> Perhaps I'm erring on the side of caution, but I think registering
> the IRQs later would be better. I think this would give the kernel
> more time to come and better handle a hotplug request.

Yeah I agree, unless there's some other reason why we must register
those IRQs early, but I don't know of one.

cheers
