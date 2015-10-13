Return-Path: <olof@lixom.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52C0A1A076B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 08:02:35 +1100 (AEDT)
Received: from mail-yk0-f175.google.com (mail-yk0-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C54F0140F99
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 08:02:34 +1100 (AEDT)
Received: by ykoo7 with SMTP id o7so29587664yko.0
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 14:02:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151002074708.CF4DC14076A@ozlabs.org>
References: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
 <20151002074708.CF4DC14076A@ozlabs.org>
Date: Tue, 13 Oct 2015 14:02:32 -0700
Message-ID: <CAOesGMjDC99RFEenyUqc2uhpT9EhqhevrqxiO5Gd7AN_GWmrkg@mail.gmail.com>
Subject: Re: [RFC, 1/2] scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG to be
 a target
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mmarek@suse.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 yann.morin.1998@free.fr,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 2, 2015 at 12:47 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Wed, 2015-23-09 at 05:40:34 UTC, Michael Ellerman wrote:
>> Arch Makefiles can set KBUILD_DEFCONFIG to tell kbuild the name of the
>> defconfig that should be built by default.
>>
>> However currently there is an assumption that KBUILD_DEFCONFIG points to
>> a file at arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG).
>>
>> We would like to use a target, using merge_config, as our defconfig, so
>> adapt the logic in scripts/kconfig/Makefile to allow that.
>>
>> To minimise the chance of breaking anything, we first check if
>> KBUILD_DEFCONFIG is a file, and if so we do the old logic. If it's not a
>> file, then we call the top-level Makefile with KBUILD_DEFCONFIG as the
>> target.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> Acked-by: Michal Marek <mmarek@suse.com>
>
> Applied to powerpc next.
>
> https://git.kernel.org/powerpc/c/d2036f30cfe1daa19e63ce75

This breaks arm64 defconfig for me:

mkdir obj-tmp
make -f Makefile O=obj-tmp ARCH=arm64 defconfig
... watch loop of:
*** Default configuration is based on target 'defconfig'
  GEN     ./Makefile



-Olof
