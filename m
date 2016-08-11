Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s97jg1FCyzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 23:12:54 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id cf3so197491pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 06:12:54 -0700 (PDT)
Date: Thu, 11 Aug 2016 23:12:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Segher Boessenkool
 <segher@kernel.crashing.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luis R.
 Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org, Paul Mackerras
 <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>, Guenter Roeck
 <linux@roeck-us.net>, Alan Modra <amodra@gmail.com>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160811231240.4ba73123@roar.ozlabs.ibm.com>
In-Reply-To: <6327068.NbTmhQA6XD@wuerfel>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <6481373.xtk4H4bKaE@wuerfel>
 <20160811224320.52950a5c@roar.ozlabs.ibm.com>
 <6327068.NbTmhQA6XD@wuerfel>
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

On Thu, 11 Aug 2016 15:04:00 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday, August 11, 2016 10:43:20 PM CEST Nicholas Piggin wrote:
> > On Wed, 03 Aug 2016 22:13:28 +0200

> > Final ld time
> > inclink
> > real	0m0.378s
> > user	0m0.304s
> > sys	0m0.076s
> > 
> > thinarc
> > real    0m0.894s
> > user    0m0.684s
> > sys     0m0.200s  
> 
> This also still seems fine.
> 
> > For both cases final link gets slower with thin archives. I guess there is some
> > per-file overhead but I thought with --whole-archive it should not be that much
> > slower. Still, overall time for main ar/ld phases comes out about the same in
> > the end so I don't think it's too much problem. Unless ARM blows up significantly
> > worse with a bigger config.  
> 
> Unfortunately I think it does. I haven't tried your latest series yet,
> but I think the total time for removing built-in.o and relinking went
> up from around 4 minutes (already way too much) to 18 minutes for me.
> 
> > Linking with thin archives takes significantly more time in bfd hash lookup code.
> > I haven't dug much further yet.  
> 
> Can you try the ARM allyesconfig with thin archives? I'll follow up with two
> patches: one to get ARM to link without thin archives, and one that I used
> to get --gc-sections to work.

Okay send them over, I'll try digging into it. There is not much kbuild
code to maintain so we don't have to switch every arch. It would be nice
to though.

Thanks,
Nick
