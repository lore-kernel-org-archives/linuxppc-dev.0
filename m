Return-Path: <namhyung.with.foss@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vd1xp11VYzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 03:16:46 +1100 (AEDT)
Received: by mail-ua0-x244.google.com with SMTP id f54so1340441uaa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 08:16:46 -0800 (PST)
MIME-Version: 1.0
Sender: namhyung.with.foss@gmail.com
In-Reply-To: <1488837332-71582-4-git-send-email-keescook@chromium.org>
References: <1488837332-71582-1-git-send-email-keescook@chromium.org>
 <1488837332-71582-4-git-send-email-keescook@chromium.org>
From: Namhyung Kim <namhyung@gmail.com>
Date: Wed, 8 Mar 2017 01:16:43 +0900
Message-ID: <CADWwUUZAxwUqHU9eRrtP5Hk7KO9KkyvdBy7Z5Xehwhv43fvZVQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] pstore: Avoid race in module unloading
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.kw@hitachi.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Anton Vorontsov <anton@enomsg.org>,
 Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Len Brown <lenb@kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Geliang Tang <geliangtang@163.com>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kees,

On Tue, Mar 7, 2017 at 6:55 AM, Kees Cook <keescook@chromium.org> wrote:
> Technically, it might be possible for struct pstore_info to go out of
> scope after the module_put(), so report the backend name first.

But in that case, using pstore will crash the kernel anyway, right?
If so, why pstore doesn't keep a reference until unregister?
Do I miss something?

Thanks,
Namhyung


>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/pstore/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 074fe85a2078..d69ef8a840b9 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -722,10 +722,10 @@ int pstore_register(struct pstore_info *psi)
>          */
>         backend = psi->name;
>
> -       module_put(owner);
> -
>         pr_info("Registered %s as persistent store backend\n", psi->name);
>
> +       module_put(owner);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(pstore_register);
> --
> 2.7.4
>
