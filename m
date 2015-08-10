Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 664E11A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 16:38:10 +1000 (AEST)
In-Reply-To: <1439081497-14986-4-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 <linux-kernel@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [3/5] drivers/tty: make hvc_console.c explicitly non-modular
Message-Id: <20150810063810.477E614027C@ozlabs.org>
Date: Mon, 10 Aug 2015 16:38:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-09-08 at 00:51:35 UTC, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/tty/hvc/Kconfig:config HVC_DRIVER
> drivers/tty/hvc/Kconfig:        bool
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only, even
> though someone bothered to comment that the code was not used.
> 
> Unlike other changes, this driver binds in w/o using module_init,
> so we dont have init ordering concerns with this commit.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Seems sane to me, possibly back in the deep dark past it could be a module, but
no point keeping the code around if it can't anymore.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
