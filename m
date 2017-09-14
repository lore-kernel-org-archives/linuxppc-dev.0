Return-Path: <srs0=k8tc=ap=russell.cc=ruscur@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt0z06Th6zDql1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 11:18:20 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xt0z05gmzz8t79
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 11:18:20 +1000 (AEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xt0z02m4mz9ryv
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2017 11:18:20 +1000 (AEST)
Message-ID: <1505351529.3761.1.camel@russell.cc>
Subject: Re: [PATCH 2/2] powerpc/powernv: Rework EEH initialization on powernv
From: Russell Currey <ruscur@russell.cc>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Date: Thu, 14 Sep 2017 11:12:09 +1000
In-Reply-To: <1504766144.12628.15.camel@kernel.crashing.org>
References: <1504766144.12628.15.camel@kernel.crashing.org>
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

On Thu, 2017-09-07 at 16:35 +1000, Benjamin Herrenschmidt wrote:
> Remove the post_init callback which is only used
> by powernv, we can just call it explicitly from
> the powernv code.
> 
> This partially kills the ability to "disable" eeh at
> runtime via debugfs as this was calling that same
> callback again, but this is both unused and broken
> in several ways. If we want to revive it, we need
> to create a dedicated enable/disable callback on the
> backend that does the right thing.
> 
> Let the bulk of eeh initialize normally at
> core_initcall() like it does on pseries by removing
> the hack in eeh_init() that delays it.
> 
> Instead we make sure our eeh->probe cleanly bails
> out of the PEs haven't been created yet and we force
> a re-probe where we used to call eeh_init() again.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Russell Currey <ruscur@russell.cc>
