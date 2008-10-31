Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18698.62038.907424.657408@cargo.ozlabs.ibm.com>
Date: Fri, 31 Oct 2008 22:56:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org
Subject: Re: 2.6.28-rc1: NVRAM being corrupted on ppc64 preventing boot
	(bisected)
In-Reply-To: <1225452697.8004.211.camel@pasglop>
References: <alpine.LFD.2.00.0810232028500.3287@nehalem.linux-foundation.org>
	<20081030142632.GA15645@csn.ul.ie>
	<18698.7794.500191.189515@cargo.ozlabs.ibm.com>
	<20081031103646.GA24395@csn.ul.ie>
	<18698.59790.393775.139313@cargo.ozlabs.ibm.com>
	<1225452697.8004.211.camel@pasglop>
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> Unless missed something, I think it's narrowed already. When loaded from
> yaboot, there is no relevant difference between zImage and vmlinux here.
> IE. yaboot parses the ELF header of the zImage itself and ignores the
> special notes anyway so only the CAS firmware call is relevant in both
> cases, no ?

Good point.  However, it would be the parse-elf-header firmware call,
rather than the CAS firmware call, since 91a00302 modified the
fake_elf structure (to make it consistent with the CAS structure) but
not the CAS structure.

Paul.
