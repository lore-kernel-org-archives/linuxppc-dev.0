Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 38F6867BD2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 15:21:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Perl 
Date: Sun, 19 Nov 2006 20:21:07 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C0438F0@ehost011-3.exch011.intermedia.net>
In-Reply-To: <20061114215034.292D7352B86@atlas.denx.de>
From: "Leonid" <Leonid@a-k-a.net>
To: "Wolfgang Denk" <wd@denx.de>,
	"Lee Revell" <rlrevell@joe-job.com>
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

On Tuesday, November 14, 2006 1:51 PM Wolfgang Denk wrote:
> I confirm that building Perl on the target system using the ELDK root
> file system over NFS works fine.

> Just try it out. It may be slow, but CPU cyles are cheap.

I've done this successfully with ELDK 4.0 and 3.1.1 on PPC440EP Yosemite
board. Resulting perl binary is working with ELDK ppc_4xx filesystem
(linux 2.6.13 has been used).

However it doesn't run on original Yosemite filesystem (I've copied all
perl files there) - it doesn't find certain glibc symbols. With ELDK 4.0
it's quite understood - it uses glibc 2.3.4, while my filesystem has
glibc 2.3.1. But ELDK 3.1.1 has glibc 2.3.1, yet when I try to run perl,
natively compiled with ELDK 3.1.1 fs on my fs (glibc 2.3.1 as well), it
says:

tmp # /opt/bin/perl warnings.pl
/opt/bin/perl: relocation error: /opt/bin/perl: symbol __floatsidf,
version GLIBC_2.3.2 not defined in file libc.so.6 wie

When I copy libc-2.3.1.so from ELDK filesystem to ours, it fails:

/tmp # /opt/bin/perl warnings.pl
Segmentation fault
=20
Did I something wrong?

Thanks,

Leonid.
