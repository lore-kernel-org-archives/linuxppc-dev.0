Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id D3BAEB70FD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 21:40:51 +1000 (EST)
Received: by wwa36 with SMTP id 36so2777028wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Oct 2010 04:40:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1285916771-18033-2-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-2-git-send-email-imunsie@au1.ibm.com>
Date: Fri, 1 Oct 2010 07:40:49 -0400
Message-ID: <AANLkTimdV2FTEhcKXcM_+k23PBFTR5KvyjqEGxzzX72Q@mail.gmail.com>
Subject: Re: [PATCH 01/18] powerpc: Add ability to build little endian kernels
From: Josh Boyer <jwboyer@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 1, 2010 at 3:05 AM, Ian Munsie <imunsie@au1.ibm.com> wrote:
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platfo=
rms/Kconfig.cputype
> index d361f81..074ff12 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -329,3 +329,19 @@ config CHECK_CACHE_COHERENCY
> =A0 =A0 =A0 =A0bool
>
> =A0endmenu
> +
> +config ARCH_SUPPORTS_LITTLE_ENDIAN
> + =A0 =A0 =A0 bool
> +
> +config CPU_LITTLE_ENDIAN
> + =A0 =A0 =A0 bool "Build little endian kernel"
> + =A0 =A0 =A0 depends on ARCH_SUPPORTS_LITTLE_ENDIAN && EXPERIMENTAL
> + =A0 =A0 =A0 default n
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This option selects whether a big endian or little endi=
an kernel will
> + =A0 =A0 =A0 =A0 be built.
> +
> + =A0 =A0 =A0 =A0 Note that if building a little endian kernel, CROSS_COM=
PILE must
> + =A0 =A0 =A0 =A0 point to a toolchain capable of targetting little endia=
n powerpc,
> + =A0 =A0 =A0 =A0 while the toolchain specified by CROSS32_COMPILE must b=
e capable of
> + =A0 =A0 =A0 =A0 targetting *BIG* endian PowerPC.

Have you tested this support with a userspace containing floating
point instructions?  I wonder if CONFIG_MATH_EMULATION is going to
need work at all, and if the boards with an actual FPU (440EP, 440EPx,
460EX, etc) would have issues.

josh
