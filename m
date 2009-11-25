Return-Path: <pku.leo@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id 67FD4B6F0A
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 19:07:47 +1100 (EST)
Received: by pwi6 with SMTP id 6so4840974pwi.9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 00:07:46 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <DFC7BA62-6CF0-4A08-8DD1-11825A638262@kernel.crashing.org>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
	<1258707833.2140.865.camel@pasglop>
	<2a27d3730911200123i23fa6dd1td9e19944d1737e73@mail.gmail.com>
	<DFC7BA62-6CF0-4A08-8DD1-11825A638262@kernel.crashing.org>
Date: Wed, 25 Nov 2009 16:07:46 +0800
Message-ID: <2a27d3730911250007s62f31673p3358631996e8a451@mail.gmail.com>
Subject: Re: [RFC] powerpc/mm: honor O_SYNC flag for memory map
From: Li Yang <leoli@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
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

On Sun, Nov 22, 2009 at 4:01 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>>> You need to be a bit more careful tho. You must not allow RAM managed b=
y
>>> the kernel to be mapped non-cachable.
>>
>> Even if the user explicitly sets the O_SYNC flag? =C2=A0IMHO, it's a bug=
 of
>> the application if it uses O_SYNC on main memory to be mmap'ed later.
>> And we don't need to cover up the bug.
>
> Is that "embedded thinking"? =C2=A0Conflicts like this cause machine chec=
ks or
> checkstops on many PowerPC implementations, we do not normally allow such
> to be caused by userland.

So what you are saying is that if the kernel has mapped a physical
page as cacheable while user application is trying to map it as
non-cacheable, there will be machine checks and checkstops rather than
just performance drop?  This is new to me.  Could you elaborate a bit?
 Thanks.

- Leo
