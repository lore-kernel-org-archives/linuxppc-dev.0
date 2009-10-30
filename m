Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 589401007E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 04:49:20 +1100 (EST)
Date: Fri, 30 Oct 2009 18:49:04 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Accessing flash directly from User Space [SOLVED]
Message-ID: <20091030174904.GA2061@iram.es>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<200910301556.11349.mb@bu3sch.de>
	<20091030150855.GA15046@mail.gnudd.com>
	<200910301624.03989.mb@bu3sch.de> <4AEB0ABB.8070605@neli.hopto.org>
	<BB99A6BA28709744BF22A68E6D7EB51F0330EE1316@midas.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330EE1316@midas.usurf.usu.edu>
Cc: "bgat@billgatliff.com" <bgat@billgatliff.com>,
	"scottwood@freescale.com" <scottwood@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Alessandro Rubini <rubini@gnudd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2009 at 10:46:46AM -0600, Jonathan Haws wrote:
> > Michael Buesch wrote:
> > > Yes, I think the barrier is wrong.
> > > Please try with
> > >
> > > #define mb()	__asm__ __volatile__("eieio\n sync\n" : : :
> > "memory")
> > 
> > 
> > For uncached memory, eieio should be enough.
> 
> I tried eieio alone and it did not work.  It needed the above command to take care of it all.

Surprising. But sync is a superset of eieio, no?

In this case a sync alone should be sufficient (although an eieio
followed by a sync should not be much slower than a sync alone).

	Gabriel
