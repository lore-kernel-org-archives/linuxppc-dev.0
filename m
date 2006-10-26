Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id AAC836834B
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 07:11:22 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so436853ugc
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 14:11:20 -0700 (PDT)
Message-ID: <528646bc0610261411y2bd7522co9693b33d8ddab5cd@mail.gmail.com>
Date: Thu, 26 Oct 2006 15:11:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Vitaly Bordug" <vbordug@ru.mvista.com>, linuxppc-dev@ozlabs.org,
	"Kumar Gala" <galak@kernel.crashing.org>,
	"Matthew McClintock" <msm@freescale.com>, jdl@jdl.com
Subject: Re: [PATCH/RFC] Allow CONFIG_OF_FLAT_TREE to boot a non-arch/powerpc
	kernel
In-Reply-To: <11618969241015-git-send-email-grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11618969241015-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BTW, can someone please actually test this w/ a arch/powerpc kernel?
I've only got a lite5200b to play with, and it isn't ported yet.  :)

g.

On 10/26/06, Grant Likely <grant.likely@secretlab.ca> wrote:
> This patch allows an arch/ppc kernel to be booted by just passing 1 or 2
> arguments to bootm.  It removes the getenv("disable_of") test that used
> to be used for this purpose.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  common/cmd_bootm.c |   52 ++++++++++++++++++++--------------------------------
>  1 files changed, 20 insertions(+), 32 deletions(-)
>
> diff --git a/common/cmd_bootm.c b/common/cmd_bootm.c
> index 3091a58..07a9f12 100644
> --- a/common/cmd_bootm.c
> +++ b/common/cmd_bootm.c
> @@ -833,10 +833,6 @@ #endif
>                         printf ("ERROR: flat device tree size does not agree with image\n");
>                         return;
>                 }
> -
> -       } else if (getenv("disable_of") == NULL) {
> -               printf ("ERROR: bootm needs flat device tree as third argument\n");
> -               return;
>         }
>  #endif
>         if (!data) {
> @@ -913,23 +909,11 @@ #endif    /* CONFIG_HW_WATCHDOG || CONFIG_W
>
>         SHOW_BOOT_PROGRESS (15);
>
> -#ifndef CONFIG_OF_FLAT_TREE
> -
>  #if defined(CFG_INIT_RAM_LOCK) && !defined(CONFIG_E500)
>         unlock_ram_in_cache();
>  #endif
>
> -       /*
> -        * Linux Kernel Parameters:
> -        *   r3: ptr to board info data
> -        *   r4: initrd_start or 0 if no initrd
> -        *   r5: initrd_end - unused if r4 is 0
> -        *   r6: Start of command line string
> -        *   r7: End   of command line string
> -        */
> -       (*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);
> -
> -#else  /* CONFIG_OF_FLAT_TREE */
> +#ifdef CONFIG_OF_FLAT_TREE
>         /* move of_flat_tree if needed */
>         if (of_data) {
>                 ulong of_start, of_len;
> @@ -949,29 +933,33 @@ #else     /* CONFIG_OF_FLAT_TREE */
>                 memmove ((void *)of_start, (void *)of_data, of_len);
>         }
>
> -       ft_setup(of_flat_tree, kbd, initrd_start, initrd_end);
> -       /* ft_dump_blob(of_flat_tree); */
> -
> -#if defined(CFG_INIT_RAM_LOCK) && !defined(CONFIG_E500)
> -       unlock_ram_in_cache();
> +       /*
> +        * Linux Kernel Parameters (passing board info data):
> +        *   r3: ptr to board info data
> +        *   r4: initrd_start or 0 if no initrd
> +        *   r5: initrd_end - unused if r4 is 0
> +        *   r6: Start of command line string
> +        *   r7: End   of command line string
> +        */
> +#ifdef CONFIG_OF_FLAT_TREE
> +       if (!of_flat_tree)      /* no device tree; boot old style */
>  #endif
> +               (*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);
> +               /* does not return */
> +
>         /*
> -        * Linux Kernel Parameters:
> +        * Linux Kernel Parameters (passing device tree):
>          *   r3: ptr to OF flat tree, followed by the board info data
>          *   r4: physical pointer to the kernel itself
>          *   r5: NULL
>          *   r6: NULL
>          *   r7: NULL
>          */
> -       if (getenv("disable_of") != NULL)
> -               (*kernel) ((bd_t *)of_flat_tree, initrd_start, initrd_end,
> -                       cmd_start, cmd_end);
> -       else {
> -               ft_setup(of_flat_tree, kbd, initrd_start, initrd_end);
> -               /* ft_dump_blob(of_flat_tree); */
> -               (*kernel) ((bd_t *)of_flat_tree, (ulong)kernel, 0, 0, 0);
> -       }
> -#endif /* CONFIG_OF_FLAT_TREE */
> +       ft_setup(of_flat_tree, kbd, initrd_start, initrd_end);
> +       /* ft_dump_blob(of_flat_tree); */
> +
> +       (*kernel) ((bd_t *)of_flat_tree, (ulong)kernel, 0, 0, 0);
> +#endif
>  }
>  #endif /* CONFIG_PPC */
>
> --
> 1.4.3.rc2.g0503
>
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
