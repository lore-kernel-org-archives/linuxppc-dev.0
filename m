Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3267D474C2
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 03:45:42 +1100 (EST)
Date: Fri, 24 Oct 2008 20:45:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Ocker <weo@reccoware.de>
Subject: Re: [PATCH] powerpc: Specify GPIO number base for controller in DT
Message-ID: <20081024164540.GB14350@oksana.dev.rtsoft.ru>
References: <1224764850.4082.54.camel@galileo.recco.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1224764850.4082.54.camel@galileo.recco.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 02:27:30PM +0200, Wolfgang Ocker wrote:
> The GPIOLIB allows the specification of a base gpio number for a
> controller. That is not possible using OF. Instead, free gpio numbers
> are assigned.
> 
> In order to allow static, predefined gpio numbers, a base property in
> the gpio controller node specifies the first gpio number.
> 
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>

[...]
> --- linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt.spi_gpio_doc	2008-09-29 14:14:08.000000000 +0200
> +++ linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt	2008-09-29 14:24:26.000000000 +0200
> @@ -2586,6 +2588,7 @@
>  		#gpio-cells = <2>;
>  		compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
>  		reg = <0x1400 0x18>;
> +		base = < 0x20 >;

The base has nothing to do with the hardware description, thus
device tree should not include it. Why exactly you need this?
I'm sure there is another way to solve the problem (whatever it
is).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
