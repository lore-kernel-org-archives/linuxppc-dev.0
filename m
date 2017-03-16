Return-Path: <srs0=zegp=2z=gmail.com=arndbergmann@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkPHR6ZhvzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:05:39 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vkPHR60vKz8sfr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:05:39 +1100 (AEDT)
Received: from mail-ot0-x243.google.com (mail-ot0-x243.google.com
 [IPv6:2607:f8b0:4003:c0f::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vkPHR1CNpz9s03
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 21:05:39 +1100 (AEDT)
Received: by mail-ot0-x243.google.com with SMTP id i1so6863091ota.3
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 03:05:39 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <877f3plf57.fsf@concordia.ellerman.id.au>
References: <1473501690-11987-1-git-send-email-mpe@ellerman.id.au>
 <87wpbsuo4x.fsf@concordia.ellerman.id.au>
 <CAK8P3a0wfXrj3gJAffHLhqQjqcZWy2=WEVUordLxH-jOKAe0qw@mail.gmail.com>
 <8760jbump6.fsf@concordia.ellerman.id.au>
 <CAK8P3a2TzAdOnyOyS5ZbQK5WRkNKnGxLc=7SYjw_Y75VdbnyZw@mail.gmail.com>
 <877f3plf57.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Mar 2017 11:05:35 +0100
Message-ID: <CAK8P3a3+dk1XMeefWPDKsQOmYC=Tz5zkzQ8d2tZcc90QczSMxw@mail.gmail.com>
Subject: Re: [PATCH] drivers/pcmcia: NO_IRQ removal for electra_cf.c
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pcmcia@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, oss@buserror.net,
 linuxppc-dev@ozlabs.org,
 Claudiu Manoil <claudiu.manoil@nxp.com>, qiang.zhao@nxp.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 16, 2017 at 10:55 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>> On Wed, Mar 15, 2017 at 6:35 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> I'll do patches for everything above that's not drivers/soc or
>>> include/soc and hopefully we can hear from someone at NXP on the plans
>>> for getting the soc parts enabled on arm.
>>
>> I think the removal of the NO_IRQ references is a requirement for
>> getting the drivers working properly on ARM, as the OF platform
>> code will use '0' for invalid IRQs.
>
> OK. So the #define NO_IRQ (-1) in arch/arm/include/asm/irq.h is a red
> herring and should be ignored for anything modern?

Correct. There are a couple of older (non-DT) platforms that still rely on it,
and I also have patches for those, which I intend to revisit at some point.

     Arnd
