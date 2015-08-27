Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com
 [IPv6:2a00:1450:400c:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA9011A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 22:08:18 +1000 (AEST)
Received: by wicne3 with SMTP id ne3so1857190wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 05:08:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440577578-15813-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2015 15:08:14 +0300
Message-ID: <CAPAsAGwhV6tr3byk8kgjTxrLS0kKoyhoW8AUAXkjLVOaUbuVUA@mail.gmail.com>
Subject: Re: [PATCH V2 09/10] kasan: Prevent deadlock in kasan reporting
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> We we end up calling kasan_report in real mode, our shadow mapping
> for even spinlock variable will show poisoned.

Generally I agree with this patch. We should disable reports when we
print report as early
as possible to prevent recursion in case of bug in spinlock or printk etc.

But I don't understand what is the problem that you observing.
How we ended up with shadow poisoned for a valid spinlock struct?
And since  shadow poisoned for some valid memory we should get
enormous amount of false positive reports.

> This will result
> in us calling kasan_report_error with lock_report spin lock held.
> To prevent this disable kasan reporting when we are priting
> error w.r.t kasan.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  mm/kasan/report.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 79fbc5d14bd2..82b41eb83e43 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -185,6 +185,10 @@ void kasan_report_error(struct kasan_access_info *info)
>  {
>         unsigned long flags;
>
> +       /*
> +        * Make sure we don't end up in loop.
> +        */
> +       kasan_disable_current();
>         spin_lock_irqsave(&report_lock, flags);
>         pr_err("================================="
>                 "=================================\n");
> @@ -194,12 +198,17 @@ void kasan_report_error(struct kasan_access_info *info)
>         pr_err("================================="
>                 "=================================\n");
>         spin_unlock_irqrestore(&report_lock, flags);
> +       kasan_enable_current();
>  }
>
>  void kasan_report_user_access(struct kasan_access_info *info)
>  {
>         unsigned long flags;
>
> +       /*
> +        * Make sure we don't end up in loop.
> +        */
> +       kasan_disable_current();
>         spin_lock_irqsave(&report_lock, flags);
>         pr_err("================================="
>                 "=================================\n");
> @@ -212,6 +221,7 @@ void kasan_report_user_access(struct kasan_access_info *info)
>         pr_err("================================="
>                 "=================================\n");
>         spin_unlock_irqrestore(&report_lock, flags);
> +       kasan_enable_current();
>  }
>
>  void kasan_report(unsigned long addr, size_t size,
> --
> 2.5.0
>
