Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVhbk1QY1zDrD0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 00:54:41 +1000 (AEST)
Date: Sun, 13 Aug 2017 16:54:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: ruscur@russell.cc, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
cc: hch@infradead.org
Subject: qustion about eeh_add_virt_device
Message-ID: <alpine.DEB.2.20.1708131648480.13565@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

At the suggestion of Christoph Hellwig, I am working on inlining the
functions stored in the err_handler field of a pci_driver structure into
the pci_driver structure itself.  A number of functions in the file
arch/powerpc/kernel/eeh_driver.c have code like:

        if (!driver->err_handler ||
            !driver->err_handler->error_detected) {
                eeh_pcid_put(dev);
                return NULL;
        }

This I would just convert to:

        if (!driver->error_detected) {
                eeh_pcid_put(dev);
                return NULL;
        }

But I am not sure what is best to do about eeh_add_virt_device, which
contains:

                if (driver->err_handler)
		        return NULL;

Should I try to find a subfield of the err_handler that is guaranteed to
be there if anything is there?  Or could the test just be dropped, leaving
a direct return NULL?

thanks,
julia
