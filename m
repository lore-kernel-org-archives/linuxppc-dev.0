Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0F16967B64
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 04:42:01 +1000 (EST)
Date: Wed, 27 Sep 2006 13:40:37 -0500
From: Olof Johansson <olof@lixom.net>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: iommu hypervisor hypothetical
Message-ID: <20060927134037.0384a8da@localhost.localdomain>
In-Reply-To: <1159381557.19103.17.camel@sinatra.austin.ibm.com>
References: <1159375671.19103.3.camel@sinatra.austin.ibm.com>
	<20060927120723.678eee22@localhost.localdomain>
	<1159381557.19103.17.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: External, Santiago Leon <saleon@us.ibm.com>, List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 27 Sep 2006 13:25:57 -0500 John Rose <johnrose@austin.ibm.com> wrote:

> > So just change the prototype of tce_build
> > to return success/failure, and handle it accordingly in iommu_alloc
> > (DMA_ERROR_CODE). The error should move on up the stack from there.
> 
> I'm thinking of functions like dma_map_single(), which returns the
> unsigned type dma_addr_t.  Suppose H_HCE_PUT fails, and this gets
> propagated up to the device driver through DMA_ERROR_CODE.  The PAPR
> currently defines 2 ways in which this could fail, and we're considering
> at least one more.  One error code doesn't seem sufficient.

So you need to know in the driver why it failed, to take separate
actions based on why? Driver/device events aren't communicated in any
other manner?

> > Or did I misunderstand your question in the first place? It's sort of
> > sparse on details. :-)
> 
> You know how it goes :)  I guess my question is whether passing specific
> failure conditions up the call chain is permissible/feasible, and
> whether the prototypes for the various device driver DMA utilities are
> set in stone.

You could expand to other DMA_ERROR_.* codes, as long as you modify
dma_mapping_error accordingly.


-Olof
