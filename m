Return-Path: <penberg@cs.helsinki.fi>
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Olof Johansson <olof@austin.ibm.com>
In-Reply-To: <20050204172041.GA17586@austin.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com>
	<84144f0205020400172d89eddf@mail.gmail.com>
	<20050204172041.GA17586@austin.ibm.com>
Date: Sat, 05 Feb 2005 09:48:19 +0200
Message-Id: <1107589699.17616.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: akpm@osdl.org, Pekka Enberg <penberg@gmail.com>, trini@kernel.crashing.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
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

On Fri, 2005-02-04 at 11:20 -0600, Olof Johansson wrote:
> * cpu-has-feature(cpu-feature-foo) v cpu-has-feature(foo): I picked the
> latter for readability.
> * Renaming CPU_FTR_<x> -> CPU_<x> makes it less obvious that
> it's actually a cpu feature it's describing (i.e. CPU_ALTIVEC vs
> CPU_FTR_ALTIVEC).
> * Renaming would clobber the namespace, CPU_* definitions are used in
> other places in the tree.
> * Can't make it an inline and still use the preprocessor concatenation.

Seriously, if readability is your argument, macro magic is not the
answer. Ok, we can't clobber the CPU_ definitions, so pick another
prefix.

If you want readability, please consider using named enums:

enum cpu_feature {
	CF_ALTIVEC = /* ... */
};

static inline int cpu_has_feature(enum cpu_feature cf) { }

			Pekka
