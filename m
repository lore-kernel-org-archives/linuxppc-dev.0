Return-Path: <kenneth@southpole.se>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 0DFA3B7BF7
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 22:41:05 +1100 (EST)
Subject: Re: Acceleration for map_copy_from on powerpc 512x
From: Kenneth Johansson <kenneth@southpole.se>
To: Fortini Matteo <matteo.fortini@mta.it>
In-Reply-To: <4AE6C51F.9050203@mta.it>
References: <4ADC1AAD.60606@mta.it> <1256135453.22238.27.camel@kenjo-laptop>
	<4AE6C51F.9050203@mta.it>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Oct 2009 12:41:01 +0100
Message-Id: <1256643661.29725.74.camel@kenjo-laptop>
Mime-Version: 1.0
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-27 at 11:02 +0100, Fortini Matteo wrote:
> The simple_map_init() works at a higher level, what I'm redefining is a 
> function called by mtd->read()

not sure I follow. What you want to do is change the access to the
flash. You do this by turning on MTD_COMPLEX_MAPPINGS and then setting
up the function pointers like is done in simple_map_init() but point to
your own functions. Now every access to the NOR flash will be done using
your functions and you can do whatever optimization you like.


> The block size for e.g. a dd if=/dev/mtd0 of=/dev/null
> with the default block size (I believe it's 512Bytes), fetches from 
> /dev/mtd0 4096 Bytes at a time.
> I'd prefer the kernel to be scheduling other tasks meanwhile, instead of 
> busy-waiting on completion.
> 
> Regards
> 
> Kenneth Johansson ha scritto:
> > On Mon, 2009-10-19 at 09:52 +0200, Fortini Matteo wrote:
> >
> >   
> >> I didn't find a cleaner way than just #ifdef'ing the map_copy_from call 
> >> and substitute with my call on relevant cases. I wonder if there is a 
> >> cleaner way.
> >>     
> >
> > Remove the call to simple_map_init() and do it manually in your driver
> > with your own functions.
> >
> >   
> >> And yes, as soon as I've cleaned up the code a little bit, I will 
> >> definitely post a patch about it.
> >>
> >> Moreover: a huge benefit would come from exploiting DMA on these 
> >> transfers, 
> >>     
> >
> > probably depends on the block size if it's a gain or not. What is the
> > size you normally see. 
> >
> >
> >   
> 
> 
