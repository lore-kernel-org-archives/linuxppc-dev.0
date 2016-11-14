Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzn5JJWzDvjq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:25 +1100 (AEDT)
In-Reply-To: <20161109085504.10799-1-andrew.shadura@collabora.co.uk>
To: Andrew Shadura <andrew.shadura@collabora.co.uk>,
 linuxppc-dev@lists.ozlabs.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Shuah Khan <shuah@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [RESEND] tools-powerpc: Return false instead of -1
Message-Id: <3tHTzn42Z9z9s5w@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-09-11 at 08:55:04 UTC, Andrew Shadura wrote:
> From: Peter Senna Tschudin <peter.senna@gmail.com>
> 
> Returning a negative value for a boolean function seem to have the
> undesired effect of returning true. require_paranoia_below() is a
> boolean function, but the variable used to store the return value is an
> integer, receiving -1 or 0. This patch convert rc to bool, replace -1
> by false, and 0 by true.
> 
> This issue was found by the following Coccinelle semantic patch:
> <smpl>
> @@
> identifier f, ret;
> constant C;
> typedef bool;
> @@
> bool f (...){
> <+...
> ret = -C;
> ...
> * return ret;
> ...+>
> }
> </smpl>
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0e27d27e0d6d92342797e0d37738c2

cheers
