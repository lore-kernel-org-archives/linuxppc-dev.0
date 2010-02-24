Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f175.google.com (mail-yx0-f175.google.com
	[209.85.210.175]) by ozlabs.org (Postfix) with ESMTP id 2C8E2B6ED0
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 00:40:59 +1100 (EST)
Received: by yxe5 with SMTP id 5so1379447yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 05:40:57 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100224085137.GA25801@suse.de>
References: <20100224085137.GA25801@suse.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 24 Feb 2010 06:40:37 -0700
Message-ID: <fa686aa41002240540s2044ecaaj3ce04021719a51ef@mail.gmail.com>
Subject: Re: [PATCH] Fixed statement without effect by using a correct empty
	instruction
To: Marcus Meissner <meissner@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, albrecht.dress@arcor.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 24, 2010 at 1:51 AM, Marcus Meissner <meissner@suse.de> wrote:
> This fixes this build failure:
> cc1: warnings being treated as errors
> /usr/src/packages/BUILD/kernel-default-2.6.33/linux-2.6.32/arch/powerpc/p=
latforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_gpt_probe':
> /usr/src/packages/BUILD/kernel-default-2.6.33/linux-2.6.32/arch/powerpc/p=
latforms/52xx/mpc52xx_gpt.c:761:3: error: statement with no effect
>
> Signed-off-by: Marcus Meissner <meissner@suse.de>

Hi Marcus, thanks for the patch.  One comment below...

> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_gpt.c
> index 6f8ebe1..88231d8 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> @@ -711,7 +711,7 @@ static int __devinit mpc52xx_gpt_wdt_init(void)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -#define mpc52xx_gpt_wdt_setup(x, y) =A0 =A0 =A0 =A0 =A0 =A0(0)
> +#define mpc52xx_gpt_wdt_setup(x, y) =A0 =A0 =A0 =A0 =A0 =A0do { } while =
(0)

As Andrew likes to say, we should be programming in C instead of preprocess=
or.

-#define mpc52xx_gpt_wdt_setup(x, y)            (0)
+static inline void mpc52xx_gpt_wdt_setup(struct mpc52xx_gpt_priv
*gpt, const u32 *period) { }
