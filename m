Return-Path: <olof@austin.ibm.com>
Date: Fri, 4 Feb 2005 11:20:41 -0600
To: Pekka Enberg <penberg@gmail.com>
Message-ID: <20050204172041.GA17586@austin.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com>
	<84144f0205020400172d89eddf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84144f0205020400172d89eddf@mail.gmail.com>
From: olof@austin.ibm.com (Olof Johansson)
Cc: akpm@osdl.org, trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, penberg@cs.helsinki.fi,
	paulus@samba.org, hpa@zytor.com, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 04, 2005 at 10:17:48AM +0200, Pekka Enberg wrote:
> Please drop the CPU_FTR_##x macro magic as it makes grepping more
> complicated. If the enum names are too long, just do s/CPU_FTR_/CPU_/g
> or something similar. Also, could you please make this a static inline
> function?

I considered that for a while, but decided against it because:

* cpu-has-feature(cpu-feature-foo) v cpu-has-feature(foo): I picked the
latter for readability.
* Renaming CPU_FTR_<x> -> CPU_<x> makes it less obvious that
it's actually a cpu feature it's describing (i.e. CPU_ALTIVEC vs
CPU_FTR_ALTIVEC).
* Renaming would clobber the namespace, CPU_* definitions are used in
other places in the tree.
* Can't make it an inline and still use the preprocessor concatenation.

That being said, you do have a point about grepability. However,
personally I'd be more likely to look for CPU_HAS_FEATURE than the
feature itself when reading the code, and would find that easily. The
other way around (finding all uses of a feature) is harder, but the
concatenation macro is right below the bit definitions and easy to spot.


-Olof
