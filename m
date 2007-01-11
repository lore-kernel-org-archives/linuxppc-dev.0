Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B5EFDE0DA
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:45:28 +1100 (EST)
Date: Thu, 11 Jan 2007 11:44:27 -0800
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/7] Powerpc MSI implementation
Message-ID: <20070111194427.GA20450@kroah.com>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.0CC1BDDF13@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070111112503.0CC1BDDF13@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2007 at 10:25:19PM +1100, Michael Ellerman wrote:
> Powerpc MSI implementation, based on a collection of "ops" callbacks.
> We have to take the ops approach to accomodate RTAS, where firmware
> handles almost all details of MSI setup/teardown. Bare-metal MSI
> can be accomodated also.
> 
> See the comments in include/asm-powerpc/msi.h for more info.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
>  arch/powerpc/kernel/msi.c     |  320 ++++++++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/machdep.h |    6 
>  include/asm-powerpc/msi.h     |  173 ++++++++++++++++++++++
>  include/linux/pci.h           |    7 
>  4 files changed, 506 insertions(+)
> 
> Index: msi/arch/powerpc/kernel/msi.c

Why isn't all of this in the drivers/pci/msi.c file instead?  You are
creating a new API here that is only availble to the PPC platform, which
is not acceptable.

Please work with the current MSI core code to work properly for PPC,
instead of reinventing the whole thing.

> +#if defined(CONFIG_PCI_MSI) && defined(CONFIG_PPC_MERGE)
> +struct msi_info;
> +#endif

CONFIG_PPC_MERGE?  What is that option for?

So, no, I don't agree with this implementation and don't want to see it
go through anyone's tree into mainline just yet.

thanks,

greg k-h
