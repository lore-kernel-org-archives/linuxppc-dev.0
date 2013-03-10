Return-Path: <penberg@gmail.com>
Received: from mail-we0-x231.google.com (mail-we0-x231.google.com
 [IPv6:2a00:1450:400c:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A1542C0315
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2013 01:11:01 +1100 (EST)
Received: by mail-we0-f177.google.com with SMTP id d7so2611294wer.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 07:10:57 -0700 (PDT)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <1362920779-25925-1-git-send-email-alex.grad@gmail.com>
References: <1362920779-25925-1-git-send-email-alex.grad@gmail.com>
Date: Sun, 10 Mar 2013 16:10:56 +0200
Message-ID: <CAOJsxLGD1fXsGMCQbP8aAMDsRiwPD2hHcfWfupO4jy5=JCM=NA@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Removed kmalloc returned value cast
From: Pekka Enberg <penberg@kernel.org>
To: Alex Grad <alex.grad@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, fr@canb.auug.org.au, linux-kernel@vger.kernel.org,
 tiejun.chen@windriver.com, paulus@samba.org, jason.wessel@windriver.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 10, 2013 at 3:06 PM, Alex Grad <alex.grad@gmail.com> wrote:
> Signed-off-by: Alex Grad <alex.grad@gmail.com>
> ---
>  arch/powerpc/kernel/kgdb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 5ca82cd..c1eef24 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -159,7 +159,7 @@ static int kgdb_singlestep(struct pt_regs *regs)
>         if (user_mode(regs))
>                 return 0;
>
> -       backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
> +       backup_current_thread_info = kmalloc(sizeof(struct thread_info), GFP_KERNEL);

Looks good to me.

There's two additional problems in the kgdb_singlestep() function: it
doesn't check if the kmalloc() call fails nor does it kfree() the
allocated memory.

                        Pekka
