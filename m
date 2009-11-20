Return-Path: <pku.leo@gmail.com>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id AC0F4B6EF4
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 20:23:26 +1100 (EST)
Received: by pxi7 with SMTP id 7so811956pxi.17
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 01:23:25 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1258707833.2140.865.camel@pasglop>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
	<1258707833.2140.865.camel@pasglop>
Date: Fri, 20 Nov 2009 17:23:25 +0800
Message-ID: <2a27d3730911200123i23fa6dd1td9e19944d1737e73@mail.gmail.com>
Subject: Re: [RFC] powerpc/mm: honor O_SYNC flag for memory map
From: Li Yang <leoli@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 20, 2009 at 5:03 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2009-11-20 at 11:00 +0800, Li Yang-R58472 wrote:
>> Because there is no way to set mapped memory as cacheable if the
>> memory
>> is not managed by Linux kernel. =C2=A0While, it's not rare in real syste=
m
>> to
>> allocate some dedicated memory to a certain application which is not
>> managed by kernel and then mmap'ed the memory to the application. =C2=A0=
The
>> memory should be cacheable but we can't map it to be cacheable due to
>> this intelligent setting. =C2=A0And it is a big hit to the performance.
>> Moreover, the standard O_SYNC flag suggest that user has the control
>> over cacheablity, but actually we had not.
>
> You need to be a bit more careful tho. You must not allow RAM managed by
> the kernel to be mapped non-cachable.

Even if the user explicitly sets the O_SYNC flag?  IMHO, it's a bug of
the application if it uses O_SYNC on main memory to be mmap'ed later.
And we don't need to cover up the bug.

- Leo
