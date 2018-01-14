Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com
 [IPv6:2607:f8b0:4003:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKVK60s8VzF0ck
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 08:40:41 +1100 (AEDT)
Received: by mail-oi0-x229.google.com with SMTP id g128so7110395oib.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 13:40:41 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180112221050.GR21977@gate.crashing.org>
References: <201801122249.RHvvGQJ6%fengguang.wu@intel.com>
 <CAK8P3a0Rfbo=wJgEAm3vVFY1MpPWLE3HMGcUdoOXxqOVm8jRyw@mail.gmail.com>
 <20180112163946.GE21977@gate.crashing.org>
 <CAK8P3a39=PVpwiSk_3CjRnYBawhXqMatHKSsHCd2KHCgR+Zmyg@mail.gmail.com>
 <20180112204154.GM21977@gate.crashing.org>
 <CAK8P3a2YVVseBFNoDbwOtqR3-JHFuZ-WZD6-PzztNTO_X_soaw@mail.gmail.com>
 <20180112214111.GQ21977@gate.crashing.org>
 <CAK8P3a3XKwrVpXH9=8n1=qAKtqHE+1sh6OhaJ_39GZcWSP-j=Q@mail.gmail.com>
 <20180112221050.GR21977@gate.crashing.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 14 Jan 2018 22:40:36 +0100
Message-ID: <CAK8P3a30k-JjMJ0M9KWXqUMT3eHmuuFvAe1KuKdqNoAiSZrgog@mail.gmail.com>
Subject: Re: [cryptodev:master 130/134] aes_generic.c:undefined reference to
 `_restgpr_31_x'
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 kbuild test robot <fengguang.wu@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2018 at 11:10 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Fri, Jan 12, 2018 at 10:45:31PM +0100, Arnd Bergmann wrote:
>> > I guess you could enable the _x routines whenever you use ubsan?  Ubsan
>> > will cause much bigger code growth than the handful of insns in those
>> > routines?
>>
>> Right, that could work, too. My patch that Herbert merged intentionally
>> used -Os also for non-UBSAN builds because it turned out to
>> be much faster (see gcc PR83651),
>
> "Much"?
>
> -Os is *slower* with 8.0, 5% faster with 7.2, 4% faster with 7.1,
> slower with 7.0 and 6.3.  Your numbers, #c1.
>
> Anf this is the generic code of course, which is slow anyway (not to
> mention insecure).

Right. I've done some more investigation anyway, starting over with the
analysis of the gcc options that change it. I've found now that turning
off '-fcode-hoisting' but leaving on the other options I had suspected
earlier (-O2 instead of -Os, -ftree-sra, -ftree-pre) also fixes the
stack problem, and appears to result in the best performance so
far. I need to rerun the whole test matrix, but that seems rather
promising, and the result may also help debug what's really happening.

       Arnd
