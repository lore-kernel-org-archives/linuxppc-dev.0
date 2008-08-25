Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18610.20951.764057.574721@cargo.ozlabs.ibm.com>
Date: Mon, 25 Aug 2008 16:31:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] powerpc/cell/oprofile: fix mutex locking for
	spu-oprofile
In-Reply-To: <200808211014.42683.arnd@arndb.de>
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<200808201519.19453.arnd@arndb.de>
	<18604.60738.523963.886786@drongo.ozlabs.ibm.com>
	<200808211014.42683.arnd@arndb.de>
Cc: Robert Richter <robert.richter@amd.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> The patch does not fix a regression, the spu-oprofile code basically never
> worked. With the current code in Linux, samples in the profile buffer
> can get corrupted because reader and writer to that buffer use different
> locks for accessing it. It took us several iterations to come up with
> a solution that does not introduce other problems and I didn't want to
> push an earlier version that would need more fixups.
> 
> Since rc4 is out now, I understand if you feel more comfortable with
> putting the patch into -next instead of -merge.

Linus has been getting stricter about only putting in fixes for
regressions and serious bugs (see his recent email to Dave Airlie on
LKML for instance).  I assume that the corruption is just in the data
that is supplied to userspace and doesn't extend to any kernel data
structures.  If it does then we have a much stronger argument for
pushing this stuff for 2.6.27.

> Note that the second patch is trivial and fixes an oopsable condition
> of the kernel, so at least that should still go into 2.6.27.

OK, I'll cherry-pick that one for my next batch for Linus.

Paul.
