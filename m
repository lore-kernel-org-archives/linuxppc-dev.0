Return-Path: <matsumoto.hiroo@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B07DB6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 22:42:15 +1000 (EST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id D8A603EE0B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 21:42:10 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B8AC045DE50
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 21:42:10 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id A2A7A45DE4D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 21:42:10 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9436D1DB803E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 21:42:10 +0900 (JST)
Received: from m0001.s.css.fujitsu.com (m0001.s.css.fujitsu.com [10.23.4.186])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 522181DB803B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 21:42:10 +0900 (JST)
Message-ID: <4FD0A257.4070506@jp.fujitsu.com>
Date: Thu, 07 Jun 2012 21:45:11 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 0/2] Add pcibios_device_change_notifier
References: <4FBC4C86.9050206@jp.fujitsu.com>
 <1338960416.7150.160.camel@pasglop>
In-Reply-To: <1338960416.7150.160.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, jbarnes@virtuousgeek.org,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I apologize for my late reply.

> On Wed, 2012-05-23 at 11:33 +0900, Hiroo Matsumoto wrote:
>> This patchset is for PCI hotplug.
>>
>>
>> pcibios_setup_bus_devices which sets DMA and IRQs of PCI device is called
>> only when boot. DMA setting in probe for PCI driver, like dma_set_mask,
>> does not work on powerpc platform. So it is need to set DMA and IRQs of
>> PCI device when hotplug.
>>
>> 1. Moving pcibios_setup_bus_devices code to pcibios_device_change_notifier
>>    which is registered to bus notifier in pcibios_init.
>> 2. Removing caller and callee of pcibios_setup_bus_devices bus notifier
>>    works instead of pcibios_setup_bus_devices.
>> 3. Using this bus notifier for microblaze because microblaze/PCI is similer
>>    with powerpc/PCI.
> 
> This makes me a bit nervous (that doesn't mean it's not right, but
> we need some careful auditing & testing here, which I won't be
> able to do until I'm back from leave). Mostly due to the change in when
> we do the work. 
> 
> pcibios_fixup_bus() used to be called early on in the initial scan pass.
> 
> Your code causes the code to be called -much- later when registering the
> device with the device model. Are we 100% certain nothing will happen in
> between that might rely on the stuff being setup already ? It might well
> be ok, but I want us to triple check that.
> 
> Now, if we are ok to do the setup that late (basically right before the
> driver probe() routine gets called), would it make sense to simplify
> things even further ... and do it from pcibios_enable_device() ? Thus
> avoiding the notifier business completely or is that pushing it too
> far ?
> 

As you said, there are times between pcibios_fixup_bus and device_add.
I'm agree with you.
But it is difficult for me to verify these by myself.
Can I ask for your help?
I will wait that you are back from leave.

> Also you seem to add:
> 
> +               /* Setup OF node pointer in the device */
> +               dev->dev.of_node = pci_device_to_OF_node(dev);
> 
> This shouldn't be needed anymore, the device node should be setup by the
> core nowadays. Is this just a remnant of you rebasing an old patch or do
> you have a good reason to add this statement ?

No, I don't have a good reason to add this statement.
I just tried to make this code be same with pcibios_setup_bus_devices.
Thanks for your review and comment.

> 
> Cheers,
> Ben.
> 
> 
> 
> 


Regards.

Hiroo MATSUMOTO
