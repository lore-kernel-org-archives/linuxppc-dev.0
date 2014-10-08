Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9330D1A1B0A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 21:28:08 +1100 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D70D1400E2
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2014 21:28:08 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 8 Oct 2014 20:28:07 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v4 13/16] cxl: Driver code for powernv PCIe based cards
 for userspace access
In-reply-to: <1412758505-23495-14-git-send-email-mikey@neuling.org>
References: <1412758505-23495-1-git-send-email-mikey@neuling.org>
 <1412758505-23495-14-git-send-email-mikey@neuling.org>
Date: Wed, 08 Oct 2014 21:28:05 +1100
Message-Id: <1412763264-sup-2737@delenn.ozlabs.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, arnd <arnd@arndb.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, greg <greg@kroah.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Neuling's message of 2014-10-08 19:55:02 +1100:
> +static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
> +            loff_t *off)
...
> +    for (;;) {
> +        prepare_to_wait(&ctx->wq, &wait, TASK_INTERRUPTIBLE);
> +        if (ctx_event_pending(ctx))
> +            break;
> +
> +        spin_unlock_irqrestore(&ctx->lock, flags);
> +        if (file->f_flags & O_NONBLOCK)
> +            return -EAGAIN;
> +
> +        if (signal_pending(current))
> +            return -ERESTARTSYS;

Looks like I mucked this up while refactoring - these two cases no
longer call finish_wait() which can lead to a crash if something later
wakes up the ctx->wq... I'll post a fix in a separate patch shortly.

-Ian
