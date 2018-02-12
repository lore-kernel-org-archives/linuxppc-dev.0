Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgLlX38gDzF0y9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 10:02:00 +1100 (AEDT)
Received: by mail-ua0-x244.google.com with SMTP id y17so8716586uaa.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 15:01:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
References: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 13 Feb 2018 10:01:57 +1100
Message-ID: <CAKTCnzmtDNJHThzuZa1+ydrriQG-dVovHA7uLSVvfLFG2MaidQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/kdump: Add missing optional dummy functions
To: Guenter Roeck <linux@roeck-us.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2018 at 9:34 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> If KEXEC_CORE is not enabled, PowerNV builds fail as follows.
>
> arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
> arch/powerpc/platforms/powernv/smp.c:236:4: error:
>         implicit declaration of function 'crash_ipi_callback'
>
> Add dummy function calls, similar to kdump_in_progress(), to solve the
> problem.
>
> Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Thanks for working on this.

You've added two functions, I understand the crash_send_ipi() bits
that I broke. Looks like crash_ipi_callback broken without KEXEC_CORE?

I am going to test these patches, for now

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
