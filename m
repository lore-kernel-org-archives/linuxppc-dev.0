Return-Path: <davej@codemonkey.org.uk>
Date: Mon, 7 Jul 2008 17:31:05 -0400
From: Dave Jones <davej@codemonkey.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: powerpc/cell/cpufreq: add spu aware cpufreq governor
Message-ID: <20080707213105.GD4997@codemonkey.org.uk>
References: <200807071702.31240.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200807071702.31240.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, cpufreq@lists.linux.org.uk,
	linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
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
 > 
 > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
 > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
 > ---
 > 
 > Dave or other cpufreq people, can you take a look at this
 > and add an Acked-by when you're happy?

It looks ok on a quick look through.  I'm wondering about the multiple governors
thing though. This came up at last years power management summit, but no-one has
mentioned it since.  I think it's possible we want to look at things like
this in the future, and not just for cell. I keep hearing mumblings about
future generations of x86's having dedicated coprocessors for certain tasks
that may benefit from the same thing.

 > We have one prerequisite patch in the powerpc code (in spufs),
 > so should it get merged through powerpc.git?

That's fine with me. Conflicts should be minimal if any at all,
I've got nothing queued up which touches that part of Kconfig/Makefile

One question I do have though, is how userspace scripts are supposed
to know they're to echo cbe_spu_governor into the relevant parts of
sysfs.  I've not used anything with a cell. Do they expose the SPUs
as regular CPUs, or do they show up in a different part of the tree?

	Dave

-- 
http://www.codemonkey.org.uk
