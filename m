Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <200704121926.03723.arnd@arndb.de>
References: <20070410111508.GA2969@localhost.localdomain>
	<200704121501.34311.arnd@arndb.de>
	<981B07C8-D35B-4581-8FC7-DCA58430A081@kernel.crashing.org>
	<200704121926.03723.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e5b10849669a764f002d1926838edc76@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] selection of CPU optimization
Date: Thu, 12 Apr 2007 21:50:04 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I think -mcpu=8540 will work for e500 (same for tune)
>
> Interestingly, -mcpu=8540 is known to gcc, according to
> gcc-4.0.3 -dumpspecs, but is not listed in the documentation.

Sure it is: gcc/gcc/config/rs6000/rs6000.c, line #s about
1250 and further ;-)

It's supposed to be in the info manual too, if not, please
file a PR; looks good to me though.

> There is also -me500, while -me200 seems to be known only
> to gas but not gcc.

There is no -mcpu=e500.  -me500 is a GAS option.
GCC's -mcpu= options generally take specific CPU names
as parameter; I suppose it would make sense to add e200
et. al.

> What would be the right options to pass on e200 and on
> pa6t?

The best thing would be to add GCC -mcpu= options.  For
now, you're probably best of with -mcpu=powerpc and
-mcpu=powerpc64 resp., i.e. the "blended models".  This
is a good option for multiplatform kernels too; add -mtune=
to optimise for a specific core, but it will *work* on
the whole family.


Segher
