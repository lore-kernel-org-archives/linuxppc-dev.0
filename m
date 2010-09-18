Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id 77F29B70AB
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 10:38:54 +1000 (EST)
Received: by wwi18 with SMTP id 18so495330wwi.21
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 17:38:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1284764008-19469-1-git-send-email-timur@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
Date: Fri, 17 Sep 2010 20:38:52 -0400
Message-ID: <AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
From: Josh Boyer <jwboyer@gmail.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kumar.gala@freescale.com, linux-watchdog@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 17, 2010 at 6:53 PM, Timur Tabi <timur@freescale.com> wrote:
> Export the global variable 'ppc_tb_freq', so that modules (like the Book-=
E
> watchdog driver) can use it.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This export is necessary for the Book-E watchdog driver to be compiled as=
 a
> module. =A0Since ppc_proc_freq is already exported, I figured it's okay f=
or
> ppc_tb_freq to be exported as well.
>
> =A0arch/powerpc/kernel/time.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 8533b3b..49aa130 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -163,6 +163,7 @@ static long timezone_offset;
> =A0unsigned long ppc_proc_freq;
> =A0EXPORT_SYMBOL(ppc_proc_freq);
> =A0unsigned long ppc_tb_freq;
> +EXPORT_SYMBOL(ppc_tb_freq);

EXPORT_SYMBOL_GPL probably, no?

josh
