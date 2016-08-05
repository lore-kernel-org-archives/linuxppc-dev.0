Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5JK04FvmzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 17:26:44 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc/32: fix csum_partial_copy_generic()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Scott Wood <oss@buserror.net>
References: <20160802080705.69A9F1A2394@localhost.localdomain>
 <1470282813.25630.242.camel@buserror.net>
 <CAPk1OjHjVKOhh_WfnYnkb+1abyBzzHkOO_H2rFx3KMhe0yc+0Q@mail.gmail.com>
 <87shujitxx.fsf@concordia.ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 antoine.blangy@c-s.fr, segher@kernel.crashing.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ab39b1b1-2320-31ba-3f19-11a62e3586b8@c-s.fr>
Date: Fri, 5 Aug 2016 09:26:41 +0200
MIME-Version: 1.0
In-Reply-To: <87shujitxx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/08/2016 à 08:57, Michael Ellerman a écrit :
> Alessio Igor Bogani <alessio.bogani@elettra.eu> writes:
>> On 4 August 2016 at 05:53, Scott Wood <oss@buserror.net> wrote:
>>> On Tue, 2016-08-02 at 10:07 +0200, Christophe Leroy wrote:
>>>> commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
>>>> based on copy_tofrom_user()") introduced a bug when destination
>>>> address is odd and initial csum is not null
>>>>
>>>> In that (rare) case the initial csum value has to be rotated one byte
>>>> as well as the resulting value is
>>>>
>>>> This patch also fixes related comments
>>>>
>>>> Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
>>>> based on copy_tofrom_user()")
>>>> Cc: stable@vger.kernel.org
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> ---
>>>>   v2: updated comments as suggested by Segher
>>>>
>>>>   arch/powerpc/lib/checksum_32.S | 7 ++++---
>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>> Alessio, can you confirm whether this fixes the problem you reported?
>> No unfortunately.
> Thanks for testing.
>
> I've dropped the patch for now, send me a new one that works.
>
>

The purpose of this patch was not to address Alessio's issue, but to fix 
a huge issue on checksum calculation which induces breakdown of TCP 
connections.

I think it is worth commiting it upstream and on impacted stable 
releases, allthought we don't have yet identified the issue Alessio's has.

Christophe
