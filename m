Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbzzH6118zDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 15:44:59 +1000 (AEST)
Message-ID: <1503380692.7369.0.camel@russell.cc>
Subject: Re: qustion about eeh_add_virt_device
From: Russell Currey <ruscur@russell.cc>
To: Julia Lawall <julia.lawall@lip6.fr>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: hch@infradead.org
Date: Tue, 22 Aug 2017 15:44:52 +1000
In-Reply-To: <alpine.DEB.2.20.1708131648480.13565@hadrien>
References: <alpine.DEB.2.20.1708131648480.13565@hadrien>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-08-13 at 16:54 +0200, Julia Lawall wrote:
> Hello,

Hello, sorry for the delayed response.

> 
> At the suggestion of Christoph Hellwig, I am working on inlining the
> functions stored in the err_handler field of a pci_driver structure into
> the pci_driver structure itself.  A number of functions in the file
> arch/powerpc/kernel/eeh_driver.c have code like:
> 
>         if (!driver->err_handler ||
>             !driver->err_handler->error_detected) {
>                 eeh_pcid_put(dev);
>                 return NULL;
>         }
> 
> This I would just convert to:
> 
>         if (!driver->error_detected) {
>                 eeh_pcid_put(dev);
>                 return NULL;
>         }
> 
> But I am not sure what is best to do about eeh_add_virt_device, which
> contains:
> 
>                 if (driver->err_handler)
> 		        return NULL;
> 
> Should I try to find a subfield of the err_handler that is guaranteed to
> be there if anything is there?  Or could the test just be dropped, leaving
> a direct return NULL?

I believe the test can be dropped.

- Russell

> 
> thanks,
> julia
