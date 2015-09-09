Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85E801A2513
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 15:48:01 +1000 (AEST)
Message-ID: <1441777680.23373.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Kconfig: remove BE-only platforms from LE
 kernel build
From: Michael Ellerman <mpe@ellerman.id.au>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Olof
 Johansson <olof@lixom.net>, Geoff Levand <geoff@infradead.org>
Date: Wed, 09 Sep 2015 15:48:00 +1000
In-Reply-To: <20150909032548.GA18626@fixme-laptop.cn.ibm.com>
References: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
 <1441765604.7854.6.camel@ellerman.id.au>
 <20150909032548.GA18626@fixme-laptop.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-09 at 11:25 +0800, Boqun Feng wrote:
> Hi Michael,
> 
> On Wed, Sep 09, 2015 at 12:26:44PM +1000, Michael Ellerman wrote:
> > On Mon, 2015-09-07 at 07:58 +0800, Boqun Feng wrote:
> > > diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
> > > index 2f23133..808a904 100644
> > > --- a/arch/powerpc/platforms/cell/Kconfig
> > > +++ b/arch/powerpc/platforms/cell/Kconfig
> > > @@ -25,7 +25,7 @@ config PPC_CELL_NATIVE
> > >  
> > >  config PPC_IBM_CELL_BLADE
> > >  	bool "IBM Cell Blade"
> > > -	depends on PPC64 && PPC_BOOK3S
> > > +	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
> > 
> > We end up saying this five times.
> > 
> > We already have PPC_BOOK3S_64 which captures the first two conditions, should
> > we add a PPC_BOOK3S_64_BE which expresses it all?
> 
> I'm not sure whether this is worth.. IMO, we add a config option only if
> 
> 1.	we can use this config somewhere in the code, for example,
> 	"#ifdef CONFIG_XXX"
> or
> 
> 2.	we want to offer a option for users to choose.
>
> PPC_BOOK3S_64_BE satisfies neither condition. Further more,
> CONFIG_PPC64, CONFIG_PPC_BOOK3S and CONFIG_CPU_BIG_ENDIAN all are used
> in some #ifdefs in current code. As a newbie of kernel, I'm happy to get
> some knowledge like: "If I'm hacking PS3, then #ifndef CONFIG_PPC64 is
> guaranteed to be false, so I can just ignore the code guarded by them".
> But if we add a PPC_BOOK3S_64_BE, it will take a little more effort to
> see this.

Yeah those are good points, so I'll take it as is. Thanks for thinking about it :)

cheers
