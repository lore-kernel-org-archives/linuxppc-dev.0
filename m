Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 82149DDEDE
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 05:01:14 +1000 (EST)
Date: Sat, 5 May 2007 14:02:44 -0500
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 5/6] Support for the Ebony 440GP reference board in
	arch/powerpc
Message-ID: <20070505190244.GA23524@lixom.net>
References: <20070504143645.GA10645@lixom.net>
	<00bf8e702554e7903d92f618ee236528@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00bf8e702554e7903d92f618ee236528@bga.com>
From: olof@lixom.net (Olof Johansson)
Cc: ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 05, 2007 at 01:43:01PM -0500, Milton Miller wrote:
> Olof wrote:
> 
> > > +static void ebony_exit(void)
> > > +{
> > > +     unsigned long tmp;
> > > +
> > > +     asm volatile (
> > > +             "mfspr  %0,%1\n"
> > > +             "oris   %0,%0,%2@h\n"
> > > +             "mtspr  %1,%0"
> > > +             : "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
> >
> > You don't have to pass in the constants here, you can specify them in
> > the asm. Makes it a little more readable.
> 
> How?   CPP doesn't apply inside the strings.
> 
> Did you mean because these defines were immediately above:
> 
> > > +> +#define SPRN_DBCR0           0x134
> > > +#define   DBCR0_RST_SYSTEM   0x30000000
> 
> could just be comments in the asm?
> 
> That works until someone moves them to an include file.

Hm, I thought i had done that in the past myself. I guess not. Nevermind
then.


-Olof
