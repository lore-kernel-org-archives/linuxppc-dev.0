Return-Path: <jwboyer@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35DB9B7117
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Feb 2011 22:26:37 +1100 (EST)
Received: by wyi11 with SMTP id 11so1188603wyi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Feb 2011 03:26:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTimW1yZ+H=X+j=TYMM8-zZx5XaEPczek05KtKKxN@mail.gmail.com>
References: <AANLkTimW1yZ+H=X+j=TYMM8-zZx5XaEPczek05KtKKxN@mail.gmail.com>
Date: Wed, 16 Feb 2011 06:26:30 -0500
Message-ID: <AANLkTinD1S_tdjbjsLi4oL=K9HH0cvdBf0PGpUVWLsKF@mail.gmail.com>
Subject: Re: Question about flash allocation
From: Josh Boyer <jwboyer@gmail.com>
To: Mitsutaka Amano <mitsutaka.amano@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 15, 2011 at 11:28 PM, Mitsutaka Amano
<mitsutaka.amano@gmail.com> wrote:
> Hi,
>
> Why does CFI(or other flash memory) have to alloc amount of flash
> memory size to the vmalloc area(such as PHYSMAP or PHYSMAP_OF)?
> I wondered other devices seems to not allocating(e.g, most NAND flash,
> flash on ARM, MIPS and so on). I don't know difference between my
> board and other. Doesn't other devices need to allocate to vmalloc?

You asked this on the MTD mailing list already:

http://lists.infradead.org/pipermail/linux-mtd/2011-January/033787.html

The answers aren't going to change based on which list you ask.

As for the last question, the memory space for modules are in vmalloc
space, and any HW resources they ioremap are as well.  However for
true memory allocations, most device drivers use kmalloc.  Some use
vmalloc for large buffers that don't need to be physically contiguous
but there aren't that many.

josh
