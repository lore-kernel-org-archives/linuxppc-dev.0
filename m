Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8BA52DDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 09:26:09 +1100 (EST)
Message-ID: <474DEAF7.6000301@am.sony.com>
Date: Wed, 28 Nov 2007 14:25:59 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 3/7] ps3: Use the HVs storage device notification mechanism
	properly
References: <20071128143142.580732000@pademelon.sonytel.be>
	<20071128143438.302492000@pademelon.sonytel.be>
In-Reply-To: <20071128143438.302492000@pademelon.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:

> ps3: Use the HV's storage device notification mechanism properly
> 
> The hypervisor has a storage device notification mechanism to wait until a
> storage device is ready. Unfortunately the storage device probing code used
> this mechanism in an incorrect way, needing a polling loop and handling of
> devices that are not yet ready.
> 
> This change corrects this by:
>   - First waiting for the reception of an asynchronous notification that a new
>     storage device became ready,
>   - Then looking up the storage device in the device repository.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/platforms/ps3/device-init.c |  395 +++++++++++++++----------------
>  arch/powerpc/platforms/ps3/platform.h    |    2 
>  arch/powerpc/platforms/ps3/repository.c  |   29 --
>  3 files changed, 194 insertions(+), 232 deletions(-)

Let's hope this is the end of the storage device notification saga!

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
