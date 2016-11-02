Return-Path: <jim.epost@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8HWm4DgKzDvP5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 06:01:40 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id 128so2451102oih.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 12:01:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87eg2unnil.fsf@concordia.ellerman.id.au>
References: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
 <87wpgp13ki.fsf@concordia.ellerman.id.au>
 <CA+r1ZhiJW6xQ1VwgLudFzFBxkKzkURv7MZhWtmSevRHc9aUyxA@mail.gmail.com>
 <87eg2unnil.fsf@concordia.ellerman.id.au>
From: Jim Davis <jim.epost@gmail.com>
Date: Wed, 2 Nov 2016 12:01:37 -0700
Message-ID: <CA+r1ZhixdKcgKDR3_No_5=M7BFo25M9mwfyxcVMLjfi=8Dtdmg@mail.gmail.com>
Subject: Re: [PATCH] cxl: Fix error handling
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, kernel-janitors@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 2, 2016 at 4:12 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Jim Davis <jim.epost@gmail.com> writes:
>
>> On Sun, Oct 30, 2016 at 10:37 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> More here:
>>>
>>> https://github.com/linuxppc/linux/wiki/Building-powerpc-kernels
>>
>> Cool; the little-endian build worked fine, but
>
> Yay, thanks for trying.
>
>> jim@krebstar:~/linux-rc$ make ARCH=powerpc
>> CROSS_COMPILE=powerpc64-linux-gnu- vmlinux
>> make: powerpc64-linux-gnu-gcc: Command not found
>> make: powerpc64-linux-gnu-gcc: Command not found
>> scripts/kconfig/conf  --silentoldconfig Kconfig
>> make: powerpc64-linux-gnu-gcc: Command not found

But I cleverly tried to run the Fedora command on Ubuntu... when I run
the right command for Ubuntu, the build worked just fine.  D'oh!

Nit: make distclean missed a few files

jim@krebstar:~/linux-rc$ make distclean; git clean -fdx
  CLEAN   .
  CLEAN   drivers/tty/vt
  CLEAN   drivers/video/logo
  CLEAN   firmware
  CLEAN   kernel
  CLEAN   lib
  CLEAN   usr
  CLEAN   .tmp_versions
  CLEAN   scripts/basic
  CLEAN   scripts/dtc
  CLEAN   scripts/genksyms
  CLEAN   scripts/kconfig
  CLEAN   scripts/mod
  CLEAN   scripts
  CLEAN   include/config include/generated arch/powerpc/include/generated
  CLEAN   .config .version Module.symvers
Removing arch/powerpc/kernel/systbl_chk.i
Removing arch/powerpc/kernel/vdso32/vdso32.lds
Removing arch/powerpc/kernel/vdso32/vdso32.so
Removing arch/powerpc/kernel/vdso32/vdso32.so.dbg
Removing arch/powerpc/kernel/vdso64/vdso64.lds
Removing arch/powerpc/kernel/vdso64/vdso64.so
Removing arch/powerpc/kernel/vdso64/vdso64.so.dbg
Removing arch/powerpc/kernel/vmlinux.lds

-- 
Jim
