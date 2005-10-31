Return-Path: <i2a@gmx.net>
Received: from vmx15.multikabel.net (vmx15.multikabel.net [212.127.254.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C93B66863E
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 20:59:07 +1100 (EST)
Received: from vmx100.multikabel.net ([212.127.254.147])
	by vmx15.multikabel.net with esmtp (Exim 4.44) id 1EWWRS-0001Ux-4r
	for linuxppc-dev@ozlabs.org; Mon, 31 Oct 2005 10:59:02 +0100
From: "Ingmar" <i2a@gmx.net>
To: Hollis Blanchard <hollis@penguinppc.org>
Date: Mon, 31 Oct 2005 10:58:53 +0100
Message-Id: <20051031093907.M8073@gmx.net>
In-Reply-To: <2828913a7186e850887d415a8311dc44@penguinppc.org>
References: <1130645036.29054.229.camel@gaston>
	<20051031002926.M71008@quicknet.nl>
	<2828913a7186e850887d415a8311dc44@penguinppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: exception vectors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 30 Oct 2005 20:28:49 -0600, Hollis Blanchard wrote
> On Oct 30, 2005, at 6:35 PM, Ingmar wrote:
> >
> > I am trying to overwrite the exception vector space of an ibook G4 :).
> 
> Why?
> 

For my thesis project I am porting the Minix (v3) OS.

> > I have set up (for every exception) a small piece of code, that's a 
> > prefix of a
> > handler to be called. My problem is, that writing the small chunks 
> > of code to
> > the exception vector space gives no problem(so it seams) but writing 
> > all the
> > pieces of code as one chunk gives a exception [dsi, dsisr 0x42000000], 
> > this
> > indicates a store problem.
> 
> Code please. You're just calling memcpy?

I have done different methods (lots of code),
 - as a test just setting the memory, with memset,
 - custom copying word by word, flushing the cache while going,
 - flushing the cache afterwards,

the results are not always what I excected, the memset works if I don't set to
much like from 0x0 – 0x200. The copying would be the complete block.

> > I have tried different modes of copying, mmu on/off, also chanced the 
> > WING bits,
> > switched the exception prefix on.
> 
> You could not have gotten a DSI if you disabled the MMU...

Oke, than this is one I am sure of now, thanks :)

> > I don't believe putting the exception vectors to there place one by 
> > one is the
> > right way, in the Linux kernel the kernel get relocated and the code 
> > comes into
> > place. I have taken this as an example, unfortunately to to result :(..
> 
> So you are not trying to overwrite Linux's functioning exception 
> handlers, but rather trying to write your own OS?

Yes :).

> >  - Am I overlooking something?
> >  - Is the a standard way to overwrite the exception vector space of 
> > a powerpc?
> 
> Do you think this is a common task? :)

No the task maybe not, but the method could be,
 - I am sure (now) that the mmu must be off,
 - copying must be done with flushing the caches,

> -Hollis

Thanks
  Ingmar.
