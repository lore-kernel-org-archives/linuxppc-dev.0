Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59DA5B7BEE
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 06:40:30 +1000 (EST)
Message-ID: <4BDB402C.9080301@freescale.com>
Date: Fri, 30 Apr 2010 15:40:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
	<s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
	<20100430121947.1d265ca6@wker>
	<x2ned82fe3e1004300808q757826cs864ac1c7c082f81@mail.gmail.com>
	<20100430162254.GA24285@schlenkerla.am.freescale.net>
	<r2sed82fe3e1004301118xc52b46cfi879de534283fd51@mail.gmail.com>
In-Reply-To: <r2sed82fe3e1004301118xc52b46cfi879de534283fd51@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	John Rigby <jrigby@gmail.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> On Fri, Apr 30, 2010 at 11:22 AM, Scott Wood <scottwood@freescale.com> wrote:
> 
>>> That's what I meant.  Actually, I think it's ULL.  Regardless, I think
>>> the compiler will see the  "1000000000 ... * 1000" and just combine
>>> them together.  You're not actually outsmarting the compiler.
>> The compiler will do no such thing.  That's a valid transformation when
>> doing pure math, but not when working with integers.
> 
> I ran some tests, and it appears you're right.  I doesn't make a lot
> of sense to me, but whatever.
> 
> However, "(1000000000 / pixclock) * 1000" produces a result that's
> less accurate than "1000000000000ULL / pixclock".

Precisely, that's what makes it a distinct computation -- as far as the 
compiler knows, it could be intentional.  Plus, turning it into 64-bit 
math would invoke a library call for 64-bit division, which wouldn't be 
much of an optimization anyway.

The question is whether the loss of accuracy matters in this case.

>>>     err = -1;
>>>
>>> because he wanted it to be the largest possible integer.
>> -1 is not the largest possible integer.  LONG_MAX, perhaps?
> 
> What, you don't like implicit casting of -1 to an unsigned? :-)

I like it even less when the variable is signed and it's still supposed 
to be larger than positive numbers. :-)

-Scott
