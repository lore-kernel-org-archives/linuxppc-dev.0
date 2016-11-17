Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKY00q9tzDvsF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:04:04 +1100 (AEDT)
In-Reply-To: <1479106005-18460-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries: Move CMO code from plapr_wrappers.h to
 platforms/pseries
Message-Id: <3tKKXz6LWLz9t1T@ozlabs.org>
Date: Thu, 17 Nov 2016 23:04:03 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-14-11 at 06:46:45 UTC, Michael Ellerman wrote:
> Currently there's some CMO (Cooperative Memory Overcommit) code, in
> plpar_wrappers.h. Some of it is #ifdef CONFIG_PSERIES and some of it
> isn't. The end result being if a file includes plpar_wrappers.h it won't
> build with CONFIG_PSERIES=n.
> 
> Fix it by moving the CMO code into platforms/pseries. The two hcall
> wrappers can just be moved into their only caller, cmm.c, and the
> accessors can go in pseries.h.
> 
> Note we need the accessors because cmm.c can be built as a module, so
> there needs to be a split between the built-in code vs the module, and
> that's achieved by using those accessors.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/8f272a5dd6826f14e47110eccd37b6

cheers
