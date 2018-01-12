Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJH594snGzF0j6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 09:11:09 +1100 (AEDT)
Date: Fri, 12 Jan 2018 16:10:50 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 kbuild test robot <fengguang.wu@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [cryptodev:master 130/134] aes_generic.c:undefined reference to
 `_restgpr_31_x'
Message-ID: <20180112221050.GR21977@gate.crashing.org>
References: <201801122249.RHvvGQJ6%fengguang.wu@intel.com>
 <CAK8P3a0Rfbo=wJgEAm3vVFY1MpPWLE3HMGcUdoOXxqOVm8jRyw@mail.gmail.com>
 <20180112163946.GE21977@gate.crashing.org>
 <CAK8P3a39=PVpwiSk_3CjRnYBawhXqMatHKSsHCd2KHCgR+Zmyg@mail.gmail.com>
 <20180112204154.GM21977@gate.crashing.org>
 <CAK8P3a2YVVseBFNoDbwOtqR3-JHFuZ-WZD6-PzztNTO_X_soaw@mail.gmail.com>
 <20180112214111.GQ21977@gate.crashing.org>
 <CAK8P3a3XKwrVpXH9=8n1=qAKtqHE+1sh6OhaJ_39GZcWSP-j=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a3XKwrVpXH9=8n1=qAKtqHE+1sh6OhaJ_39GZcWSP-j=Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2018 at 10:45:31PM +0100, Arnd Bergmann wrote:
> > I guess you could enable the _x routines whenever you use ubsan?  Ubsan
> > will cause much bigger code growth than the handful of insns in those
> > routines?
> 
> Right, that could work, too. My patch that Herbert merged intentionally
> used -Os also for non-UBSAN builds because it turned out to
> be much faster (see gcc PR83651),

"Much"?

-Os is *slower* with 8.0, 5% faster with 7.2, 4% faster with 7.1,
slower with 7.0 and 6.3.  Your numbers, #c1.

Anf this is the generic code of course, which is slow anyway (not to
mention insecure).

> but we could revert that back
> to the default and only use the -Os for UBSAN, essentially
> addressing only PR83356 but not PR83651.


Segher
