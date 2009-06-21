Return-Path: <penberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BD103B71E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 20:21:02 +1000 (EST)
Received: from mail-bw0-f219.google.com (mail-bw0-f219.google.com
	[209.85.218.219]) by ozlabs.org (Postfix) with ESMTP id 8206FDDD1C
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 20:21:00 +1000 (EST)
Received: by bwz19 with SMTP id 19so2902555bwz.9
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 03:20:57 -0700 (PDT)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <200906210628.35553.elendil@planet.nl>
References: <20090620154824.72b5cd50@lappy.seanm.ca>
	<200906202256.46073.elendil@planet.nl>
	<20090620194250.5a3e826f@lappy.seanm.ca>
	<200906210628.35553.elendil@planet.nl>
Date: Sun, 21 Jun 2009 13:20:56 +0300
Message-ID: <84144f020906210320n2984807dw2d4b4fb38afd22cf@mail.gmail.com>
Subject: Re: Badness on the Warp
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Frans Pop <elendil@planet.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Sean MacLennan <smaclennan@pikatech.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 21, 2009 at 7:28 AM, Frans Pop<elendil@planet.nl> wrote:
> On Sunday 21 June 2009, Sean MacLennan wrote:
>> I found the source of the badness. The backtrace is correct:
>>
>> uic_init_one
>
> So that's in arch/powerpc/sysdev/uic.c.
>
>> ___alloc_bootmem
>> ___alloc_bootmem_nopanic
>> alloc_arch_preferred_bootmem
>>
>> In alloc_arch_preferred_bootmem we have:
>>
>> =A0 =A0 =A0 if (WARN_ON_ONCE(slab_is_available()))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return kzalloc(size, GFP_NOWAIT);
>>
>> Since the slab is available (it had better be or the call will return
>> NULL), we get the badness message, then a successful return from
>> kzalloc.
>>
>> I believe the author wants something like:
>>
>> =A0 =A0 =A0 if (slab_is_available())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return kzalloc(size, GFP_NOWAIT);
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON_ONCE(1);
>
> Well, I myself have no idea. It could also indicate a bug in the uic code=
.
>
> But let's CC some people responsible for this code. Pekka recently added
> this WARN that triggers in your case; David and Paul look to be the
> people most involved in the uic code.
>
> Start of the thread is at http://lkml.org/lkml/2009/6/20/165.

The WARN_ON() is there to let us know that someone is doing a bootmem
allocation but the slab allocator is already up. So the proper fix
here is to use kmalloc() directly in the call-site that triggers this
WARN_ON. I'm cc'ing Ben as he has been taking care of the fall-out
from my patches on ppc.

                                  Pekka
