Return-Path: <geert.uytterhoeven@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 376B41A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 21:17:40 +1100 (AEDT)
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com
 [IPv6:2607:f8b0:4003:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9EF9C140140
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2015 21:17:39 +1100 (AEDT)
Received: by oigz129 with SMTP id z129so79125478oig.1
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2015 03:17:37 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150319230848.GB31148@iris.ozlabs.ibm.com>
References: <54EE5989.7010800@linux.vnet.ibm.com>
 <20150319230848.GB31148@iris.ozlabs.ibm.com>
Date: Mon, 30 Mar 2015 12:17:37 +0200
Message-ID: <CAMuHMdVX450vQpYzZX+QGTY9ZUfaTuHZaNgizmuCd0HiaUc=_w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export __spin_yield
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Fri, Mar 20, 2015 at 12:08 AM, Paul Mackerras <paulus@samba.org> wrote:
> On Wed, Feb 25, 2015 at 05:23:53PM -0600, Suresh E. Warrier wrote:
>> Export __spin_yield so that the arch_spin_unlock() function can
>> be invoked from a module. This will be required for modules where
>> we want to take a lock that is also is acquired in hypervisor
>> real mode. Because we want to avoid running any lockdep code
>> (which may not be safe in real mode), this lock needs to be
>> an arch_spinlock_t instead of a normal spinlock.
>>
>> Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
>
> Acked-by: Paul Mackerras <paulus@samba.org>

Something went wrong when applying this, as it ended up as:

commit 1f8c82ab1b0bc7e24601c0fca411fd27b9c883ef
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Wed Mar 4 12:56:20 2015 +0100

    cpufreq/ppc: Add missing #include <asm/smp.h>

    If CONFIG_SMP=n, <linux/smp.h> does not include <asm/smp.h>, causing:

    drivers/cpufreq/ppc-corenet-cpufreq.c: In function 'corenet_cpufreq_cpu_init
    drivers/cpufreq/ppc-corenet-cpufreq.c:173:3: error: implicit declaration of
    X-Patchwork-Id: 443703
    Message-Id: <54EE5989.7010800@linux.vnet.ibm.com>
    To: linuxppc-dev@ozlabs.org
    Date: Wed, 25 Feb 2015 17:23:53 -0600

    Export __spin_yield so that the arch_spin_unlock() function can
    be invoked from a module. This will be required for modules where
    we want to take a lock that is also is acquired in hypervisor
    real mode. Because we want to avoid running any lockdep code
    (which may not be safe in real mode), this lock needs to be
    an arch_spinlock_t instead of a normal spinlock.

    Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
    Acked-by: Paul Mackerras <paulus@samba.org>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
