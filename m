Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F4671A001D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 02:06:37 +1100 (AEDT)
Date: Thu, 21 Jan 2016 16:06:33 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20160121150633.GA12374@lst.de>
References: <20151204152419.28E0D691D2@newverein.lst.de>
 <20160106141730.GL3178@pathway.suse.cz>
 <1453269803.14751.10.camel@ellerman.id.au>
 <alpine.LNX.2.00.1601211032430.21446@cbobk.fhfr.pm>
 <1453380891.28627.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453380891.28627.3.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 21, 2016 at 11:54:51PM +1100, Michael Ellerman wrote:
> There is no dmesg :)
> 
> It gets stuck in early_setup() before the console is even found.

Confirmed.
| Device tree struct  0x00000000014b0000 -> 0x00000000014c0000
| Quiescing Open Firmware ...
| Booting Linux via __start() ...
and that's it.

gcc-6 --version
gcc-6 (SUSE Linux) 6.0.0 20160108 (experimental) [trunk revision 232162]

> Also I'm using gcc 6.0 built from mainline just last week, and binutils
> similarly. So possibly that is part of the problem.

Confirmed. It _is_ the problem.
mcount call sites look normal on first sight...

	Torsten
