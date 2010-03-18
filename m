Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 7E19FB7D0C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 01:12:02 +1100 (EST)
Received: by gyf1 with SMTP id 1so1067237gyf.15
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Mar 2010 07:12:01 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B980909.7050501@suse.com>
References: <4B980909.7050501@suse.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 08:11:41 -0600
Message-ID: <fa686aa41003180711v7ef387a9t1fed1c1de1352dd3@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Build fix for mpc52xx
To: Jeff Mahoney <jeffm@suse.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 10, 2010 at 3:03 PM, Jeff Mahoney <jeffm@suse.com> wrote:
> mpc52xx_gpt_wdt_setup is defined as 0, which causes the following build
> failure with gcc 4.5, since it's built with -Werror.
>
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c:761:3: error: statement with no=
 effect
>
> Defining it as do { } while(0) fixes the problem.

Hi Jeff, thanks for the patch.  I've picked it up with a change.
Instead of a #define, I've changed it to an empty static inline.
As akpm likes to say, we should try to program in C, not pre-processor.  :-=
)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
b/arch/powerpc/platforms/52x
index 072b948..5d7cc88 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -711,7 +711,11 @@ static int __devinit mpc52xx_gpt_wdt_init(void)
        return 0;
 }

-#define mpc52xx_gpt_wdt_setup(x, y)            (0)
+static inline int mpc52xx_gpt_wdt_setup(struct mpc52xx_gpt_priv *gpt,
+                                       const u32 *period)
+{
+       return 0;
+}

 #endif /*  CONFIG_MPC5200_WDT  */

>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c | =A0 =A02 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> @@ -711,7 +711,7 @@ static int __devinit mpc52xx_gpt_wdt_ini
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -#define mpc52xx_gpt_wdt_setup(x, y) =A0 =A0 =A0 =A0 =A0 =A0(0)
> +#define mpc52xx_gpt_wdt_setup(x, y) =A0 =A0 =A0 =A0 =A0 =A0do { } while(=
0)
>
> =A0#endif /* =A0CONFIG_MPC5200_WDT =A0*/
>
> --
> Jeff Mahoney
> SUSE Labs
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
