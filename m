Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@austin.ibm.com>
In-Reply-To: <20050204183514.GB17586@austin.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com>
	<200502041336.59892.arnd@arndb.de>
	<20050204183514.GB17586@austin.ibm.com>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 10:50:44 +1100
Message-Id: <1107561044.2189.120.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-02-04 at 12:35 -0600, Olof Johansson wrote:
> On Fri, Feb 04, 2005 at 01:36:55PM +0100, Arnd Bergmann wrote:
> > I have a somewhat similar patch that does the same to the
> > systemcfg->platform checks. I'm not sure if we should use the same inline
> > function for both checks, but I do think that they should be used in a
> > similar way, e.g. CPU_HAS_FEATURE(x) and PLATFORM_HAS_FEATURE(x).
> 
> Yep. Firmware features are also on the list. I figured I'd do CPU features
> first though since they are the ones that started bugging me.
> 
> > The same stuff is obviously possible for cur_cpu_spec->cpu_features as well.
> > Do you think that it will help there?
> 
> Nice. It won't be quite as easy to do compile-time for cpu features.
> pSeries will need all cpus enabled since we have them all on various
> machines, etc. I guess Powermac/Maple could benefit from it. In the
> end it depends on how hairy the implementation would get vs performance
> improvement.

One other thing we did on ppc32 was to have separate ELF sections for
pmac, chrp and prep specific code & get rid of them after boot... It may
be worth bringing this back in...

Ben.
