Return-Path: <dedekind1@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id A6D24B6F10
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 00:29:36 +1000 (EST)
Received: by fxm14 with SMTP id 14so3656836fxm.15
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 07:29:34 -0700 (PDT)
Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue
	with 36bit mode
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Timur Tabi <timur.tabi@gmail.com>
In-Reply-To: <AANLkTimfKwdw+nLAjDjxf52dbZKLF-3aES+bT7CHskAS@mail.gmail.com>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
	<20100909114153.GB6622@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC158@zch01exm23.fsl.freescale.net>
	<AANLkTimfKwdw+nLAjDjxf52dbZKLF-3aES+bT7CHskAS@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 13 Sep 2010 17:27:55 +0300
Message-ID: <1284388075.10955.51.camel@localhost>
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

On Mon, 2010-09-13 at 09:10 -0500, Timur Tabi wrote:
> On Mon, Sep 13, 2010 at 2:30 AM, Zang Roy-R61911 <r61911@freescale.com> wrote:
> 
> > What is the different for unsigned int and u32? I think they are same.
> 
> Roy, please don't ever write code that assumes that sizeof(int) == 4.
> There's a reason why we have unsized integer types (like int, long,
> and short) and sized integer types (like u8, u16, u32).  If you want
> an integer of a specific size, you should use a sized integer type.

Yes, sizeof(int) == 4 assumption is not good.

But sizeof(int) >= 4 is perfectly fine.

It is OK to rely on the fact that unsigned int is _at least_ 32-bit, not
less. And if you know 32 bits is enough, and you are fine with more, it
is _better_ to avoid u32. Simply because with unsigned int you do not
limit the compiler and CPU and let them use native integers, rather than
strictly 32-bit. This potentially gives the compiler and CPU more room
for optimization.

I see people use u32 and the friends too much. It is safe and better to
use native types, unless you really have to make the variable to be
strictly u32.

I did not follow this particular conversation and do not judge which
type is better in this case. I am talking in general. :-)

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
