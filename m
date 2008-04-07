Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D095DDFEF
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 23:10:01 +1000 (EST)
Message-Id: <279F1861-9605-46FD-A917-DF5B95B8C4F6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18425.24938.332852.315571@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
Date: Mon, 7 Apr 2008 08:09:57 -0500
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
	<18425.24938.332852.315571@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 6, 2008, at 6:48 PM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> Wanted to get any feedback on this initial port of the fixmap  
>> support over
>> from x86.  There are a few TODOs:
>
> I have no objection in principle, but your patch below imports a few
> things that aren't (and won't be) needed on powerpc AFAICS -- for
> example, we don't need FIX_VDSO, since our VDSO is mapped into user
> space at the 1MB point (by default).

Agreed.

> You have FIX_PCIE_MCFG in there too (keyed off CONFIG_PCI_MMCONFIG
> which we don't have and don't want to have).  If you need to map in
> PCIe config space, what's wrong with just using ioremap?  Why do you
> need to have a fixed virtual address for it?

Ben has commented on this.  I know on the 83xx systems we have two  
PCIe PHBs that would require ioremapping 512M of virtual address space  
which we don't have if the system has any large amount of memory.

> More generally, I think we need to take an overall look at what things
> we are using fixed virtual addresses for, and why they need to be
> fixed.  If there are indeed several such things then we can introduce
> the fixmap stuff.

The list as I see it:
* kmap
* pci-e config for 4xx/83xx
* kexec/kdump (ben commented on this when Dale posted his patches for  
ppc32 support)

future:
* possible usage by HV

since we already have three users and a possible fourth it seems like  
a useful change.

- k
