Return-Path: <shuah.khan@hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C60902C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 11:05:08 +1100 (EST)
Message-ID: <1355270698.2616.44.camel@lorien2>
Subject: Re: [PATCH v2] powerpc: fix wii_memory_fixups() compile error on
 3.0.y tree
From: Shuah Khan <shuah.khan@hp.com>
To: Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 11 Dec 2012 17:04:58 -0700
In-Reply-To: <20121210185527.GI13292@decadent.org.uk>
References: <1354932445.7407.15.camel@lorien2>
 <1354987359.20838.67.camel@deadeye.wl.decadent.org.uk>
 <CAKocOOPYv0L5dnVJ-jcKw6u3Axbe-tFRdz+F8FvE6fq-xRQH5A@mail.gmail.com>
 <1355160196.2739.12.camel@lorien2> <20121210185527.GI13292@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Greg KH <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>,
 paulus@samba.org, shuahkhan@gmail.com, linuxppc-dev@lists.ozlabs.org
Reply-To: shuah.khan@hp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-12-10 at 18:55 +0000, Ben Hutchings wrote:
> On Mon, Dec 10, 2012 at 10:23:16AM -0700, Shuah Khan wrote:
> > Fix wii_memory_fixups() the following compile error on 3.0.y tree with 
> > wii_defconfig on 3.0.y tree.
> > 
> >   CC      arch/powerpc/platforms/embedded6xx/wii.o
> > arch/powerpc/platforms/embedded6xx/wii.c: In function ‘wii_memory_fixups’:
> > arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘phys_addr_t’ [-Werror=format]
> > arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘phys_addr_t’ [-Werror=format]
> > arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘phys_addr_t’ [-Werror=format]
> > arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘phys_addr_t’ [-Werror=format]
> > cc1: all warnings being treated as errors
> > make[2]: *** [arch/powerpc/platforms/embedded6xx/wii.o] Error 1
> > make[1]: *** [arch/powerpc/platforms/embedded6xx] Error 2
> > make: *** [arch/powerpc/platforms] Error 2
> > 
> > Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> > CC: stable@vger.kernel.org 3.0.y
> > ---
> >  arch/powerpc/platforms/embedded6xx/wii.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
> > index 1b5dc1a..d8ff38f 100644
> > --- a/arch/powerpc/platforms/embedded6xx/wii.c
> > +++ b/arch/powerpc/platforms/embedded6xx/wii.c
> > @@ -85,9 +85,11 @@ void __init wii_memory_fixups(void)
> >  	wii_hole_start = p[0].base + p[0].size;
> >  	wii_hole_size = p[1].base - wii_hole_start;
> >  
> > -	pr_info("MEM1: <%08llx %08llx>\n", p[0].base, p[0].size);
> > +	pr_info("MEM1: <%08ulx %08ulx>\n",
> > +		(phys_addr_t) p[0].base, (phys_addr_t) p[0].size);
> [...]
> 
> This is incorrect in exactly the same way as the last version,
> but with extra redundant casts.
> 

Yes it is. :) That is embarrassing. The lesson is "don't try to work
when not feeling well", at least that is my excuse.

Thanks for catching it. I will really fix it this time and send a new
patch. This bug is in there since Dec 2009, not sure if this is worth
fixing, but might as well.

de32400dd26e743c5d500aa42d8d6818b79edb73
wii: use both mem1 and mem2 as ram

-- Shuah
