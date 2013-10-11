Return-Path: <computersforpeace@gmail.com>
Received: from mail-oa0-x22d.google.com (mail-oa0-x22d.google.com
 [IPv6:2607:f8b0:4003:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B9302C0342
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 04:37:07 +1100 (EST)
Received: by mail-oa0-f45.google.com with SMTP id o17so2657378oag.32
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 10:37:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1381512777-13966-1-git-send-email-computersforpeace@gmail.com>
References: <1381512777-13966-1-git-send-email-computersforpeace@gmail.com>
Date: Fri, 11 Oct 2013 10:37:04 -0700
Message-ID: <CAN8TOE-TQxL1DS38HQ0OwXzOhfrSK3GF1CNt4jybaR-HOUQppA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc512x: remove unnecessary #if
From: Brian Norris <computersforpeace@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gerhard Sittig <gsi@denx.de>, Brian Norris <computersforpeace@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm sorry, ignore this version. I left out a diff I meant to include.

On Fri, Oct 11, 2013 at 10:32 AM, Brian Norris
<computersforpeace@gmail.com> wrote:
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
> Based off of Gerhard Sittig's patch:
>   powerpc/mpc512x: silence build warning upon disabled DIU
>
> Compile-tested with CONFIG_FB_FSL_DIU=n

...

> @@ -42,6 +40,7 @@ struct platform_diu_data_ops {
>         void (*release_bootmem)(void);
>  };
>
> +#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
>  extern struct platform_diu_data_ops diu_ops;
>  #endif

The above hunk is incorrect. I will send v2.

Brian
