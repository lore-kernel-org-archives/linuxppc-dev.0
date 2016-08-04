Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4fnm6z0DzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 16:15:54 +1000 (AEST)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 7A597440DE6_7A2DD96B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 06:15:50 +0000 (GMT)
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com
 [209.85.220.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 AAD4243E0A0_7A2DD94F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 06:15:48 +0000 (GMT)
Received: by mail-qk0-f172.google.com with SMTP id x185so30435069qkc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 23:15:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1470282813.25630.242.camel@buserror.net>
References: <20160802080705.69A9F1A2394@localhost.localdomain>
 <1470282813.25630.242.camel@buserror.net>
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Thu, 4 Aug 2016 08:15:46 +0200
Message-ID: <CAPk1OjHjVKOhh_WfnYnkb+1abyBzzHkOO_H2rFx3KMhe0yc+0Q@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/32: fix csum_partial_copy_generic()
To: Scott Wood <oss@buserror.net>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org, antoine.blangy@c-s.fr,
 segher@kernel.crashing.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

On 4 August 2016 at 05:53, Scott Wood <oss@buserror.net> wrote:
> On Tue, 2016-08-02 at 10:07 +0200, Christophe Leroy wrote:
>> commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
>> based on copy_tofrom_user()") introduced a bug when destination
>> address is odd and initial csum is not null
>>
>> In that (rare) case the initial csum value has to be rotated one byte
>> as well as the resulting value is
>>
>> This patch also fixes related comments
>>
>> Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
>> based on copy_tofrom_user()")
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  v2: updated comments as suggested by Segher
>>
>>  arch/powerpc/lib/checksum_32.S | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Alessio, can you confirm whether this fixes the problem you reported?

No unfortunately.

Ciao,
Alessio
