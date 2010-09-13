Return-Path: <dedekind1@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id D814FB6F01
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 02:45:26 +1000 (EST)
Received: by bwz7 with SMTP id 7so7064016bwz.15
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 09:45:24 -0700 (PDT)
Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue
	with 36bit mode
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Timur Tabi <timur.tabi@gmail.com>
In-Reply-To: <AANLkTinyELs7KNDQxWsaR8Ea13SewWYwgtnie_P7cAzC@mail.gmail.com>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
	<20100909114153.GB6622@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC158@zch01exm23.fsl.freescale.net>
	<AANLkTimfKwdw+nLAjDjxf52dbZKLF-3aES+bT7CHskAS@mail.gmail.com>
	<1284388075.10955.51.camel@localhost>
	<AANLkTinyELs7KNDQxWsaR8Ea13SewWYwgtnie_P7cAzC@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 13 Sep 2010 19:45:20 +0300
Message-ID: <1284396320.1783.30.camel@brekeke>
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-09-13 at 09:35 -0500, Timur Tabi wrote:
> On Mon, Sep 13, 2010 at 9:27 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> 
> > Yes, sizeof(int) == 4 assumption is not good.
> >
> > But sizeof(int) >= 4 is perfectly fine.
> 
> I have to disagree.   I don't see how you can say that == is not okay,
> but >= is okay.

If I assume that int == 4, which is true for all platform ATM, and will
most probably stay true for very long time, I still make an unnecessary
assumption which C99 does not guarantee. This is just not very clean. So
for things which require exactly 32 bits, u32 or C99 uint32_t should be
used.

On the other hand, if a have a local variable "var" which needs to store
values which I know will always fit 32 bits, and I do not use it in
operations (I/O, etc) which require exactly 32 bits, it is better to use
unsigned int for it. Unsigned int is reliably >= 4 in Linux.

This is wat I meant that sizeof(int) >= 4 is perfectly fine. One
everywhere, of course, but in many cases.

To put it differently, if there is no special reason to limit the
variable by exactly 32 bits, it is better to use int.

-- 
Best Regards,
Artem Bityutskiy (Битюцкий Артём)
