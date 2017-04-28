Return-Path: <srs0=lvwd=4e=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDhwC0l1LzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 15:20:11 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wDhwC0Fv2z8vsT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 15:20:11 +1000 (AEST)
Message-ID: <1493356805.25766.296.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/xive: Fix/improve verbose debug output
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Fri, 28 Apr 2017 07:20:05 +0200
In-Reply-To: <87zif1p6vw.fsf@concordia.ellerman.id.au>
References: <1493301446.25766.276.camel@kernel.crashing.org>
 <87zif1p6vw.fsf@concordia.ellerman.id.au>
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

On Fri, 2017-04-28 at 13:07 +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > The existing verbose debug code doesn't build when enabled.
> 
> So why don't we convert all the DBG_VERBOSE() to pr_devel()? 

pr_devel provides a bunch of debug at init/setup/mask/unmask etc... but
the system is still usable

DBG_VERBOSE starts spewing stuff on every interrupt and eoi, the system
is no longer usable.

> If there's non-verbose debug that we think would be useful to
> differentiate from verbose then those could be pr_debug() - which means
> they'll be jump labelled off in most production kernels, but still able
> to be enabled.

Maybe... I don't like the giant "debug" switch accross the whole
kernel, though.

Ben.
