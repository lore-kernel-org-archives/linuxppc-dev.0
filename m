Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 320B0B7093
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 08:27:27 +1100 (EST)
Date: Mon, 16 Nov 2009 15:27:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 00/10] Fix 8xx MMU/TLB
Message-ID: <20091116212741.GA10968@loki.buserror.net>
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091116210009.GA5113@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091116210009.GA5113@loki.buserror.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2009 at 03:00:09PM -0600, Scott Wood wrote:
> On Sun, Nov 15, 2009 at 06:09:27PM +0100, Joakim Tjernlund wrote:
> > [I used the wrong branch, this will hopefully not conflict]
> > 
> > This is hopfully the last iteration of the series.
> > Rex & Scott, please test and signoff.
> > Changes since last version:
> >  - Added mandatory pinning of iTLB
> >  - Added "DTLB Miss cleanup"
> 
> I still get the EFAULTs.

This snippet of strace is particularly interesting:

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30020000
read(0, 0x30020000, 1024)               = -1 EFAULT (Bad address)

Or this:

brk(0x10036000)                         = 0x10036000
fstat64(1, {st_mode=S_IFCHR|0660, st_rdev=makedev(5, 1), ...}) = 0
open("/etc/mtab", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
read(3, 0x10016000, 4096)               = -1 EFAULT (Bad address)

It seems that the failures are related to reading from /proc (/etc/mtab is
linked to /proc/mounts), though some /proc reads work
(/proc/self/oom_score).  I also see the uname syscall failing in some apps
(but not in the uname app itself, oddly), especially /proc-related apps such
as ps and top, though they're not actually accessing /proc with this call:

uname(0xffef7d0)                        = -1 EFAULT (Bad address)

-Scott
