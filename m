Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D69B1A0350
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 22:19:14 +1100 (AEDT)
Date: Thu, 28 Jan 2016 12:19:10 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20160128111910.GD32095@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160127215112.080eec56@cotter.ozlabs.ibm.com>
 <20160127121904.GB32095@lst.de>
 <20160128134157.1ac3d344@cotter.ozlabs.ibm.com>
 <1453951918.4108.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453951918.4108.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 28, 2016 at 02:31:58PM +1100, Michael Ellerman wrote:
> 
> Looking at GCC history it looks like the fix is in 4.9.0 and anything later.

Good. But 4.8.5 has a buggy -mprofile-kernel, and there will be no 4.8.6, Bad.

> But a version check doesn't work with patched distro/vendor toolchains. So we
> probably need some sort of runtime check.

Agreed.

/bin/echo -e '#include <linux/compiler.h>\nnotrace int func() { return 0; }' |
 gcc -D__KERNEL__ -Iinclude -p -mprofile-kernel -x c -O2 - -S -o - | grep mcount

should be empty. If it yields "bl _mcount" your compiler is buggy.
I haven't looked at the kernel's "autoconf" yet, but it's probably capable
of testing this.

	Torsten
