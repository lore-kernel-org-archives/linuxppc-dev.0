Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 25B45DDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 03:36:52 +1100 (EST)
Date: Thu, 15 Mar 2007 17:36:48 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] lite5200b suspend: low-power mode
Message-ID: <20070315163648.GG19297@nd47.coderock.org>
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104447.GG22215@moe.telargo.com>
	<528646bc0703150709v49af8085p959bd36e0adf1e4a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0703150709v49af8085p959bd36e0adf1e4a@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 15/03/07 08:09 -0600, Grant Likely wrote:
> On 3/15/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> >Low-power mode implementation for Lite5200b.
> >Some I/O registers are also saved here.
> >
> >A patch to U-Boot that wakes up SDRAM, and transfers control
> >to address saved at physical 0x0 is needed.
> 
> I don't see any structural problems with this code, but I have a few
> comments below.  I'm also concerned about the blind register
> save/restore by memcpy_to/fromio.  I haven't looked at the chip
> documentation, but it looks scary.  Is it safe to restore those
> registers in that manner?
> 
...
> >+       /* map registers */
> >+       mbar = ioremap_nocache(0xf0000000, 0x8000);
> 
> Magic numbers?  Really?  This should be retrieved from the device
> tree.  There is always the possibility of mbar getting moved.
> 
...
> >+       gpw = mbar + 0xc00;
> >+       bes = mbar + 0x1200;
> >+       xlb = mbar + 0x1f00;
> 
> Again, magic numbers

Well... the code is only applicable for Lite5200b/mpc5200
and numbers are from specs.
And it's shorter than mpc52xx_find_and_map() lines.
I guess I could rewrite it.

> >+       _memcpy_fromio(&scdm, cdm, sizeof(*cdm));
> >+       _memcpy_fromio(&sxlb, xlb, sizeof(*xlb));
> >+       _memcpy_fromio(&sgps, gps, sizeof(*gps));
> >+       _memcpy_fromio(&sgpw, gpw, sizeof(*gpw));
> 
> Hmmm.  I have not dug into this deeply, but blind save/restore to
> blocks of registers scares me.

Seems to work (tm), I'll look at datasheet.

> >+// about 2000 cpu cycles for one sdram cycle here
> >+// just increase, to be on the safe side?
> >+#define TCK    5000
> 
> Please avoid c++ comments

// are in ANSI C99 too, but ok, I know kernel folks don't like them :-)


> >+#define DONT_DEBUG 1
> 
> Convention is to #define DEBUG to enable debugging (as opposed to
> #defining something to disable it)

Yeah, makes sense.


	Domen
