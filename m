Return-Path: <michael.neuling@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C759A2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 15:46:47 +1100 (EST)
Received: by mail-pb0-f44.google.com with SMTP id rq2so9314303pbb.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 20:46:44 -0800 (PST)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <8761pdht31.fsf_-_@igel.home>
References: <1356048405-20560-1-git-send-email-mikey@neuling.org>
 <1356048405-20560-7-git-send-email-mikey@neuling.org>
 <12813.1357794092__45363.9676016339$1357794149$gmane$org@ale.ozlabs.ibm.com>
 <8761pdht31.fsf_-_@igel.home>
Date: Wed, 22 Jan 2014 15:46:44 +1100
Message-ID: <CAEjGV6wFsysAvQReQrMTFn1V0kQ2cX7Xs0eVWjBMhDKCJ9rx8Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix hw breakpoints on !HAVE_HW_BREAKPOINT
 configurations
From: Michael Neuling <mikey@neuling.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Content-Type: multipart/alternative; boundary=047d7b339715cfe34004f087cf89
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, imunsie@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b339715cfe34004f087cf89
Content-Type: text/plain; charset=ISO-8859-1

I'm not near my machine to test but looks good.

Thanks,
Mikey
On 22 Jan 2014 08:56, "Andreas Schwab" <schwab@linux-m68k.org> wrote:

> This fixes a logic error that caused a failure to update the hw breakpoint
> registers when not using the hw-breakpoint interface.
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  arch/powerpc/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 4a96556..7714950 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -690,7 +690,7 @@ struct task_struct *__switch_to(struct task_struct
> *prev,
>   * schedule DABR
>   */
>  #ifndef CONFIG_HAVE_HW_BREAKPOINT
> -       if (unlikely(hw_brk_match(&__get_cpu_var(current_brk),
> &new->thread.hw_brk)))
> +       if (unlikely(!hw_brk_match(&__get_cpu_var(current_brk),
> &new->thread.hw_brk)))
>                 set_breakpoint(&new->thread.hw_brk);
>  #endif /* CONFIG_HAVE_HW_BREAKPOINT */
>  #endif
> --
> 1.8.5.3
>
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
>
>

--047d7b339715cfe34004f087cf89
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I&#39;m not near my machine to test but looks good.</p>
<p dir=3D"ltr">Thanks,<br>
Mikey</p>
<div class=3D"gmail_quote">On 22 Jan 2014 08:56, &quot;Andreas Schwab&quot;=
 &lt;<a href=3D"mailto:schwab@linux-m68k.org">schwab@linux-m68k.org</a>&gt;=
 wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
This fixes a logic error that caused a failure to update the hw breakpoint<=
br>
registers when not using the hw-breakpoint interface.<br>
<br>
Signed-off-by: Andreas Schwab &lt;<a href=3D"mailto:schwab@linux-m68k.org">=
schwab@linux-m68k.org</a>&gt;<br>
---<br>
=A0arch/powerpc/kernel/process.c | 2 +-<br>
=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c<=
br>
index 4a96556..7714950 100644<br>
--- a/arch/powerpc/kernel/process.c<br>
+++ b/arch/powerpc/kernel/process.c<br>
@@ -690,7 +690,7 @@ struct task_struct *__switch_to(struct task_struct *pre=
v,<br>
=A0 * schedule DABR<br>
=A0 */<br>
=A0#ifndef CONFIG_HAVE_HW_BREAKPOINT<br>
- =A0 =A0 =A0 if (unlikely(hw_brk_match(&amp;__get_cpu_var(current_brk), &a=
mp;new-&gt;thread.hw_brk)))<br>
+ =A0 =A0 =A0 if (unlikely(!hw_brk_match(&amp;__get_cpu_var(current_brk), &=
amp;new-&gt;thread.hw_brk)))<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_breakpoint(&amp;new-&gt;thread.hw_brk);=
<br>
=A0#endif /* CONFIG_HAVE_HW_BREAKPOINT */<br>
=A0#endif<br>
--<br>
1.8.5.3<br>
<br>
<br>
--<br>
Andreas Schwab, <a href=3D"mailto:schwab@linux-m68k.org">schwab@linux-m68k.=
org</a><br>
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756 =A001D3 44D5 214B 8276 4ED=
5<br>
&quot;And now for something completely different.&quot;<br>
<br>
</blockquote></div>

--047d7b339715cfe34004f087cf89--
