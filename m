Return-Path: <yamada.masahiro@socionext.com>
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ybDsT0NynzDqff
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 02:22:36 +1100 (AEDT)
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-07.nifty.com
 with ESMTP id vADFFQWu000746
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 00:15:26 +0900
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
 [209.85.161.181]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id vADFF3VK003082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 00:15:03 +0900
Received: by mail-yw0-f181.google.com with SMTP id y75so13690204ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 07:15:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171111194540.5f96fe93@roar.ozlabs.ibm.com>
References: <201711102336.rokM2O1G%fengguang.wu@intel.com>
 <20171111194540.5f96fe93@roar.ozlabs.ibm.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 14 Nov 2017 00:14:22 +0900
Message-ID: <CAK7LNASo7qBCweTvm=U709DXhayQXajP+3zQ3GnhqkrBkSB8Ow@mail.gmail.com>
Subject: Re: powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from
 `arch/powerpc/kernel/head_44x.o' being placed in section
 `.data.rel.ro'.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas,


2017-11-11 17:45 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> On Fri, 10 Nov 2017 23:41:49 +0800
> kbuild test robot <fengguang.wu@intel.com> wrote:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   1c9dbd4615fd751e5e0b99807a3c7c8612e28e20
>> commit: cb87481ee89dbd6609e227afbf64900fb4e5c930 kbuild: linker script do not match C names unless LD_DEAD_CODE_DATA_ELIMINATION is configured
>> date:   3 months ago
>> config: powerpc-fsp2_defconfig (attached as .config)
>> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout cb87481ee89dbd6609e227afbf64900fb4e5c930
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=powerpc
>>
>> All warnings (new ones prefixed by >>):
>>
>> >> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
>> >> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
>> >> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
>
> Okay this is not caused by the above patch, it was just hiding it.
> This should do the trick I think:
> --
> powerpc/32: Add .data.rel* sections explicitly
>
> Match powerpc/64 and include .data.rel* input sections in the .data output
> section explicitly.
>
> This should solve the warning:
>
> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


I think this will go to the PPC tree.

I will not touch this patch, but
if necessary, please feel free to add

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 0494e1566ee2..51e4ec92ade1 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -264,6 +264,7 @@ SECTIONS
>  #ifdef CONFIG_PPC32
>         .data : AT(ADDR(.data) - LOAD_OFFSET) {
>                 DATA_DATA
> +               *(.data.rel*)
>                 *(.sdata)
>                 *(.sdata2)
>                 *(.got.plt) *(.got)
> --
> 2.15.0
>



-- 
Best Regards
Masahiro Yamada
