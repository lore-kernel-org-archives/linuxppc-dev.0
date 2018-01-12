Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x244.google.com (mail-ot0-x244.google.com
 [IPv6:2607:f8b0:4003:c0f::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJCpg6DwPzF0WC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 06:43:23 +1100 (AEDT)
Received: by mail-ot0-x244.google.com with SMTP id g59so5958483otg.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 11:43:23 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180112163946.GE21977@gate.crashing.org>
References: <201801122249.RHvvGQJ6%fengguang.wu@intel.com>
 <CAK8P3a0Rfbo=wJgEAm3vVFY1MpPWLE3HMGcUdoOXxqOVm8jRyw@mail.gmail.com>
 <20180112163946.GE21977@gate.crashing.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Jan 2018 20:43:21 +0100
Message-ID: <CAK8P3a39=PVpwiSk_3CjRnYBawhXqMatHKSsHCd2KHCgR+Zmyg@mail.gmail.com>
Subject: Re: [cryptodev:master 130/134] aes_generic.c:undefined reference to
 `_restgpr_31_x'
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 kbuild test robot <fengguang.wu@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, kbuild-all@01.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2018 at 5:39 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:

>> or why the aes_generic implementation needs this on
>> powerpc when built with 'gcc -Os'. FWIW, the -Os change was needed
>> to work around a possible kernel stack overflow that can happen with
>> gcc-7.2, see https://patchwork.kernel.org/patch/10143607/ and
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83356
>
> The _x versions are smaller but slower; that's why they are used with -Os.
> Apparently nothing else was built with -Os (and the other needed flags)
> before.

Ah, that explains it, the definition is in arch/powerpc/lib/crtsavres.S,
but inside of #ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE.

We could theoretically work around it by turning that into
"#if defined(CONFIG_CC_OPTIMIZE_FOR_SIZE) ||
defined(CONFIG_CRYPTO_AES)", but that seems rather ugly.

My earlier patch already tried to be more specific, turning very
specific optimizations off rather than moving from -O2 to -Os,
but that turned out to lead to significantly worse performance,
where -Os improved performance slightly. Is there a way
to ask powerpc compilers to use mostly -Os but not the
specific thing that makes it link to _restgpr_31_x?

       Arnd
