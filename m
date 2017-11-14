Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybk3Z2cGszDql4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 21:18:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, linuxppc-dev@lists.ozlabs.org,
 kbuild-all@01.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from
 `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
In-Reply-To: <CAK7LNASo7qBCweTvm=U709DXhayQXajP+3zQ3GnhqkrBkSB8Ow@mail.gmail.com>
References: <201711102336.rokM2O1G%fengguang.wu@intel.com>
 <20171111194540.5f96fe93@roar.ozlabs.ibm.com>
 <CAK7LNASo7qBCweTvm=U709DXhayQXajP+3zQ3GnhqkrBkSB8Ow@mail.gmail.com>
Date: Tue, 14 Nov 2017 21:17:58 +1100
Message-ID: <8760adw4dl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Hi Nicholas,
>
>
> 2017-11-11 17:45 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
>> On Fri, 10 Nov 2017 23:41:49 +0800
>> kbuild test robot <fengguang.wu@intel.com> wrote:
>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   1c9dbd4615fd751e5e0b99807a3c7c8612e28e20
>>> commit: cb87481ee89dbd6609e227afbf64900fb4e5c930 kbuild: linker script do not match C names unless LD_DEAD_CODE_DATA_ELIMINATION is configured
>>> date:   3 months ago
>>> config: powerpc-fsp2_defconfig (attached as .config)
>>> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>>> reproduce:
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         git checkout cb87481ee89dbd6609e227afbf64900fb4e5c930
>>>         # save the attached .config to linux build tree
>>>         make.cross ARCH=powerpc
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>> >> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
>>> >> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
>>> >> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
>>
>> Okay this is not caused by the above patch, it was just hiding it.
>> This should do the trick I think:
>> --
>> powerpc/32: Add .data.rel* sections explicitly
>>
>> Match powerpc/64 and include .data.rel* input sections in the .data output
>> section explicitly.
>>
>> This should solve the warning:
>>
>> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
>>
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
>
> I think this will go to the PPC tree.

Yeah I can take it.

> I will not touch this patch, but
> if necessary, please feel free to add
>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks.

cheers
