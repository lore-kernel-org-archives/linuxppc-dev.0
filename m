Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E4541A0B9A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:10:56 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regressions/improvements in v4.0-rc3
Date: Mon, 09 Mar 2015 15:10:49 +0100
Message-ID: <4677994.NrntHOKO7A@wuerfel>
In-Reply-To: <CAMuHMdVNWVKA0iuTMABQPzJJtjCAD_Ey7w1gx2ojYzG4TscyKA@mail.gmail.com>
References: <1425898222-19721-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVNWVKA0iuTMABQPzJJtjCAD_Ey7w1gx2ojYzG4TscyKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 09 March 2015 11:56:22 Geert Uytterhoeven wrote:
> On Mon, Mar 9, 2015 at 11:50 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v4.0-rc3[1] to v4.0-rc2[3], the summaries are:
> >   - build errors: +18/-7
> 
>   + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error:
> 'SMC91X_NOWAIT' undeclared here (not in a function):  => 85:47
>   + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error:
> 'SMC91X_USE_32BIT' undeclared here (not in a function):  => 85:11
>   + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error:
> 'SMC91X_USE_DMA' undeclared here (not in a function):  => 85:30
>   + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error: unknown
> field 'flags' specified in initializer:  => 85:2
>   + /home/kisskb/slave/src/arch/arm/mach-pxa/idp.c: error: variable
> 'smc91x_platdata' has initializer but incomplete type:  => 84:15
> 
> pxa255-idp_defconfig
> 
>   + /home/kisskb/slave/src/arch/arm/mach-pxa/lpd270.c: error: expected
> '}' before ';' token:  => 198:43
> 
> lpd270_defconfig
> 
>   + /home/kisskb/slave/src/arch/arm/mach-sa1100/neponset.c: error:
> 'smc91c_platdata' undeclared (first use in this function):  => 271:12
> 
> neponset_defconfig
> 
>   + /home/kisskb/slave/src/arch/arm/mach-sa1100/pleb.c: error:
> 'smc91c_platdata' undeclared here (not in a function):  => 57:22
> 
> pleb_defconfig
> 
>   + /home/kisskb/slave/src/drivers/net/ethernet/smsc/smc91x.c: error:
> implicit declaration of function 'machine_has_neponset'
> [-Werror=implicit-function-declaration]:  => 2363:2
> 
> neponset_defconfig
> 
> smc91x fallout. The lpd270_defconfig failure looks like not covered by
> "ARM: fix typos in smc91x platform data" yet?

It's not?

This should be part of that patch:

--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -195,7 +195,7 @@ static struct resource smc91x_resources[] = {
 };
 
 struct smc91x_platdata smc91x_platdata = {
-       .flags = SMC91X_USE_16BIT | SMC91X_NOWAIT;
+       .flags = SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
 
 static struct platform_device smc91x_device = {

and I thought I had tested all defconfigs as well as hundreds of randconfigs
(the right ones) successfully this time.


	Arnd
