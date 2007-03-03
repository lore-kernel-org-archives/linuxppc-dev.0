Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 70358DDF77
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 18:33:39 +1100 (EST)
Date: Sat, 3 Mar 2007 08:33:36 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH 0/7] MPC5200 and Lite5200b low power modes
Message-ID: <20070303073336.GC3276@nd47.coderock.org>
References: <20070301075323.GP4397@moe.telargo.com>
	<45E89887.1070604@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45E89887.1070604@246tNt.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 02/03/07 22:35 +0100, Sylvain Munaut wrote:
> Hi,
> 
> Thanks for providing theses.
> I hadn't a chance to test them yet, I'll try that this week end. A
> couple of comments already though :
> 
>  - Is saving the SDMA / PIC registers necessary ? Doesn't the cpu keep
> those when at sleep ?

For deep-sleep this is true, but not for low-power mode (the CPU
isn't even powered in that case).

>  - And if it is, won't a memcpy_io of the whole zone do the trick ?

Oh, nice. I wasn't aware of _memcpy_{to,from}io. I'll try it.

>  - On a more general note, there seem to be a lot of stuff decided by
> #ifdef ... that's not really good as we can build a single kernel that
> could run on several platform so those need to somehow be enable
> disabled dynamically.

CONFIG_PM - well... it doesn't make sense too keep the code if
	power management is disabled.
SELF_REFRESH, TESTING - both are provided for debugging, final
	version is former on, latter off.

>  - I may miss something but turning port power off for USB seem like a
> sane thing to do for every one. Isn't that implemented somehow for all
> controller somewhere ?

The "USB power led" on lite5200b says it isn't.

Thanks!


	Domen
