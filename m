Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ7lD3LbqzF0TV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 03:40:08 +1100 (AEDT)
Date: Fri, 12 Jan 2018 10:39:46 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <fengguang.wu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kbuild-all@01.org,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>
Subject: Re: [cryptodev:master 130/134] aes_generic.c:undefined reference to
 `_restgpr_31_x'
Message-ID: <20180112163946.GE21977@gate.crashing.org>
References: <201801122249.RHvvGQJ6%fengguang.wu@intel.com>
 <CAK8P3a0Rfbo=wJgEAm3vVFY1MpPWLE3HMGcUdoOXxqOVm8jRyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a0Rfbo=wJgEAm3vVFY1MpPWLE3HMGcUdoOXxqOVm8jRyw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Fri, Jan 12, 2018 at 03:55:47PM +0100, Arnd Bergmann wrote:
> >    crypto/aes_generic.o: In function `crypto_aes_set_key':
> >>> aes_generic.c:(.text+0x4e0): undefined reference to `_restgpr_31_x'
> 
> adding linuxpcc-dev to Cc, maybe someone knows a way out of this.
> It appears related to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=43810

It is not.

> but I don't know what _restgpr_31_x actually does,

It restores GPR31 from stack, restores LR from stack, and returns
(_x is "exit").

> why it's not provided by the kernel

Because the kernel refuses to use libgcc.  Let's, uh, not start that
again?  :-)

> or why the aes_generic implementation needs this on
> powerpc when built with 'gcc -Os'. FWIW, the -Os change was needed
> to work around a possible kernel stack overflow that can happen with
> gcc-7.2, see https://patchwork.kernel.org/patch/10143607/ and
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83356

The _x versions are smaller but slower; that's why they are used with -Os.
Apparently nothing else was built with -Os (and the other needed flags)
before.


Segher
