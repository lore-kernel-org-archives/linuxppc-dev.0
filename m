Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 04562DDF04
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 18:32:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 2/3] PowerPC: lazy altivec enabling in kernel
Date: Tue, 24 Apr 2007 10:32:02 +0200
References: <20070417115206.709701000@linux.vnet.ibm.com>
	<20070417120925.263638000@linux.vnet.ibm.com>
	<17965.21687.567012.175024@cargo.ozlabs.ibm.com>
In-Reply-To: <17965.21687.567012.175024@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704241032.02856.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 24 April 2007, Paul Mackerras wrote:
> It would be better to put a test and conditional branch in
> giveup_altivec to skip the mtmsrd if MSR_VEC is already set. =A0That
> would avoid adding the overhead of the trap in the case when MSR_VEC
> isn't already set, besides being much less code.

When I discussed this with Sebastian, my assumption was that even
the mfmsr is rather expensive by itself, but I may have interpreted
the profile data incorrectly.

Do you think it's safe to assume that by skipping mtmsr we can avoid
the bulk of the overhead on most CPUs?

	Arnd <><
