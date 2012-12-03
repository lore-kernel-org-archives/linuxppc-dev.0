Return-Path: <kirjanov@gmail.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D09522C0081
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2012 19:03:48 +1100 (EST)
Received: by mail-wi0-f169.google.com with SMTP id hq12so1063675wib.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2012 00:03:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1354515562.3243.27.camel@ThinkPad-T5421.cn.ibm.com>
References: <1354515562.3243.27.camel@ThinkPad-T5421.cn.ibm.com>
Date: Mon, 3 Dec 2012 11:03:44 +0300
Message-ID: <CAHj3AVmF_NV4YoG9TOgWjJ34gCz=+9qtvAKA3o00gxnsRJQdFg@mail.gmail.com>
Subject: Re: [PATCH powerpc] Fix MAX_STACK_TRACE_ENTRIES too low warning for
 ppc32
From: Denis Kirjanov <kirjanov@gmail.com>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Kujau <lists@nerdbynature.de>, Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Could you please provide a more verbose patch description

Thanks.

On 12/3/12, Li Zhong <zhong@linux.vnet.ibm.com> wrote:
> This patch fixes MAX_STACK_TRACE_ENTRIES too low warning for ppc32,
> which is similar to commit 12660b17.
>
> Reported-by: Christian Kujau <lists@nerdbynature.de>
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> Tested-by: Christian Kujau <lists@nerdbynature.de>
> ---
>  arch/powerpc/kernel/entry_32.S |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/entry_32.S
> b/arch/powerpc/kernel/entry_32.S
> index d22e73e..e514de5 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -439,6 +439,8 @@ ret_from_fork:
>  ret_from_kernel_thread:
>  	REST_NVGPRS(r1)
>  	bl	schedule_tail
> +	li	r3,0
> +	stw	r3,0(r1)
>  	mtlr	r14
>  	mr	r3,r15
>  	PPC440EP_ERR42
> --
> 1.7.9.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>


-- 
Regards,
Denis
