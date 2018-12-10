Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C72C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 23:21:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FFD2081F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 23:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Gw+k2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FFD2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DJwl5XB0zDqjy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 10:21:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7Gw+k2P";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7Gw+k2P"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DJsx0vdVzDqjL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 10:18:45 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id x19so709392itl.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 15:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XZeKzG0rq+OwDUq77h0PCqKPkscSqV9vbz/akwP1/Zc=;
 b=S7Gw+k2PxLiTsmg+UiS8lBcud7uHqtNnXAuU6LqCQD+VZeKd0UEP7MhS2x6hZ6hKO6
 lcjtWKVnvSaoucp4CE58PCoYf249CSySYyiE3WSGa6P6FBYmcVL5kp1LbApMT2YbvWz6
 QIxYEHcNXGeomAsN8I4Od1mjqvP9vvoPVygUgdN7L7ZO95DSftNYl5JIET1G38My0IgH
 8sIL+o5+lHxe6vypEnqU+QlE8rgXXI0DENjn9IKVocojZcdH86ySiCB4gLbpZy/9LDY6
 izqjFqwYtU05KIIlmqnBzcrLm/m9LVy6c2U7uiZbJYHkBRKoug599f4UQ2W3jrmif/RU
 HoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XZeKzG0rq+OwDUq77h0PCqKPkscSqV9vbz/akwP1/Zc=;
 b=Rnt84LVJsjnFNdn59KBw5NgJzY4CKQKOT9rF5/yW3X8ra4UUFoP9c8bNVvjVXpInjp
 k/FUQ/FoNxcEUmQB/4MtRGIBCUzZGf//OIMldp4nBlUFvi1c6RV7z6mN1pa9wuZWNzDa
 xWk/ZscdskxkKxguZh1uj4Bgy5G5E0Zm/xDwkklc586GHQTCYBkT7fgDfGJ9gTpAw2Zj
 eoqNFfMUEy8oefr8YqSXzETXMwAZVRlK3Iygfl1A7kULF/q1sNnlXWN8r2ZOHidGxfwD
 XmKzDILH13pXY1Wej58MJMZLaD2KCZoc9JHLWE2TpfcFGscJawBl4fBriIveD3CJb8eT
 QrYQ==
X-Gm-Message-State: AA+aEWbziGIdM0eEx984ezW5lwVY2nKw7No/LzQnCbLhbO44420AM6N3
 p9y6RXscjUa4gKNNgf0/UQAmdqYRLYms3NrhGCc=
X-Google-Smtp-Source: AFSGD/W66olXv/neSxyusWeZajxoJMfLo70gWqQfj5dwWMxjLtgW42Gg0t6UXV95Yh8J3jnJXO4J+K2qlibn/3UVg6I=
X-Received: by 2002:a02:5618:: with SMTP id o24mr14015831jab.111.1544483922856; 
 Mon, 10 Dec 2018 15:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20181210215203.1936171-1-arnd@arndb.de>
In-Reply-To: <20181210215203.1936171-1-arnd@arndb.de>
From: Oliver <oohall@gmail.com>
Date: Tue, 11 Dec 2018 10:18:31 +1100
Message-ID: <CAOSf1CHqxaGdz_F0EifqHmD+0ZgKVno7aRZEXUG1880C5YvHGQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: eeh_event: convert semaphore to completion
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, aik@ozlabs.ru,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 11, 2018 at 8:52 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> For this use case, completions and semaphores are equivalent,
> but semaphores are an awkward interface that should generally
> be avoided, so use the completion instead.

IIRC Sam has been reworking the locking used inside of EEH so this is
probably going to clash with his changes. Converting to a completion
is probably a good idea, but we might want to do it as a part of his
series since it's going to collide with this anyway.

Sam, what do you think?

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/kernel/eeh_event.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
> index 61c9356bf9c9..227e57f980df 100644
> --- a/arch/powerpc/kernel/eeh_event.c
> +++ b/arch/powerpc/kernel/eeh_event.c
> @@ -35,7 +35,7 @@
>   */
>
>  static DEFINE_SPINLOCK(eeh_eventlist_lock);
> -static struct semaphore eeh_eventlist_sem;
> +static DECLARE_COMPLETION(eeh_eventlist_event);
>  static LIST_HEAD(eeh_eventlist);
>
>  /**
> @@ -55,7 +55,7 @@ static int eeh_event_handler(void * dummy)
>         struct eeh_pe *pe;
>
>         while (!kthread_should_stop()) {
> -               if (down_interruptible(&eeh_eventlist_sem))
> +               if (wait_for_completion_interruptible(&eeh_eventlist_event))
>                         break;
>
>                 /* Fetch EEH event from the queue */
> @@ -102,9 +102,6 @@ int eeh_event_init(void)
>         struct task_struct *t;
>         int ret = 0;
>
> -       /* Initialize semaphore */
> -       sema_init(&eeh_eventlist_sem, 0);
> -
>         t = kthread_run(eeh_event_handler, NULL, "eehd");
>         if (IS_ERR(t)) {
>                 ret = PTR_ERR(t);
> @@ -142,7 +139,7 @@ int eeh_send_failure_event(struct eeh_pe *pe)
>         spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
>
>         /* For EEH deamon to knick in */
> -       up(&eeh_eventlist_sem);
> +       complete(&eeh_eventlist_event);
>
>         return 0;
>  }
> --
> 2.20.0
>
