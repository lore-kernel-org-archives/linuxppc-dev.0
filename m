Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] selection of CPU optimization
Date: Thu, 12 Apr 2007 19:26:03 +0200
References: <20070410111508.GA2969@localhost.localdomain>
	<200704121501.34311.arnd@arndb.de>
	<981B07C8-D35B-4581-8FC7-DCA58430A081@kernel.crashing.org>
In-Reply-To: <981B07C8-D35B-4581-8FC7-DCA58430A081@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704121926.03723.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 April 2007, Kumar Gala wrote:

> > +config PPC_CPU_ANY32
> > +	bool "Generic 32 bit PowerPC"
> > +	depends on PPC_6xx || PPC_8xx || 4xx || E200 || E500
> > +	select PPC_ENABLE_ALTIVEC
> 
> What is PPC_ENABLE_ALTIVEC used for?

The idea was that PPC_ENABLE_ALTIVEC is selected when PPC_ALTIVEC
_can_ be enabled, while PPC_ALTIVEC is selected by some CPUs
directly.

I now remember that I had not done this part right in the patch
I posted. The correct behavior should be something like

choice
	prompt "Processor level"

config PPC_CPU_740
	bool "G3 or higher"
	select PPC_ENABLE_ALTIVEC
	# altivec is possible

config PPC_CPU_86xx
	bool "86xx"
	select PPC_ALTIVEC
	# altivec is required

config PPC_CPU_4xx
	bool "4xx"
	# altivec is not possible

endchoice

config PPC_ENABLE_ALTIVEC
	bool

config PPC_ALTIVEC
	bool "Enable the use of Altivec"
	depends on PPC_ENABLE_ALTIVEC

I'll fix this up in the next version, which should also
be split into simpler patches.

> > +config PPC_CPU_FLAG
> > +	string
> > +	default "" if PPC_CPU_UNSPECIFIED
> > +	default "-mcpu=powerpc64" if PPC_CPU_ANY64
> > +	default "-mcpu=rs64" if PPC_CPU_RS64
> > +	default "-mcpu=power3" if PPC_CPU_POWER3
> > +	default "-mcpu=power4" if PPC_CPU_POWER4
> > +	default "-mcpu=power5" if PPC_CPU_POWER5
> > +	default "-mcpu=power5+" if PPC_CPU_POWER5PLUS
> > +	default "-mcpu=power6" if PPC_CPU_POWER6
> > +	default "-mcpu=970" if PPC_CPU_970
> > +	default "" if PPC_CPU_CELLBE
> > +	default "" if PPC_CPU_PA6T
> > +	default "-mcpu=powerpc" if PPC_CPU_ANY32
> > +	default "-mcpu=601" if PPC_CPU_601
> > +	default "-mcpu=603" if PPC_CPU_603
> > +	default "-mcpu=604" if PPC_CPU_604
> > +	default "-mcpu=750" if PPC_CPU_750
> > +	default "-mcpu=7400" if PPC_CPU_7400
> > +	default "-mcpu=7450" if PPC_CPU_7450
> > +	default "-mcpu=801" if PPC_CPU_801
> > +	default "-mcpu=821" if PPC_CPU_821
> > +	default "-mcpu=823" if PPC_CPU_823
> > +	default "-mcpu=860" if PPC_CPU_860
> > +	default "-mcpu=403" if PPC_CPU_403
> > +	default "-mcpu=405" if PPC_CPU_405
> > +	default "-mcpu=440" if PPC_CPU_440
> > +	default "" if PPC_CPU_E200
> > +	default "" if PPC_CPU_E500
> 
> I think -mcpu=8540 will work for e500 (same for tune)

Interestingly, -mcpu=8540 is known to gcc, according to
gcc-4.0.3 -dumpspecs, but is not listed in the documentation.
There is also -me500, while -me200 seems to be known only
to gas but not gcc.

What would be the right options to pass on e200 and on
pa6t?

> > +config PPC_OF_PLATFORM_PCI
> > +	bool
> > +	depends on PPC64 # not supported on 32 bits yet
> > +	default n
> 
> Should this really be in here? I don't see how OF PCI has anything to  
> do with CPU/core.

Right.

	Arnd <><
