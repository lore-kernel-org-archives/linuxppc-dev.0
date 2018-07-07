Return-Path: <rdunlap@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41NFBR3HTWzDqv6
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jul 2018 00:59:58 +1000 (AEST)
Subject: Re: powerpc: 32BIT vs. 64BIT (PPC32 vs. PPC64)
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
 <a3c9b9ee9ec116390c47dca65fcf14f138eccd3f.camel@kernel.crashing.org>
 <4f3a5969-88d5-134d-508d-7617947c588c@infradead.org>
 <20180707221316.5b75e075@roar.ozlabs.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0a17b80-6384-7437-045c-3688d9e5e7f9@infradead.org>
Date: Sat, 7 Jul 2018 07:59:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180707221316.5b75e075@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2018 05:13 AM, Nicholas Piggin wrote:
> On Fri, 6 Jul 2018 21:58:29 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 07/06/2018 06:45 PM, Benjamin Herrenschmidt wrote:
>>> On Thu, 2018-07-05 at 14:30 -0700, Randy Dunlap wrote:  
>>>> Hi,
>>>>
>>>> Is there a good way (or a shortcut) to do something like:
>>>>
>>>> $ make ARCH=powerpc O=PPC32 [other_options] allmodconfig
>>>>   to get a PPC32/32BIT allmodconfig
>>>>
>>>> and also be able to do:
>>>>
>>>> $make ARCH=powerpc O=PPC64 [other_options] allmodconfig
>>>>   to get a PPC64/64BIT allmodconfig?  
>>>
>>> Hrm... O= is for the separate build dir, so there much be something
>>> else.
>>>
>>> You mean having ARCH= aliases like ppc/ppc32 and ppc64 ?  
>>
>> Yes.
>>
>>> That would be a matter of overriding some .config defaults I suppose, I
>>> don't know how this is done on other archs.
>>>
>>> I see the aliasing trick in the Makefile but that's about it.
>>>   
>>>> Note that arch/x86, arch/sh, and arch/sparc have ways to do
>>>> some flavor(s) of this (from Documentation/kbuild/kbuild.txt;
>>>> sh and sparc based on a recent "fix" patch from me):  
>>>
>>> I fail to see what you are actually talking about here ... sorry. Do
>>> you have concrete examples on x86 or sparc ? From what I can tell the
>>> "i386" or "sparc32/sparc64" aliases just change SRCARCH in Makefile and
>>> 32 vs 64-bit is just a Kconfig option...  
>>
>> Yes, your summary is mostly correct.
>>
>> I'm just looking for a way to do cross-compile builds that are close to
>> ppc32 allmodconfig and ppc64 allmodconfig.
> 
> Would there a problem with adding ARCH=ppc32 / ppc64 matching? This
> seems to work...
> 
> Thanks,
> Nick

Yes, this mostly works and is similar to a patch (my patch) on my test machine.
And they both work for allmodconfig, which is my primary build target.

And they both have one little quirk that is confusing when the build target
is defconfig:

When ARCH=ppc32, the terminal output (stdout) is: (using O=PPC32)

make[1]: Entering directory '/home/rdunlap/lnx/lnx-418-rc3/PPC32'
  GEN     ./Makefile
*** Default configuration is based on 'ppc64_defconfig'   <<<<< NOTE <<<<<
#
# configuration written to .config
#
make[1]: Leaving directory '/home/rdunlap/lnx/lnx-418-rc3/PPC32'


I expect that can be fixed also.  :)

And the written .config file is indeed for 32BIT, not 64BIT.

Thanks, Nick.

> ---
>  Makefile                               | 8 ++++++++
>  arch/powerpc/Kconfig                   | 9 +++++++++
>  arch/powerpc/platforms/Kconfig.cputype | 8 --------
>  3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c5ce55cbc543..f97204aed17a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -345,6 +345,14 @@ ifeq ($(ARCH),sh64)
>         SRCARCH := sh
>  endif
>  
> +# Additional ARCH settings for powerpc
> +ifeq ($(ARCH),ppc32)
> +       SRCARCH := powerpc
> +endif
> +ifeq ($(ARCH),ppc64)
> +       SRCARCH := powerpc
> +endif
> +
>  KCONFIG_CONFIG	?= .config
>  export KCONFIG_CONFIG
>  
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9f2b75fe2c2d..3405b1b122be 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -1,4 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +config PPC64
> +	bool "64-bit kernel" if "$(ARCH)" = "powerpc"
> +	default "$(ARCH)" != "ppc32"
> +	select ZLIB_DEFLATE
> +	help
> +	  This option selects whether a 32-bit or a 64-bit kernel
> +	  will be built.
> +
>  source "arch/powerpc/platforms/Kconfig.cputype"
>  
>  config PPC32
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index e6a1de521319..f6e5d6ef9782 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -1,12 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -config PPC64
> -	bool "64-bit kernel"
> -	default n
> -	select ZLIB_DEFLATE
> -	help
> -	  This option selects whether a 32-bit or a 64-bit kernel
> -	  will be built.
> -
>  menu "Processor support"
>  choice
>  	prompt "Processor Type"
> 


-- 
~Randy
