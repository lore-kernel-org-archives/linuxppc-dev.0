Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35470B7E4B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 08:41:14 +1100 (EST)
Message-ID: <4B996375.3010103@embedded-sol.com>
Date: Thu, 11 Mar 2010 23:41:09 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B989F9B.8060708@embedded-sol.com>
	<1268339578.22204.708.camel@pasglop>
In-Reply-To: <1268339578.22204.708.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-pci@vger.kernel.org, Alex Chiang <achiang@hp.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Benjamin Herrenschmidt wrote:
> Yes, we need to do a resource allocation pass, setup DMA, etc... and
> that is not done in that manual rescan case I suppose. I have to look.
>
> Part of the problem is that there is no "proper" hooks in the generic
> PCI code that I know of for that, but I'll have to double check the
> code, things might have changed.
>
> For boot time, we do this after we scan busses and before we add the
> devices to sysfs. For hotplug, our hotplug drivers do something similar.
> But that "rescan" sysfs hook seems to go directly into drivers/pci
> causing a rescan but without a change to re-allocate resources etc...
>
> You may be better off implementing a minimum hotplug driver I suppose...
>
> Cheers,
> Ben.
>
>   
I'm fine with creating a minimal hotplug driver. The device I'm dealing with
partially implements Compact PCI hotplug. It generates ENUM# interrupt, but
Hotswap Control register layout does not completely follow the standard.

Should I use drivers/pci/hotplug/cpci_hotplug_core.c as a base, or do 
you have
something more simple in mind ?

Thanks a lot.

Felix.
