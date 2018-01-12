Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x22f.google.com (mail-oi0-x22f.google.com
 [IPv6:2607:f8b0:4003:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJGWf0rVhzDqk3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 08:45:33 +1100 (AEDT)
Received: by mail-oi0-x22f.google.com with SMTP id t16so4837726oif.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:45:33 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180112214111.GQ21977@gate.crashing.org>
References: <201801122249.RHvvGQJ6%fengguang.wu@intel.com>
 <CAK8P3a0Rfbo=wJgEAm3vVFY1MpPWLE3HMGcUdoOXxqOVm8jRyw@mail.gmail.com>
 <20180112163946.GE21977@gate.crashing.org>
 <CAK8P3a39=PVpwiSk_3CjRnYBawhXqMatHKSsHCd2KHCgR+Zmyg@mail.gmail.com>
 <20180112204154.GM21977@gate.crashing.org>
 <CAK8P3a2YVVseBFNoDbwOtqR3-JHFuZ-WZD6-PzztNTO_X_soaw@mail.gmail.com>
 <20180112214111.GQ21977@gate.crashing.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Jan 2018 22:45:31 +0100
Message-ID: <CAK8P3a3XKwrVpXH9=8n1=qAKtqHE+1sh6OhaJ_39GZcWSP-j=Q@mail.gmail.com>
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

On Fri, Jan 12, 2018 at 10:41 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Fri, Jan 12, 2018 at 10:29:01PM +0100, Arnd Bergmann wrote:
>> On Fri, Jan 12, 2018 at 9:41 PM, Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>> > On Fri, Jan 12, 2018 at 08:43:21PM +0100, Arnd Bergmann wrote:
>> >> On Fri, Jan 12, 2018 at 5:39 PM, Segher Boessenkool
>>
>> >> We could theoretically work around it by turning that into
>> >> "#if defined(CONFIG_CC_OPTIMIZE_FOR_SIZE) ||
>> >> defined(CONFIG_CRYPTO_AES)", but that seems rather ugly.
>> >>
>> >> My earlier patch already tried to be more specific, turning very
>> >> specific optimizations off rather than moving from -O2 to -Os,
>> >> but that turned out to lead to significantly worse performance,
>> >> where -Os improved performance slightly. Is there a way
>> >> to ask powerpc compilers to use mostly -Os but not the
>> >> specific thing that makes it link to _restgpr_31_x?
>> >
>> > There is no such thing, sorry.  Would be very hard to implement, and
>> > older compilers will never get it, so it won't help you anyway :-(
>>
>> We use -Os only for gcc-7.1 and higher, where it produces faster
>> code for AES and avoids running into
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83356
>>
>> > Maybe for now just enable it in crtsavres.S always, with a comment?
>> > That -Os workaround is hopefully not going to live long either...
>>
>> It depends on whether or how soon someone comes up with a
>> better fix for PR83356.
>> gcc-8.0.0 is currently not affected by it, so we could limit the
>> workaround (and the hack in crtsavres.S) to gcc-7-only.
>
> I guess you could enable the _x routines whenever you use ubsan?  Ubsan
> will cause much bigger code growth than the handful of insns in those
> routines?

Right, that could work, too. My patch that Herbert merged intentionally
used -Os also for non-UBSAN builds because it turned out to
be much faster (see gcc PR83651), but we could revert that back
to the default and only use the -Os for UBSAN, essentially
addressing only PR83356 but not PR83651.

       Arnd
