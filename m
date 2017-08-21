Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbgnx1YLWzDqfx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 03:35:48 +1000 (AEST)
Message-ID: <1503336930.2195.20.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Date: Mon, 21 Aug 2017 10:35:30 -0700
In-Reply-To: <ad84e763-a30f-04f7-f1d0-ccd72c0d4dd4@linux.vnet.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <ad84e763-a30f-04f7-f1d0-ccd72c0d4dd4@linux.vnet.ibm.com>
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

On Mon, 2017-08-21 at 19:27 +0200, Frederic Barrat wrote:
> Hi Ben,
> 
> Le 24/07/2017 à 06:28, Benjamin Herrenschmidt a écrit :
> > Instead of comparing the whole CPU mask every time, let's
> > keep a counter of how many bits are set in the mask. Thus
> > testing for a local mm only requires testing if that counter
> > is 1 and the current CPU bit is set in the mask.
> 
> 
> I'm trying to see if we could merge this patch with what I'm trying to 
> do to mark a context as requiring global TLBIs.
> In http://patchwork.ozlabs.org/patch/796775/
> I'm introducing a 'flags' per memory context, using one bit to say if 
> the context needs global TLBIs.
> The 2 could co-exist, just checking... Do you think about using the 
> actual active_cpus count down the road, or is it just a matter of 
> knowing if there are more than one active cpus?

Or you could just incrementer my counter. Just make sure you increment
it at most once per CXL context and decrement when the context is gone.

Cheers,
Ben.
