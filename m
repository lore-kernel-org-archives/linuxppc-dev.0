Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltvh70MPzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:20 +1000 (AEST)
In-Reply-To: <1523344570.11062.65.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv/opal: Use standard interrupts property when
 available
Message-Id: <41ltvg6lGDz9s3Z@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-10 at 07:16:10 UTC, Benjamin Herrenschmidt wrote:
> For (bad) historical reasons, OPAL used to create a non-standard pair of
> properties "opal-interrupts" and "opal-interrupts-names" for representing
> the list of interrupts it wants Linux to request on its behalf.
> 
> Among other issues, the opal-interrupts doesn't have a way to carry the
> type of interrupts, and they were assumed to be all level sensitive.
> 
> This is wrong on some recent systems where some of them are edge sensitive
> causing warnings in the XIVE code and possible misbehaviours if they need
> to be retriggered (typically the NPU2 TCE error interrupts).
> 
> This makes Linux switch to using the standard "interrupts" and
> "interrupt-names" properties instead when they are available, using standard
> of_irq helpers, which can carry all the desired type information.
> 
> Newer versions of OPAL will generate those properties in addition to the
> legacy ones.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/77b5f703dcc859915f0f20d92bc538

cheers
