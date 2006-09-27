Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED1C867B61
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 09:12:05 +1000 (EST)
Subject: Re: iommu hypervisor hypothetical
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Rose <johnrose@austin.ibm.com>
In-Reply-To: <1159381557.19103.17.camel@sinatra.austin.ibm.com>
References: <1159375671.19103.3.camel@sinatra.austin.ibm.com>
	<20060927120723.678eee22@localhost.localdomain>
	<1159381557.19103.17.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 09:11:42 +1000
Message-Id: <1159398703.18293.104.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, External List <linuxppc-dev@ozlabs.org>,
	Santiago Leon <saleon@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-09-27 at 13:25 -0500, John Rose wrote:
> > So just change the prototype of tce_build
> > to return success/failure, and handle it accordingly in iommu_alloc
> > (DMA_ERROR_CODE). The error should move on up the stack from there.
> 
> I'm thinking of functions like dma_map_single(), which returns the
> unsigned type dma_addr_t.  Suppose H_HCE_PUT fails, and this gets
> propagated up to the device driver through DMA_ERROR_CODE.  The PAPR
> currently defines 2 ways in which this could fail, and we're considering
> at least one more.  One error code doesn't seem sufficient.

That's a design issue with the linux API that has been around for some
time. At first, there was no possible error return from dma_map_single()
in fact :( DMA_ERROR_CODE was added, and I see no way to do something
better from that function...

> > Or did I misunderstand your question in the first place? It's sort of
> > sparse on details. :-)
> 
> You know how it goes :)  I guess my question is whether passing specific
> failure conditions up the call chain is permissible/feasible, and
> whether the prototypes for the various device driver DMA utilities are
> set in stone.
> 
> Thanks-
> John
