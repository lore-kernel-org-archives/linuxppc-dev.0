Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@austin.ibm.com>
In-Reply-To: <20050204172041.GA17586@austin.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com>
	<84144f0205020400172d89eddf@mail.gmail.com>
	<20050204172041.GA17586@austin.ibm.com>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 20:08:53 +1100
Message-Id: <1107594534.30270.3.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@gmail.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	penberg@cs.helsinki.fi, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-02-04 at 11:20 -0600, Olof Johansson wrote:
> On Fri, Feb 04, 2005 at 10:17:48AM +0200, Pekka Enberg wrote:
> > Please drop the CPU_FTR_##x macro magic as it makes grepping more
> > complicated. If the enum names are too long, just do s/CPU_FTR_/CPU_/g
> > or something similar. Also, could you please make this a static inline
> > function?

I tend to agree with Pekka...

> I considered that for a while, but decided against it because:
> 
> * cpu-has-feature(cpu-feature-foo) v cpu-has-feature(foo): I picked the
> latter for readability.

I don't think it really matters compared to the usefullness of grep, and
is still more readable than the old way...

> * Renaming CPU_FTR_<x> -> CPU_<x> makes it less obvious that
> it's actually a cpu feature it's describing (i.e. CPU_ALTIVEC vs
> CPU_FTR_ALTIVEC).

Agreed.

> * Renaming would clobber the namespace, CPU_* definitions are used in
> other places in the tree.
> * Can't make it an inline and still use the preprocessor concatenation.

I'd like to keep the constants as-is and have the stuff inline with no
macro trick as Pekka suggest since I did use grep on those things quite
often.

> That being said, you do have a point about grepability. However,
> personally I'd be more likely to look for CPU_HAS_FEATURE than the
> feature itself when reading the code, and would find that easily. The
> other way around (finding all uses of a feature) is harder, but the
> concatenation macro is right below the bit definitions and easy to spot.

No, when I grep, i'm looking for the feature itself...

Ben.
