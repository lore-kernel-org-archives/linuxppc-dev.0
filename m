Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20D4D1A0103
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 18:38:12 +1000 (AEST)
In-Reply-To: <1439940438-3585-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, imunsie@au1.ibm.com,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, dja@axtens.net
Subject: Re: [V2] cxl: Allow release of contexts which have been OPENED but
 not STARTED
Message-Id: <20150820083812.01673140293@ozlabs.org>
Date: Thu, 20 Aug 2015 18:38:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-18-08 at 23:27:18 UTC, Andrew Donnellan wrote:
> If we open a context but do not start it (either because we do not attempt
> to start it, or because it fails to start for some reason), we are left
> with a context in state OPENED. Previously, cxl_release_context() only
> allowed releasing contexts in state CLOSED, so attempting to release an
> OPENED context would fail.
> 
> In particular, this bug causes available contexts to run out after some EEH
> failures, where drivers attempt to release contexts that have failed to
> start.
> 
> Allow releasing contexts in any state with a value lower than STARTED, i.e.
> OPENED or CLOSED (we can't release a STARTED context as it's currently
> using the hardware, and we assume that contexts in any new states which may
> be added in future with a value higher than STARTED are also unsafe to
> release).
> 
> Cc: stable@vger.kernel.org
> Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7c26b9cf5347c2427215

cheers
