Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3F181A0225
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 20:28:56 +1100 (AEDT)
Message-ID: <1447147735.1314.1.camel@ellerman.id.au>
Subject: Re: [PATCH] of: Print rather than WARN'ing when overlap check fails
From: Michael Ellerman <mpe@ellerman.id.au>
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, mitchelh@codeaurora.org, frowand.list@gmail.com,
 grant.likely@linaro.org
Date: Tue, 10 Nov 2015 20:28:55 +1100
In-Reply-To: <1447132113-31434-1-git-send-email-mpe@ellerman.id.au>
References: <1447132113-31434-1-git-send-email-mpe@ellerman.id.au>
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

On Tue, 2015-11-10 at 16:08 +1100, Michael Ellerman wrote:

> __rmem_check_for_overlap() is called very early in boot, and on some
> powerpc systems it's not safe to call WARN that early in boot.
> 
> If the overlap check fails the system will oops instead of printing a
> warning. Furthermore because it's so early in boot the console is not up
> and the user doesn't see the oops, they just get a dead system.
> 
> Fix it by printing an error instead of calling WARN.
> 
> Fixes: ae1add247bf8 ("of: Check for overlap in reserved memory regions")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/of/of_reserved_mem.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

I forgot to say, I assume you're OK to merge this and get it to Linus soonish?
Otherwise I can stuff it in a fix branch and ask Linus to pull that. Let me
know which you'd prefer.

cheers
