Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A432DDF8A
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 04:05:05 +1000 (EST)
Message-Id: <547963B5-28FB-4075-B39A-C99B28554E3F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <33403DE1-6AC2-49E9-9539-C520E4944D77@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: why does ppc64 require boards to call pci_devs_phb_init()?
Date: Thu, 30 Apr 2009 13:04:58 -0500
References: <33403DE1-6AC2-49E9-9539-C520E4944D77@kernel.crashing.org>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2009, at 10:37 AM, Kumar Gala wrote:

> looking at merging this in w/ppc32 and wondering why board code has  
> to call pci_devs_phb_init() and not do it via pcibios_init()
>
> - k

As I look at this a bit more, I'm thinking why don't we do:

pci_devs_phb_init_dynamic() in pcibios_alloc_controller

An add some code into pci_devs_phb_init_dynamic so we don't re-do  
update_dn_pci_info if dn->data is already set.

I am not sure what impact this has ppc64 systems that call  
pci_devs_phb_init()

- k
