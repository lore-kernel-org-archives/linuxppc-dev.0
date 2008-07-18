Return-Path: <jreiser@BitWagon.com>
Received: from jade.aracnet.com (jade.aracnet.com [216.99.193.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CFFCDE502
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 06:32:05 +1000 (EST)
Message-ID: <4880FDA1.9070307@BitWagon.com>
Date: Fri, 18 Jul 2008 13:31:29 -0700
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH v3] elf loader support for auxvec base platform string
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>
	<1216166331-14810-2-git-send-email-ntl@pobox.com>
	<1216276539.7740.309.camel@pasglop>
	<20080717000951.5f8cab37.akpm@linux-foundation.org>
	<20080717221932.GL9594@localdomain>
	<20080717154218.8981035c.akpm@linux-foundation.org>
	<487FD74C.4080603@BitWagon.com> <20080718182850.GO9594@localdomain>
In-Reply-To: <20080718182850.GO9594@localdomain>
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:

> +#define AT_EXECFN  31	/* filename of program */
> 
> How did you arrive at 31 for the value of AT_EXECFN?  I haven't been
> able to find out how AT_* values are "allocated", or what the reason
> is for the gap between AT_SECURE and AT_SYSINFO.

The numbers are chosen by experience, taste, and fiat.
Hopefully new choices do not conflict with existing ones,
but there is no formal "issuing authority."
In history the auxiliary vector has been not well standardized
and many times has been hidden from view of applications, although some
SysV-based systems have made it visible as a fourth argument to main().
Linux has /proc/pid/auxv, although the implementation suffers
from being exposed to overwriting by the user.  From long experience
at virtualization in user mode, I favor better access, more use,
and better understanding of what the auxiliary vector provides.

AT_SYSINFO at 32 was chosen to avoid conflicts with [0,31]
partly on the theory that the first 32 might be considered
to be reserved for use across all UNIX-like systems,
while AT_SYSINFO definitely was Linux-specific.
I chose AT_EXECFN at 31 because I considered the concept
to be applicable to any system having execve(), even if AT_EXECFN
is not universally implemented.  I had not seen any new tags
below 32 in a long time.  The concept of AT_EXECFN allows
a nice interface for a virtualizer. The somewhat-related
AT_EXECFD already exists below 32.

Elsewhere, I've staked out use of a new AT_WINE_PRELOAD_INFO
at 30.  Avoid that one, please. :-)

-- 
John Reiser, jreiser@BitWagon.com
