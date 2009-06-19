Return-Path: <vapier.adi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7334DB72A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 10:49:24 +1000 (EST)
Received: from mail-yx0-f198.google.com (mail-yx0-f198.google.com
	[209.85.210.198]) by ozlabs.org (Postfix) with ESMTP id BF393DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 10:49:23 +1000 (EST)
Received: by yxe36 with SMTP id 36so2024468yxe.15
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 17:49:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <19002.57382.880505.913539@cargo.ozlabs.ibm.com>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<8bd0f97a0906181655jd68835fg10fe0783b6a6068d@mail.gmail.com>
	<19002.57382.880505.913539@cargo.ozlabs.ibm.com>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Thu, 18 Jun 2009 20:49:02 -0400
Message-ID: <8bd0f97a0906181749h43f70338te96ea41f90caa3b7@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 18, 2009 at 20:47, Paul Mackerras wrote:
> Mike Frysinger writes:
>> On Sat, Jun 13, 2009 at 03:10, Paul Mackerras wrote:
>> > +typedef struct {
>> > + =C2=A0 =C2=A0 =C2=A0 long long counter;
>> > +} atomic64_t;
>>
>> lack of volatile seems odd compared to:
>> include/linux/types.h:
>> typedef struct {
>> =C2=A0 =C2=A0 volatile int counter;
>> } atomic_t;
>
> It's only accessed under a spinlock, so I don't think it needs to be
> volatile. =C2=A0On UP it's accessed within local_irq_save/restore which
> should also be compiler barriers and prevent memory access reordering,
> so again volatile isn't needed.

i'm not suggesting it is needed, i'm saying it's a bit confusing.  a
simple comment above the atomic64_t type with your simple explanation
here would go a long way.
-mike
