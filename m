Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0058.outbound.protection.outlook.com [104.47.2.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnJMK3qYPzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 19:34:37 +1000 (AEST)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Gregory Fong
 <gregory.0xf0@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: mpic IRQ_TYPE_BOTH handling
Date: Wed, 6 Sep 2017 09:34:31 +0000
Message-ID: <59AFC126.30909@nxp.com>
References: <CADtm3G6VVthsOX7d_LHNtFdCvw+oiku=ATL8J-cBHBpLTVrpyg@mail.gmail.com>
 <87efrs8y8q.fsf@concordia.ellerman.id.au>
In-Reply-To: <87efrs8y8q.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/31/2017 01:52 AM, Michael Ellerman wrote:
> Hi Gregory,
>
> Gregory Fong <gregory.0xf0@gmail.com> writes:
>> Hi all,
>>
>> In arch/powerpc/sysdev/mpic.c , it looks like IRQ_TYPE_EDGE_BOTH is
>> handled the same way as IRQ_TYPE_EDGE_FALLING:
>>
>> static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int =
type)
>> {
>>          /* Now convert sense value */
>>          switch(type & IRQ_TYPE_SENSE_MASK) {
>>          case IRQ_TYPE_EDGE_RISING:
>>                  return MPIC_INFO(VECPRI_SENSE_EDGE) |
>>                         MPIC_INFO(VECPRI_POLARITY_POSITIVE);
>>          case IRQ_TYPE_EDGE_FALLING:
>>          case IRQ_TYPE_EDGE_BOTH:
>>                  return MPIC_INFO(VECPRI_SENSE_EDGE) |
>>                         MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
>>          case IRQ_TYPE_LEVEL_HIGH:
>>                  return MPIC_INFO(VECPRI_SENSE_LEVEL) |
>>                         MPIC_INFO(VECPRI_POLARITY_POSITIVE);
>>          case IRQ_TYPE_LEVEL_LOW:
>>          default:
>>                  return MPIC_INFO(VECPRI_SENSE_LEVEL) |
>>                         MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
>>          }
>> }
>>
>> If IRQ_TYPE_EDGE_BOTH is unsupported, shouldn't we be returning an
>> error, instead of silently setting to use IRQ_TYPE_EDGE_FALLING?
>> Something like the following (sorry if the diff wraps weirdly, on
>> webmail at the moment):
>
> I don't know this code so I asked Ben and he said something like
> "PowerMacs never use BOTH, so it hasn't mattered, but Freescale machines
> might".

IIRC, the mpic in freescale MPICs the interrupts are either low or high,=20
so not both. There's a bit which controls the interrupt polarity which=20
selects if the interrupt triggers on high-to-low or low-to-high.
So i guess it doesn't matter on freescale machines too.

---
Best Regards, Laurentiu=
