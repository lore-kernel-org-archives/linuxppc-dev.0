Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-x244.google.com (mail-ot0-x244.google.com
 [IPv6:2607:f8b0:4003:c0f::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vn0B484fzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 05:26:18 +1000 (AEST)
Received: by mail-ot0-x244.google.com with SMTP id g7-v6so14465054otj.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 12:26:17 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180527223403.GT30522@ZenIV.linux.org.uk>
References: <20180527223403.GT30522@ZenIV.linux.org.uk>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 28 May 2018 21:25:55 +0200
Message-ID: <CA+7wUswhpVRQ4yECc-Zh9djHxiT=9-ALuP7_=mfLMtU-NXDnfg@mail.gmail.com>
Subject: Re: [PATCH][RFC] [powerpc] arch_ptrace() uses of access_ok() are
 pointless
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 28, 2018 at 12:34 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> make it use copy_{from,to}_user(), rather than access_ok() +
> __copy_...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/powerpc/kernel/ptrace.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index d23cf632edf0..d8b0fd2fa3aa 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3081,27 +3081,19 @@ long arch_ptrace(struct task_struct *child, long =
request,
>  #endif /* CONFIG_HAVE_HW_BREAKPOINT */
>  #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
>
> -               if (!access_ok(VERIFY_WRITE, datavp,
> -                              sizeof(struct ppc_debug_info)))
> +               if (unlikely(copy_to_user(datavp, &dbginfo,
> +                                    sizeof(struct ppc_debug_info)))


Maybe this is just an RFC, but:

  CALL    ../arch/powerpc/kernel/systbl_chk.sh
../arch/powerpc/kernel/ptrace.c: In function =E2=80=98arch_ptrace=E2=80=99:
../arch/powerpc/kernel/ptrace.c:3086:4: error: expected =E2=80=98)=E2=80=99=
 before =E2=80=98return=E2=80=99
    return -EFAULT;
    ^~~~~~

Missing closing parenthesis.

>                         return -EFAULT;
> -               ret =3D __copy_to_user(datavp, &dbginfo,
> -                                    sizeof(struct ppc_debug_info)) ?
> -                     -EFAULT : 0;
> -               break;
> +               return 0;
>         }
>
>         case PPC_PTRACE_SETHWDEBUG: {
>                 struct ppc_hw_breakpoint bp_info;
>
> -               if (!access_ok(VERIFY_READ, datavp,
> -                              sizeof(struct ppc_hw_breakpoint)))
> -                       return -EFAULT;
> -               ret =3D __copy_from_user(&bp_info, datavp,
> -                                      sizeof(struct ppc_hw_breakpoint)) =
?
> -                     -EFAULT : 0;
> -               if (!ret)
> -                       ret =3D ppc_set_hwdebug(child, &bp_info);
> -               break;
> +               if (unlikely(copy_from_user(&bp_info, datavp,
> +                                      sizeof(struct ppc_hw_breakpoint)))
> +                     return -EFAULT;
> +               return ppc_set_hwdebug(child, &bp_info);
>         }
>
>         case PPC_PTRACE_DELHWDEBUG: {
> --
> 2.11.0
>
