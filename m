Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F783DDFE6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:17:31 +1100 (EST)
Date: Wed, 10 Dec 2008 16:17:13 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Introduce ppc_pci_flags accessors
In-Reply-To: <20081210185446.13e33cb2@zod.rchland.ibm.com>
Message-ID: <Pine.LNX.4.64.0812101613140.28806@t2.domain.actdsltmp>
References: <20081210191148.GA1769@yoda.jdub.homelinux.org>
	<1228952788.7999.0.camel@localhost>
	<20081210185446.13e33cb2@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Dec 2008, Josh Boyer wrote:
> On Thu, 11 Dec 2008 10:46:28 +1100
>>> +#ifdef CONFIG_PCI
>>> +extern unsigned int ppc_pci_flags;
>>> +#define ppc_pci_set_flags(flags) ppc_pci_flags = (flags)
>>> +#define ppc_pci_add_flags(flags) ppc_pci_flags |= (flags)
>>> +#define ppc_pci_flag_is_set(flag) (ppc_pci_flags & (flag))
>>> +#else
>>> +#define ppc_pci_set_flags(flags) do {} while (0)
>>> +#define ppc_pci_add_flags(flags) do {} while (0)
>>> +#define ppc_pci_flag_is_set(flag) (0)
>>> +#endif
>>
>> I hate to be picky, but I don't see any reason why these shouldn't be
>> static inlines.
>
> There's a perfectly good reason.  I AM LAZY.
>
> That aside, it doesn't matter to me either way.  If the general idea
> seems fine and the naming of the functions is acceptable, I'd be happy
> to respin.

If were allowed to be picky, I think ppc_pci_has_flag() is a better name
than ppc_pci_flag_is_set().  Matches the other function names better, and a
quick grep of the kernel source shows bar_has_foo() is much more common
than bar_foo_is_set().
