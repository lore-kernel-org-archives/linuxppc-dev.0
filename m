Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6A5F92C03B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 09:12:15 +1100 (EST)
Date: Wed, 30 Oct 2013 23:12:10 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2] powerpc/mpc512x: remove unnecessary #if
Message-ID: <20131030231210.32778fbe@crub>
In-Reply-To: <1381513058-14164-1-git-send-email-computersforpeace@gmail.com>
References: <1381512777-13966-1-git-send-email-computersforpeace@gmail.com>
 <1381513058-14164-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 11 Oct 2013 10:37:38 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> Several functions are only ever referenced locally, so make them static.
> Of those functions, many of them are protected by an #if. However, the
> code which can compile fine in either case.
> 
> Now that (1) the unneeded code is marked 'static' and (2) the code is
> only used under a C 'if (IS_ENABLED(CONFIG_FB_FSL_DIU))', the compiler
> can automatically remove the unneeded code, and we don't need the #if or
> the empty stub functions.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---
> v2: left out a diff I was holding locally (to remove an #if/#endif
>     completely). Sorry for the noise.
> 
> Based off of Gerhard Sittig's patch:
>   powerpc/mpc512x: silence build warning upon disabled DIU
> 
> Compile-tested with CONFIG_FB_FSL_DIU=n
> 
>  arch/powerpc/platforms/512x/mpc512x_shared.c | 21 +++++++--------------
>  arch/powerpc/sysdev/fsl_soc.h                |  3 ---
>  2 files changed, 7 insertions(+), 17 deletions(-)

Applied, thanks!

Anatolij
