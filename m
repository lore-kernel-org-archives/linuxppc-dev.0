Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 101DF67BE3
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 11:33:59 +1100 (EST)
Date: Mon, 11 Dec 2006 16:05:41 -0800 (PST)
Message-Id: <20061211.160541.111202759.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
From: David Miller <davem@davemloft.net>
In-Reply-To: <17789.54777.283849.950002@cargo.ozlabs.ibm.com>
References: <20061211185536.GA19338@aepfle.de>
	<Pine.LNX.4.64.0612111106310.12500@woody.osdl.org>
	<17789.54777.283849.950002@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, olaf@aepfle.de, drfickle@us.ibm.com,
	linux-kernel@vger.kernel.org, ak@suse.de,
	linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Tue, 12 Dec 2006 09:04:41 +1100

> If there is a reliable way to get the version string, great, I'll use
> that.

FWIW, on sparc and sparc64 we have this information block for
the boot loader.

The first two instructions at the entry point simply branch
over the boot loader information block header.

The information block starts with a known magic string "HdrS" which
does not match any valid Sparc instruction.  Any tool can search for
it starting at the symbol "_start" in the kernel image.

Inside this information block we stick a 32-bit word which contains
LINUX_VERSION_CODE.

That only gives you the version, not the whole version string, but you
could put the whole string in such a location when adding such a
facility to powerpc if you wanted to.
