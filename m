Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Qyz5phtzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 22:26:35 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g202so20143275pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 05:26:35 -0700 (PDT)
Date: Fri, 5 Aug 2016 22:26:25 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luis R.
 Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org, Paul Mackerras
 <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160805222625.30627e96@roar.ozlabs.ibm.com>
In-Reply-To: <2038522.anQ279eb8I@wuerfel>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <20160804170640.GC22744@gate.crashing.org>
 <20160805184108.7fc3dbd0@roar.ozlabs.ibm.com>
 <2038522.anQ279eb8I@wuerfel>
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

On Fri, 05 Aug 2016 12:17:27 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday, August 5, 2016 6:41:08 PM CEST Nicholas Piggin wrote:
> > On Thu, 4 Aug 2016 12:06:41 -0500
> > Segher Boessenkool <segher@kernel.crashing.org> wrote:
> >   
> > > On Thu, Aug 04, 2016 at 06:10:57PM +0200, Arnd Bergmann wrote:  
> > > > On Thursday, August 4, 2016 9:47:13 PM CEST Nicholas Piggin wrote:
> > > >     
> > > > > +	__used							\
> > > > > +	__attribute__((section("___kentry" "+" #sym ",\"a\",@note #"), used)) \    
> > > > 
> > > > 
> > > > I've just started testing this, but the first problem I ran into
> > > > is that @ and # are special characters that have an architecture
> > > > specific meaning to the assembler. On ARM, you need "%note @" instead
> > > > of "@note #".    
> > > 
> > > That comment trick (I still feel guilty about it) causes more problems
> > > than it solves.  Please don't try to use it :-)  
> > 
> > Yeah that's a funny hack. I don't think it's required though, but I'm just
> > running through some more tests.
> > 
> > I think I found an improvement with the thin archives as well -- we were
> > still building symbol table after removing the s option (that only avoids
> > index). "S" is required to not build symbol table.
> > 
> > I'll send out an RFC on a slightly more polished patch series shortly.  
> 
> 
> I could not find Nico's patches, but based on the information in his
> presentation at
> 
> https://www.linuxplumbersconf.org/2015/ocw//system/presentations/3369/original/slides.html#(1)
> 
> I created a patch for ARM that mirrors what you have for powerpc, see
> below.

Great, thanks for jumping in. I posted another set which is a lot improved
you should pick up.


> I have successfully built normal-sized kernels with this (not tried
> running them). Unfortunately, the build time for "allyesconfig"
> kernel explodes, the final link time is now in the hours instead of
> minutes (no exact numbers unfortunately, it takes too long to
> reproduce),

That's becase we need to coalesce the new sections properly into the
output file. binutils does not cope with vast number of sections in
final linked file and spends all its time in hash lookup then explodes
usually.


> and I also get link errors for the .text.fixup section
> for any users of __put_user() in really large kernels:
> net/batman-adv/batman-adv.o:(.text.fixup+0x4): relocation truncated to fit: R_ARM_JUMP24 against `.text.batadv_log_read'

This may be fixed by fixing the linker script to bring in the new
sections properly (see new patchset).

If not, then if you can combine the sections rather than have them
consecutive in the output, e.g.,:

    *(.text .text.fixup)

Rather than

    *(.text)            
    *(.text.fixup)

Then the linker has more freedom to rearrange them. I realize it's
not that simple with ARM's .text.fixup, but maybe that helps you
get it to work.

Thanks,
Nick
