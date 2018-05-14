Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kyD63FDxzF3Vk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 20:51:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stewart@linux.vnet.ibm.com <stewart@linux.vnet.ibm.com>,
 Philippe Bergheaud <felix@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.ibm.com, clombard@linux.ibm.com,
 Philippe Bergheaud <felix@linux.ibm.com>, benh@au1.ibm.com
Subject: Re: [PATCH v4 1/2] cxl: Set the PBCQ Tunnel BAR register when
 enabling capi mode
In-Reply-To: <20180514082736.3699-1-felix@linux.ibm.com>
References: <20180514082736.3699-1-felix@linux.ibm.com>
Date: Mon, 14 May 2018 20:51:01 +1000
Message-ID: <87sh6upl2i.fsf@concordia.ellerman.id.au>
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

Philippe Bergheaud <felix@linux.ibm.com> writes:

> Skiboot used to set the default Tunnel BAR register value when capi mode
> was enabled. This approach was ok for the cxl driver, but prevented other
> drivers from choosing different values.
>
> Skiboot versions > 5.11 will not set the default value any longer. This
> patch modifies the cxl driver to set/reset the Tunnel BAR register when
> entering/exiting the cxl mode, with pnv_pci_set_tunnel_bar().
>
> That should work with old skiboot (since we are re-writing the value
> already set) and new skiboot.

But doesn't that mean new skiboot can't boot any old kernel? That seems
undesirable.

cheers
