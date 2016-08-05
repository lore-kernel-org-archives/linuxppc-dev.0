Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5X4j4B9SzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 02:16:53 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so20374916pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 09:16:53 -0700 (PDT)
Date: Sat, 6 Aug 2016 02:16:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luis R.
 Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org, Paul Mackerras
 <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160806021642.5b53b4bf@roar.ozlabs.ibm.com>
In-Reply-To: <2852406.SOgyPXcJfO@wuerfel>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <2038522.anQ279eb8I@wuerfel>
 <20160805222625.30627e96@roar.ozlabs.ibm.com>
 <2852406.SOgyPXcJfO@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 05 Aug 2016 18:01:13 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday, August 5, 2016 10:26:25 PM CEST Nicholas Piggin wrote:
> > On Fri, 05 Aug 2016 12:17:27 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:  
> 
> > > and I also get link errors for the .text.fixup section
> > > for any users of __put_user() in really large kernels:
> > > net/batman-adv/batman-adv.o:(.text.fixup+0x4): relocation truncated to fit: R_ARM_JUMP24 against `.text.batadv_log_read'  
> > 
> > This may be fixed by fixing the linker script to bring in the new
> > sections properly (see new patchset).
> > 
> > If not, then if you can combine the sections rather than have them
> > consecutive in the output, e.g.,:
> > 
> >     *(.text .text.fixup)
> > 
> > Rather than
> > 
> >     *(.text)            
> >     *(.text.fixup)
> > 
> > Then the linker has more freedom to rearrange them. I realize it's
> > not that simple with ARM's .text.fixup, but maybe that helps you
> > get it to work.  
> 
> This did the trick:
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 0ec807d69f18..7a3ad269fa23 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -433,7 +433,7 @@
>   * during second ld run in second ld pass when generating System.map */
>  #define TEXT_TEXT							\
>  		ALIGN_FUNCTION();					\
> -		*(.text.hot .text .text.fixup .text.unlikely)		\
> +		*(.text.hot .text .text.* .text.fixup .text.unlikely)	\
>  		*(.ref.text)						\
>  	MEM_KEEP(init.text)						\
>  	MEM_KEEP(exit.text)						\
> 
> 
> It also got much faster again, the link time for an allyesconfig
> kernel is now 18 minutes instead of 10 hours, but it's still
> much worse than the 2 minutes I had earlier or the four minutes
> with the previous patch.

Are you using the patches I just sent? Either way, you also need
to do the same for data and bss sections as you are using
-fdata-sections too.

I've found virtually no build time regression on powerpc or x86
when those are taken care of properly (x86 numbers I sent are typo,
it's not 5m20, it's 5m02).

Thanks,
Nick
