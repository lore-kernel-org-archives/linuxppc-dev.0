Return-Path: <avorontsov@ru.mvista.com>
Date: Thu, 24 Jul 2008 16:08:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Getting GPIO to build again
Message-ID: <20080724120839.GA24673@polina.dev.rtsoft.ru>
References: <9e4733910807232009o634027cajde78395f95ae95ce@mail.gmail.com>
	<9e4733910807232034x3af76073x979ef608ddfbebfb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <9e4733910807232034x3af76073x979ef608ddfbebfb@mail.gmail.com>
Cc: ppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 23, 2008 at 11:34:28PM -0400, Jon Smirl wrote:
> This lets me build again, no clue if it is the correct fix.

No, I don't think that this is correct. OF_GPIO isn't GENERIC_GPIO
provider. GPIO controllers should select GENERIC_GPIO instead.

Though, with this patch:
http://lkml.org/lkml/2008/7/10/269

We'll only have to select ARCH_WANT_OPTIONAL_GPIOLIB. Maybe for whole
powerpc.

> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 3a7a11a..e14dbe3 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -3,6 +3,7 @@ config OF_DEVICE
>         depends on OF && (SPARC || PPC_OF)
> 
>  config OF_GPIO
> +       select GENERIC_GPIO
>         def_bool y
>         depends on OF && PPC_OF && HAVE_GPIO_LIB
>         help
> 

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
