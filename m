Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKYv370YhzF0Tj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 11:21:51 +1100 (AEDT)
Date: Sun, 14 Jan 2018 18:21:09 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 kbuild test robot <fengguang.wu@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [cryptodev:master 130/134] aes_generic.c:undefined reference to
 `_restgpr_31_x'
Message-ID: <20180115002109.GX21977@gate.crashing.org>
References: <201801122249.RHvvGQJ6%fengguang.wu@intel.com>
 <CAK8P3a0Rfbo=wJgEAm3vVFY1MpPWLE3HMGcUdoOXxqOVm8jRyw@mail.gmail.com>
 <20180112163946.GE21977@gate.crashing.org>
 <CAK8P3a39=PVpwiSk_3CjRnYBawhXqMatHKSsHCd2KHCgR+Zmyg@mail.gmail.com>
 <20180112204154.GM21977@gate.crashing.org>
 <CAK8P3a2YVVseBFNoDbwOtqR3-JHFuZ-WZD6-PzztNTO_X_soaw@mail.gmail.com>
 <20180112214111.GQ21977@gate.crashing.org>
 <CAK8P3a3XKwrVpXH9=8n1=qAKtqHE+1sh6OhaJ_39GZcWSP-j=Q@mail.gmail.com>
 <20180112221050.GR21977@gate.crashing.org>
 <CAK8P3a30k-JjMJ0M9KWXqUMT3eHmuuFvAe1KuKdqNoAiSZrgog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a30k-JjMJ0M9KWXqUMT3eHmuuFvAe1KuKdqNoAiSZrgog@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 14, 2018 at 10:40:36PM +0100, Arnd Bergmann wrote:
> Right. I've done some more investigation anyway, starting over with the
> analysis of the gcc options that change it. I've found now that turning
> off '-fcode-hoisting' but leaving on the other options I had suspected
> earlier (-O2 instead of -Os, -ftree-sra, -ftree-pre) also fixes the
> stack problem, and appears to result in the best performance so
> far.

Oh nice!

> I need to rerun the whole test matrix, but that seems rather
> promising, and the result may also help debug what's really happening.

-fcode-hoisting moves all expression evaluation to as early as possible;
for this AES code that means it will increase register pressure a lot,
causing a lot of spilling (well, that is my guess).  If that is so, then
we need to dial down -fcode-hoisting a bit, maybe make it aware of
register pressure.

Glad you found a smoking gun,


Segher
