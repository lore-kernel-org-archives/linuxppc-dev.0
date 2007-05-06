Return-Path: <dgibson@ozlabs.org>
Date: Sun, 6 May 2007 10:43:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] Support for the Ebony 440GP reference board in
	arch/powerpc
Message-ID: <20070506004319.GH11303@localhost.localdomain>
References: <00bf8e702554e7903d92f618ee236528@bga.com>
	<1a1a143ae0292ea0a6006a26fb95a446@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1a1a143ae0292ea0a6006a26fb95a446@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, ppcdev <linuxppc-dev@ozlabs.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 05, 2007 at 10:37:37PM +0200, Segher Boessenkool wrote:
> >>> +static void ebony_exit(void)
> >>> +{
> >>> +     unsigned long tmp;
> >>> +
> >>> +     asm volatile (
> >>> +             "mfspr  %0,%1\n"
> >>> +             "oris   %0,%0,%2@h\n"
> >>> +             "mtspr  %1,%0"
> >>> +             : "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
> >>
> >> You don't have to pass in the constants here, you can specify them in
> >> the asm. Makes it a little more readable.
> >
> > How?   CPP doesn't apply inside the strings.
> 
> So put it outside the strings:
> 
> +     asm volatile (
> +             "mfspr  %0," #SPRN_DBCR0 "\n\t"
> +             "oris   %0,%0," #DBCR0_RST_SYSTEM "@h\n\t"
> +             "mtspr  " #SPRN_DBCR0 ",%0"
> +             : "=&r"(tmp));

Um, I think stringify(SPRN_DBCR0) is needed there, not just a bare #.
At which point it's not entirely clear to be that just using the "i"
constraint isn't the simplest option after all.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
