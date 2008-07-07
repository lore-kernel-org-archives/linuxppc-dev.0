Return-Path: <eb@comsec.com>
Date: Mon, 7 Jul 2008 10:17:32 -0700
From: Eric Blossom <eb@comsec.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] powerpc/cell/cpufreq: add spu aware cpufreq governor
Message-ID: <20080707171732.GC26603@comsec.com>
References: <200807071702.31240.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200807071702.31240.arnd@arndb.de>
Cc: Dave Jones <davej@codemonkey.org.uk>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	cpufreq@lists.linux.org.uk, linuxppc-dev@ozlabs.org,
	Jeremy Kerr <jk@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 07, 2008 at 05:02:30PM +0200, Arnd Bergmann wrote:
> From: Christian Krafft <krafft@de.ibm.com>
> 
> This patch adds a cpufreq governor that takes the number of running spus
> into account. It's very similar to the ondemand governor, but not as complex.
> Instead of hacking spu load into the ondemand governor it might be easier to
> have cpufreq accepting multiple governors per cpu in future.
> Don't know if this is the right way, but it would keep the governors simple.

I've got a basic question about this idea:

Does it throttle only idle spus or is there a single control for
the entire PPE + SPE complex?

I can think of many situations in our code where at certain times we
may only be able to keep N out of M spes occupied (because of how
we've expressed our task-specific parallelism), but we're counting on
the ones we're using running at full speed so that we can maintain our
real-time throughput.  (Our application does real-time signal
processing of continuously streaming data)

Is there a way to disable the "throttling SPEs" feature short of
configuring it out of the kernel?

Eric
