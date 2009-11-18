Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54568B6EE9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 16:41:52 +1100 (EST)
Subject: Re: [PATCH]  [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pbathija@amcc.com
In-Reply-To: <1258503401-7779-1-git-send-email-pbathija@amcc.com>
References: <1258503401-7779-1-git-send-email-pbathija@amcc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Nov 2009 16:41:29 +1100
Message-ID: <1258522889.2140.659.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Eric.Moore@lsi.com, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-17 at 16:16 -0800, pbathija@amcc.com wrote:
> From: Pravin Bathija <pbathija@amcc.com>
> 
>   Powerpc 44x uses 36 bit real address while the real address defined
>   in MPT Fusion driver is of type 32 bit. This causes ioremap to fail and driver
>   fails to initialize. This fix changes the data types representing the real
>   address from unsigned long 32-bit types to "phys_addr_t" which is 64-bit. The
>   driver has been tested, the disks get discovered correctly and can do IO. Removed
>   ioremap and used hose->io_base_virt for IO space to make it platform independent.
> Content-Type: text/plain; charset=utf-8

Except that this is all wrong :-) You basically made it powerpc specific
since none of that pci controller stuff is generic. I don't understand
what you are trying to do though. The -only- change you need to do is
to change the longs into resource_size_t.

IO Port numbers are "special" and handled as such already (and besides
are never bigger than 32-bit neither, at least on x86 and powerpc).

Just leave the PIO code alone, hopefully, if the driver isn't full of
crack, the code should be fine already. If the driver does something
wrong then you can attempt to fix it separately.

The only problem that you need to address afaik, is purely that
pci_resource_start() can return a resource_size_t which can be 64-bit,
and as such it is broken for the driver to manipulate and store that
value as an unsigned long or a u32.

Cheers,
Ben.
