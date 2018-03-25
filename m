Return-Path: <ruscur@russell.cc>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408YRC1lV4zF1y4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 10:30:13 +1100 (AEDT)
Message-ID: <1522020603.2398.0.camel@russell.cc>
Subject: Re: [PATCH] powerpc/eeh: Fix race with driver un/bind
From: Russell Currey <ruscur@russell.cc>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, sam.bobroff@au1.ibm.com
Date: Mon, 26 Mar 2018 10:30:03 +1100
In-Reply-To: <1521786791.16434.339.camel@kernel.crashing.org>
References: <20180323054417.3268-1-mikey@neuling.org>
 <1521786791.16434.339.camel@kernel.crashing.org>
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

On Fri, 2018-03-23 at 17:33 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2018-03-23 at 16:44 +1100, Michael Neuling wrote:
> 
>  .../...
> 
> > This fixes the problem in the same way the generic PCIe AER code
> > (in
> > drivers/pci/pcie/aer/aerdrv_core.c) does. It makes the EEH code
> > hold
> > the device_lock() before performing the driver EEH callbacks. This
> > ensures either the callbacks are no longer register, or if they are
> > registered the driver will not be removed from underneath us.
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> Generally ok, minor nits though and do we want a CC stable ?

I definitely think this should go to stable.
