Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 268FF67B52
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 03:08:08 +1000 (EST)
Date: Wed, 27 Sep 2006 12:07:23 -0500
From: Olof Johansson <olof@lixom.net>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: iommu hypervisor hypothetical
Message-ID: <20060927120723.678eee22@localhost.localdomain>
In-Reply-To: <1159375671.19103.3.camel@sinatra.austin.ibm.com>
References: <1159375671.19103.3.camel@sinatra.austin.ibm.com>
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

On Wed, 27 Sep 2006 11:47:51 -0500 John Rose <johnrose@austin.ibm.com> wrote:

> Suppose the hypervisor added new failure codes for the hcall that does
> tce_build().  Suppose that the device driver needed to expect such
> failures when alloc_[coherent,consistent] is not successful, and handle
> that case accordingly.
> 
> Is this something we can accommodate without rewriting the iommu stuff
> for various platforms?  All these functions in machdep.h are defined to
> return NULL.  Is this because we haven't had a reasonable expectation of
> failure, or because device drivers _have_ to assume success for such
> operations?

iommu_alloc can already fail. So just change the prototype of tce_build
to return success/failure, and handle it accordingly in iommu_alloc
(DMA_ERROR_CODE). The error should move on up the stack from there.

Or did I misunderstand your question in the first place? It's sort of
sparse on details. :-)


-Olof
