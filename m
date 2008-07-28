Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B40EDDF12
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 22:54:32 +1000 (EST)
Message-Id: <A87B5E3B-45CE-4EED-B998-41DE34119F99@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080611230431.GC21351@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 3/4] powerpc: rtc_cmos_setup: assign interrupts only if
	there is i8259 PIC
Date: Mon, 28 Jul 2008 07:54:27 -0500
References: <20080611230250.GA13412@polina.dev.rtsoft.ru>
	<20080611230431.GC21351@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 11, 2008, at 6:04 PM, Anton Vorontsov wrote:

> i8259 PIC is disabled on MPC8610HPCD boards, thus currently rtc-cmos
> driver fails to probe.
>
> To fix the issue, we lookup the device tree for "chrp,iic" and
> "pnpPNP,000" compatible devices, and if not found we do not assign RTC
> IRQ and assuming that i8259 was disabled.
>
> Though this patch fixes RTC on some boards (and surely should not  
> break
> any other), the whole approach is still broken. We can't easily fix  
> this
> though, because old device trees do not specify i8259 interrupts for  
> the
> cmos rtc node.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/rtc_cmos_setup.c |   23 +++++++++++++++++------
> 1 files changed, 17 insertions(+), 6 deletions(-)

applied.

- k
