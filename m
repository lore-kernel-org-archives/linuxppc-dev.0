Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5HgZ4Ng8zDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 16:57:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Scott Wood <oss@buserror.net>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org, antoine.blangy@c-s.fr,
 segher@kernel.crashing.org
Subject: Re: [PATCH v2] powerpc/32: fix csum_partial_copy_generic()
In-Reply-To: <CAPk1OjHjVKOhh_WfnYnkb+1abyBzzHkOO_H2rFx3KMhe0yc+0Q@mail.gmail.com>
References: <20160802080705.69A9F1A2394@localhost.localdomain>
 <1470282813.25630.242.camel@buserror.net>
 <CAPk1OjHjVKOhh_WfnYnkb+1abyBzzHkOO_H2rFx3KMhe0yc+0Q@mail.gmail.com>
Date: Fri, 05 Aug 2016 16:57:46 +1000
Message-ID: <87shujitxx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alessio Igor Bogani <alessio.bogani@elettra.eu> writes:
> On 4 August 2016 at 05:53, Scott Wood <oss@buserror.net> wrote:
>> On Tue, 2016-08-02 at 10:07 +0200, Christophe Leroy wrote:
>>> commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
>>> based on copy_tofrom_user()") introduced a bug when destination
>>> address is odd and initial csum is not null
>>>
>>> In that (rare) case the initial csum value has to be rotated one byte
>>> as well as the resulting value is
>>>
>>> This patch also fixes related comments
>>>
>>> Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
>>> based on copy_tofrom_user()")
>>> Cc: stable@vger.kernel.org
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>  v2: updated comments as suggested by Segher
>>>
>>>  arch/powerpc/lib/checksum_32.S | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> Alessio, can you confirm whether this fixes the problem you reported?
>
> No unfortunately.

Thanks for testing.

I've dropped the patch for now, send me a new one that works.

cheers
