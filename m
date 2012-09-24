Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1CCDC2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 17:58:58 +1000 (EST)
Message-ID: <1348473517.1132.87.camel@pasglop>
Subject: Re: Probing for native availability of isel from userspace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Date: Mon, 24 Sep 2012 17:58:37 +1000
In-Reply-To: <20120924075546.GA4263@visitor2.iram.es>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
 <alpine.LNX.2.00.1209221412010.1468@linmac>
 <20120922102151.GA31314@visitor2.iram.es>
 <alpine.LNX.2.00.1209221936330.3878@linmac>
 <BB86F53C-6C09-41DB-9FF3-38E3027BCC82@kernel.crashing.org>
 <1348343737.1132.74.camel@pasglop>
 <35A5B006-1E4E-4355-A6A4-CA5F7371D21C@kernel.crashing.org>
 <20120924075546.GA4263@visitor2.iram.es>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Mon, 2012-09-24 at 09:55 +0200, Gabriel Paubert wrote:
> On Sun, Sep 23, 2012 at 03:46:06AM +0200, Segher Boessenkool wrote:
> > Why does the kernel emulate this, btw?  I can see emulation is useful
> > for running older binaries, for instructions that have been removed
> > from the architecture; but for newly added instructions, or optional
> > instructions, it hurts more than it helps?
> 
> Indeed. I also don't understand why mfpvr is emulated. That's the kind
> of information that should be passed to the executables through auxiliary
> vectors. After all, you can (or could at least) compile a kernel without
> Altivec support and run it on a processor with Altivec.
> 
> Therefore, whether Altivec is supported or not, is a matter of
> processor and kernel options. Provide this information through
> the auxiliary vector and the problem is solved.

Which we do. mfpvr is available as a fallback (essentially because if we
don't do it somebody's going to parse /proc/cpuinfo which is arguably
worse :-)

We should definitely advertise the availability of isel.

Cheers,
Ben.
