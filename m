Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 051E8B70A4
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 16:45:26 +1000 (EST)
Received: by eyh6 with SMTP id 6so2102916eyh.15
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 23:45:24 -0700 (PDT)
Date: Fri, 30 Jul 2010 10:45:21 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: Which microcode patch for MPC870?
Message-ID: <20100730064521.GA20351@oksana.dev.rtsoft.ru>
References: <AANLkTimBP98EwRuvU_dj-RM2kaXZ-FSZ=GQxdod9VQeU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTimBP98EwRuvU_dj-RM2kaXZ-FSZ=GQxdod9VQeU@mail.gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Jul 29, 2010 at 11:40:21PM -0700, Shawn Jin wrote:
> Hi,
> 
> Which microcode patch should be selected for MPC870? In the old 2.4
> kernel, the CONFIG_UCODE_PATCH was selected. What's the corresponding
> config: CONFIG_USB_SOF_UCODE_PATCH or CONFIG_I2C_SPI_UCODE_PATCH or
> CONFIG_I2C_SPI_SMC1_UCODE_PATCH? Since my board doesn't have USB, I
> believe USB microcode is irrelevant here. So it comes down the other
> two choices. Of course do I really need the patch? My board has I2C
> and SMC1, but no SPI.
> 
> I chose CONFIG_I2C_SPI_UCODE_PATCH as an experiment but got the
> following compilation error:

These errors were fixed by

http://patchwork.ozlabs.org/patch/58262/
and
http://patchwork.ozlabs.org/patch/58263/

Thanks,

>   CC      arch/powerpc/sysdev/micropatch.o
> arch/powerpc/sysdev/micropatch.c: In function 'cpm_load_patch':
> arch/powerpc/sysdev/micropatch.c:629: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before '*' token
> arch/powerpc/sysdev/micropatch.c:629: error: 'spp' undeclared (first
> use in this function)
> arch/powerpc/sysdev/micropatch.c:629: error: (Each undeclared
> identifier is reported only once
> arch/powerpc/sysdev/micropatch.c:629: error: for each function it appears in.)
> cc1: warnings being treated as errors
> arch/powerpc/sysdev/micropatch.c:630: warning: ISO C90 forbids mixed
> declarations and code
> arch/powerpc/sysdev/micropatch.c:671: error: 'spi_t' undeclared (first
> use in this function)
> arch/powerpc/sysdev/micropatch.c:671: error: expected expression
> before ')' token
> arch/powerpc/sysdev/micropatch.c:630: warning: unused variable 'smp'
> make[1]: *** [arch/powerpc/sysdev/micropatch.o] Error 1
> 
> Obviously there is no spi_t declaration in 2.6.33.5. So where is this
> spi_t declared?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
