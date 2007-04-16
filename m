Return-Path: <glikely@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by ozlabs.org (Postfix) with ESMTP id 5C5BEDDE37
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 14:45:07 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so1375750wxd
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Apr 2007 21:45:05 -0700 (PDT)
Message-ID: <528646bc0704152145h44ff5f38wb6c4a1887261f6ed@mail.gmail.com>
Date: Sun, 15 Apr 2007 22:45:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>, "Stefan Roese" <sr@denx.de>
Subject: Re: [PATCH] icecube/lite5200b: wakeup from low-power support
In-Reply-To: <20070403084649.GA9163@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104411.GF22215@moe.telargo.com>
	<528646bc0703260908q7b018060v40db7e66aa81eaee@mail.gmail.com>
	<20070403084649.GA9163@nd47.coderock.org>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/3/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> U-Boot part of Lite5200b low power mode support.
> Puts SDRAM out of self-refresh and transfers control to
> address saved at physical 0x0.

Looks good; almost there.  Only one thing missing... you need to add
your "Signed-off-by" line.  :-)  See Documentation/SubmittingPatches
in the Linux source tree.  (You can just reply to this message, and
whoever merges the patch will add the line to the commit message)

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Stefan; since there is no 5200 custodian, can you please pick up this
patch once Domen sends a Signed-of-by replay?

Cheers,
g.

>
>
> ---
> On 26/03/07 10:08 -0600, Grant Likely wrote:
> > On 3/15/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > >U-Boot part of Lite5200b low power mode support.
> > >Puts SDRAM out of self-refresh and transfers control to
> > >address saved at physical 0x0.
> >
> > This looks pretty straight forward.
> >
> > My only comment is that psc2_4 is probably used as GPIO instead of
> > power control by some users (The lite5200 is an eval board after all).
> > Maybe wrap the code with #ifdef CONFIG_LITE5200B_PM (instead of
> > CONFIG_LITE5200B) so that it can be easily compiled out.
> >
> > Also, '//' style comments should be changed to '/* */'
> >
> > Otherwise;
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> >
>
> OK. This one should be better:
>
>  Makefile                |    5 ++++
>  board/icecube/icecube.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> Index: u-boot.git/board/icecube/icecube.c
> ===================================================================
> --- u-boot.git.orig/board/icecube/icecube.c
> +++ u-boot.git/board/icecube/icecube.c
> @@ -42,6 +42,53 @@
>  #include "mt48lc16m16a2-75.h"
>  # endif
>  #endif
> +
> +#ifdef CONFIG_LITE5200B_PM
> +/* u-boot part of low-power mode implementation */
> +#define SAVED_ADDR (*(void **)0x00000000)
> +#define PSC2_4 0x02
> +
> +void lite5200b_wakeup(void)
> +{
> +       unsigned char wakeup_pin;
> +       void (*linux_wakeup)(void);
> +
> +       /* check PSC2_4, if it's down "QT" is signaling we have a wakeup
> +        * from low power mode */
> +       *(vu_char *)MPC5XXX_WU_GPIO_ENABLE = PSC2_4;
> +       __asm__ volatile ("sync");
> +
> +       wakeup_pin = *(vu_char *)MPC5XXX_WU_GPIO_DATA_I;
> +       if (wakeup_pin & PSC2_4)
> +               return;
> +
> +       /* acknowledge to "QT"
> +        * by holding pin at 1 for 10 uS */
> +       *(vu_char *)MPC5XXX_WU_GPIO_DIR = PSC2_4;
> +       __asm__ volatile ("sync");
> +       *(vu_char *)MPC5XXX_WU_GPIO_DATA_O = PSC2_4;
> +       __asm__ volatile ("sync");
> +       udelay(10);
> +
> +       /* put ram out of self-refresh */
> +       *(vu_long *)MPC5XXX_SDRAM_CTRL |= 0x80000000;   /* mode_en */
> +       __asm__ volatile ("sync");
> +       *(vu_long *)MPC5XXX_SDRAM_CTRL |= 0x50000000;   /* cke ref_en */
> +       __asm__ volatile ("sync");
> +       *(vu_long *)MPC5XXX_SDRAM_CTRL &= ~0x80000000;  /* !mode_en */
> +       __asm__ volatile ("sync");
> +       udelay(10); /* wait a bit */
> +
> +       /* jump back to linux kernel code */
> +       linux_wakeup = SAVED_ADDR;
> +       printf("\n\nLooks like we just woke, transferring control to 0x%08lx\n",
> +                       linux_wakeup);
> +       linux_wakeup();
> +}
> +#else
> +#define lite5200b_wakeup()
> +#endif
> +
>  #ifndef CFG_RAMBOOT
>  static void sdram_start (int hi_addr)
>  {
> @@ -208,6 +255,8 @@ long int initdram (int board_type)
>                 __asm__ volatile ("sync");
>         }
>
> +       lite5200b_wakeup();
> +
>         return dramsize + dramsize2;
>  }
>
> Index: u-boot.git/Makefile
> ===================================================================
> --- u-boot.git.orig/Makefile
> +++ u-boot.git/Makefile
> @@ -430,6 +430,7 @@ inka4x0_config:     unconfig
>         @$(MKCONFIG) inka4x0 ppc mpc5xxx inka4x0
>
>  lite5200b_config       \
> +lite5200b_PM_config    \
>  lite5200b_LOWBOOT_config:      unconfig
>         @mkdir -p $(obj)include
>         @mkdir -p $(obj)board/icecube
> @@ -438,6 +439,10 @@ lite5200b_LOWBOOT_config:  unconfig
>         @ echo "... DDR memory revision"
>         @ echo "#define CONFIG_MPC5200"         >>$(obj)include/config.h
>         @ echo "#define CONFIG_LITE5200B"       >>$(obj)include/config.h
> +       @[ -z "$(findstring _PM_,$@)" ] || \
> +               { echo "#define CONFIG_LITE5200B_PM"    >>$(obj)include/config.h ; \
> +                 echo "... with power management (low-power mode) support" ; \
> +               }
>         @[ -z "$(findstring LOWBOOT_,$@)" ] || \
>                 { echo "TEXT_BASE = 0xFF000000" >$(obj)board/icecube/config.tmp ; \
>                   echo "... with LOWBOOT configuration" ; \
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
