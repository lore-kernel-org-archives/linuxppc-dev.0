Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqmD10hJQzDrpw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 11:37:04 +1100 (AEDT)
Received: by mail-ua0-x243.google.com with SMTP id t24so11351087uaa.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Dec 2017 16:37:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171203123658.056226c1@roar.ozlabs.ibm.com>
References: <20171202134808.27480-1-bsingharora@gmail.com>
 <20171203123658.056226c1@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 4 Dec 2017 11:37:01 +1100
Message-ID: <CAKTCnz=w5KEECS2RwWjrfDVgMVZWYJqQb4C8EOUbfZh2Bb=z4A@mail.gmail.com>
Subject: Re: [rfc] powernv/kdump: Fix cases where the kdump kernel can get
 HMI's
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 3, 2017 at 1:36 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> Seems like a reasonable approach. Why do we only do this for
> powernv? It seems like a good idea in general to pull all
> offlined CPUs out and into the same state for all platforms
> and for all shutdown/restart/crash paths.
>

The reason is largely wake-up related, do we expect offline CPUs to wake
up in the kdump kernel. Largely the infrastructure allows us to selectively
decide what platforms need this support. I did not want to break the world
by enabling it across platforms (pseries for example) without good reason.

> Also I wonder if there is anything we should do on the other
> side of the equation for the kdump kernel to pull CPUs into a
> known state rather than rely on the crash kernel to do it for
> us. We might have a better ability to do that with system
> reset IPIs now.
>

Yes, but do we need to do that or quickly dump the vmcore to a file
and exit? Ideally we want the original kernel to wake offline cpus
as appropriate (as we do with kexec) and send them to opal_reinit_cpus
and make them spin on kexec_spin_wait(). The kdump kernel boots
with maxcpus=1 and leaves them spinning

> We still need to support platforms without NMI IPIs, so we
> still need this patch as well.
>

True

Thanks for the review!
Balbir Singh
