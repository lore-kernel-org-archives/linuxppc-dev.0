Return-Path: <kodiakuppercut@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D7A67B70F7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 07:56:41 +1000 (EST)
Received: from mail-gx0-f216.google.com (mail-gx0-f216.google.com
	[209.85.217.216]) by ozlabs.org (Postfix) with ESMTP id 403EEDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 07:56:40 +1000 (EST)
Received: by gxk12 with SMTP id 12so2992479gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Jul 2009 14:56:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A4D2332.1060607@freescale.com>
References: <bc81dc640907021311y1395ed15l2d50cebb3749c29f@mail.gmail.com>
	<4A4D2332.1060607@freescale.com>
Date: Thu, 2 Jul 2009 15:56:39 -0600
Message-ID: <bc81dc640907021456v2e7750cer5732d5c84953801a@mail.gmail.com>
Subject: Re: Non-contiguous physical memory on 8572
From: Aaron Pace <kodiakuppercut@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 2, 2009 at 3:14 PM, Scott Wood<scottwood@freescale.com> wrote:
> Aaron Pace wrote:
>>
>> In MMU_init of arch/powerpc/mm/init_32.c, where the current code sets
>> lmb.memory.cnt to zero, I instead walk through the memory regions and
>> call lmb_reserve for each chunk of memory that lies in a 'hole'.
>> There are then some minor fixups to make sure that total_memory and
>> total_highmem get the right numbers. =A0This small change allows all
>> four gigabytes of memory to be accessed and used in my tests.
>>
>> Am I missing something obvious?
>
> The main downsides that I see are wasted memory for bookkeeping of the ho=
le
> (how acceptable this is depends on how large the hole is relative to the
> size of RAM -- it's a tradeoff against speed of looking up page structs),
> and that the reserved area may still be mapped in the TLB without the
> guarded bit set.
>
> -Scott
>
>

Ah, thanks for the response.
A couple of followup  clarifications/questions, if you don't mind.
As far as wasted memory for bookkeeping, aren't the reserved regions
excluded from any zonelist/pagetable allocation?  I'm looking through
to verify, but if you know off the top of your head where any extra
data would be required to keep track, I'd like to take a look to
further educate my memory manager understanding.

Secondly, can you elaborate on how/when the reserved area could be
mapped into the TLB?  I don't by any means lay claim to a complete
understanding of this area, but aside from a direct ioremap/mmap call,
how would this area get mapped at all?

Thanks again,
Aaron
