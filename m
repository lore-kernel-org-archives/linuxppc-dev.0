Return-Path: <paubert@iram.es>
Received: from marchena.puc.rediris.es (marchena.puc.rediris.es [130.206.18.4])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BC1492C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 17:56:08 +1000 (EST)
Date: Mon, 24 Sep 2012 09:55:46 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Probing for native availability of isel from userspace
Message-ID: <20120924075546.GA4263@visitor2.iram.es>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
 <alpine.LNX.2.00.1209221412010.1468@linmac>
 <20120922102151.GA31314@visitor2.iram.es>
 <alpine.LNX.2.00.1209221936330.3878@linmac>
 <BB86F53C-6C09-41DB-9FF3-38E3027BCC82@kernel.crashing.org>
 <1348343737.1132.74.camel@pasglop>
 <35A5B006-1E4E-4355-A6A4-CA5F7371D21C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35A5B006-1E4E-4355-A6A4-CA5F7371D21C@kernel.crashing.org>
Cc: malc <av1474@comtv.ru>, linuxppc-dev@lists.ozlabs.org,
 hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 23, 2012 at 03:46:06AM +0200, Segher Boessenkool wrote:
> Why does the kernel emulate this, btw?  I can see emulation is useful
> for running older binaries, for instructions that have been removed
> from the architecture; but for newly added instructions, or optional
> instructions, it hurts more than it helps?

Indeed. I also don't understand why mfpvr is emulated. That's the kind
of information that should be passed to the executables through auxiliary
vectors. After all, you can (or could at least) compile a kernel without
Altivec support and run it on a processor with Altivec.

Therefore, whether Altivec is supported or not, is a matter of
processor and kernel options. Provide this information through
the auxiliary vector and the problem is solved.

	Gabriel
