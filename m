Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id B7C7FB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 02:55:16 +1000 (EST)
Received: by ewy21 with SMTP id 21so236070ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 08 Jul 2010 09:55:13 -0700 (PDT)
Date: Thu, 8 Jul 2010 20:55:09 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.34: arch/powerpc/sysdev/micropatch.c not compiling
Message-ID: <20100708165509.GA15181@oksana.dev.rtsoft.ru>
References: <4C318D87.1010306@c-s.fr>
 <20100706000343.GE23985@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100706000343.GE23985@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 06, 2010 at 10:03:43AM +1000, Tony Breeds wrote:
> On Mon, Jul 05, 2010 at 09:45:11AM +0200, LEROY Christophe wrote:
> > When activating micropatch option, the kernel does not compile.
> 
> powerpc problems should alos CC linuxppc-dev.
>  
> > It looks like a spi_t is not defined anywhere.
> > 
> > CC arch/powerpc/sysdev/micropatch.o
> > arch/powerpc/sysdev/micropatch.c: In function ‘cpm_load_patch’:
> > arch/powerpc/sysdev/micropatch.c:629: erreur: expected ‘=’, ‘,’,
> > ‘;’, ‘asm’ or ‘__attribute__’ before ‘*’ token
[...]
> -       spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
> -       spp->spi_rpbase = i;
> +       smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SPI];
> +       smp->smc_rpbase = i;
>  
>  # if defined(CONFIG_I2C_SPI_UCODE_PATCH)
>         commproc->cp_cpmcr1 = 0x802a;
> 
> 
> Would help?

While this will fix the issue, I think this is not technically
correct (i.e. micropatching SPI controller via I2C pram struct,
even though the structs appear to be identical).

As the spi_param is needed outside of the SPI driver, we'd
better re-introduce the struct, I think.

I'll send some fixes for this and other issues in this file.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
