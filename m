Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f209.google.com (mail-ew0-f209.google.com
	[209.85.219.209]) by ozlabs.org (Postfix) with ESMTP id 77FB7B7D32
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 18:32:56 +1100 (EST)
Received: by mail-ew0-f209.google.com with SMTP id 1so3689627ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Dec 2009 23:32:55 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] asm/gpio.h: support gpio_to_irq()
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
	<1259700494-17869-2-git-send-email-jacmet@sunsite.dk>
Date: Wed, 09 Dec 2009 08:32:54 +0100
In-Reply-To: <1259700494-17869-2-git-send-email-jacmet@sunsite.dk> (Peter
	Korsgaard's message of "Tue, 1 Dec 2009 21:48:13 +0100")
Message-ID: <87tyw0mwk9.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

 Peter> gpiolib returns -ENXIO if struct gpio_chip::to_irq isn't set, so it's
 Peter> safe to always call.

Comments?

 Peter> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
 Peter> ---
 Peter>  arch/powerpc/include/asm/gpio.h |    5 +----
 Peter>  1 files changed, 1 insertions(+), 4 deletions(-)

 Peter> diff --git a/arch/powerpc/include/asm/gpio.h b/arch/powerpc/include/asm/gpio.h
 Peter> index ea04632..38762ed 100644
 Peter> --- a/arch/powerpc/include/asm/gpio.h
 Peter> +++ b/arch/powerpc/include/asm/gpio.h
 Peter> @@ -38,12 +38,9 @@ static inline int gpio_cansleep(unsigned int gpio)
 Peter>  	return __gpio_cansleep(gpio);
 Peter>  }
 
 Peter> -/*
 Peter> - * Not implemented, yet.
 Peter> - */
 Peter>  static inline int gpio_to_irq(unsigned int gpio)
 Peter>  {
 Peter> -	return -ENOSYS;
 Peter> +	return __gpio_to_irq(gpio);
 Peter>  }
 
 Peter>  static inline int irq_to_gpio(unsigned int irq)
 Peter> -- 
 Peter> 1.6.5


-- 
Bye, Peter Korsgaard
