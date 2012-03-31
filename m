Return-Path: <linasvepstas@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 86987B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 05:58:11 +1000 (EST)
Received: by laap9 with SMTP id p9so1856129laa.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 12:58:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120331163321.GA15809@linux.vnet.ibm.com>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Sat, 31 Mar 2012 14:57:46 -0500
Message-ID: <CAHrUA35Bz68DtP-Znr=-+U+6P9CONXzN=9JdMXRfRwmVV9fy=Q@mail.gmail.com>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
To: paulmck@linux.vnet.ibm.com
Content-Type: multipart/alternative; boundary=f46d040713dd2d7cb504bc8f6081
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, dhowells@redhat.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux@arm.linux.org.uk,
 linux-hexagon@vger.kernel.org, x86@kernel.org, jejb@parisc-linux.org,
 cmetcalf@tilera.com, uclinux-dist-devel@blackfin.uclinux.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-m32r@ml.linux-m32r.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d040713dd2d7cb504bc8f6081
Content-Type: text/plain; charset=UTF-8

Hi,

I didn't actually try to compile the patch below; it didn't look like C
code so I wasn't sure what compiler to run it through.  I guess maybe its
python?  However, I'm very sure that the patches are completely correct,
because I read them, and I also know that Paul is a trustworthy programmer.
 Thus, please add my ack

Ack'ed by: Linas Vepstas <linasvepstas@gmail.com>


On 31 March 2012 11:33, Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Although there have been numerous complaints about the complexity of
> parallel programming (especially over the past 5-10 years), the plain
> truth is that the incremental complexity of parallel programming over
> that of sequential programming is not as large as is commonly believed.
> Despite that you might have heard, the mind-numbing complexity of modern
> computer systems is not due so much to there being multiple CPUs, but
> rather to there being any CPUs at all.  In short, for the ultimate in
> computer-system simplicity, the optimal choice is NR_CPUS=0.
>
> This commit therefore limits kernel builds to zero CPUs.  This change
> has the beneficial side effect of rendering all kernel bugs harmless.
> Furthermore, this commit enables additional beneficial changes, for
> example, the removal of those parts of the kernel that are not needed
> when there are zero CPUs.
>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>
>  alpha/Kconfig                     |   11 ++++++-----
>  arm/Kconfig                       |    6 +++---
>  blackfin/Kconfig                  |    3 ++-
>  hexagon/Kconfig                   |    9 +++++----
>  ia64/Kconfig                      |    9 +++++----
>  m32r/Kconfig                      |   10 ++++++----
>  mips/Kconfig                      |   21 +++++++++++----------
>  mn10300/Kconfig                   |    3 ++-
>  parisc/Kconfig                    |    6 +++---
>  powerpc/platforms/Kconfig.cputype |    8 ++++----
>  s390/Kconfig                      |   12 +++++++-----
>  sh/Kconfig                        |   11 ++++++-----
>  sparc/Kconfig                     |    8 ++++----
>  tile/Kconfig                      |    9 +++++----
>  x86/Kconfig                       |   16 +++++++++-------
>  15 files changed, 78 insertions(+), 64 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 56a4df9..1766b4a 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -541,14 +541,15 @@ config HAVE_DEC_LOCK
>        default y
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-32)"
> -       range 2 32
> +       int "Maximum number of CPUs (0-0)"
> +       range 0 0
>        depends on SMP
> -       default "32" if ALPHA_GENERIC || ALPHA_MARVEL
> -       default "4" if !ALPHA_GENERIC && !ALPHA_MARVEL
> +       default "0" if ALPHA_GENERIC || ALPHA_MARVEL
> +       default "0" if !ALPHA_GENERIC && !ALPHA_MARVEL
>        help
>          MARVEL support can handle a maximum of 32 CPUs, all the others
> -          with working support have a maximum of 4 CPUs.
> +          with working support have a maximum of 4 CPUs.  But why take
> +         chances?  Just stick with zero CPUs.
>
>  config ARCH_DISCONTIGMEM_ENABLE
>        bool "Discontiguous Memory Support (EXPERIMENTAL)"
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a48aecc..1f07a3a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1551,10 +1551,10 @@ config PAGE_OFFSET
>        default 0xC0000000
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-32)"
> -       range 2 32
> +       int "Maximum number of CPUs (0-0)"
> +       range 0 0
>        depends on SMP
> -       default "4"
> +       default "0"
>
>  config HOTPLUG_CPU
>        bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
> index abe5a9e..6a78549 100644
> --- a/arch/blackfin/Kconfig
> +++ b/arch/blackfin/Kconfig
> @@ -241,7 +241,8 @@ config SMP
>  config NR_CPUS
>        int
>        depends on SMP
> -       default 2 if BF561
> +       range 0 0
> +       default 0 if BF561
>
>  config HOTPLUG_CPU
>        bool "Support for hot-pluggable CPUs"
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index 9059e39..daab009 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -158,13 +158,14 @@ config SMP
>
>  config NR_CPUS
>        int "Maximum number of CPUs" if SMP
> -       range 2 6 if SMP
> -       default "1" if !SMP
> -       default "6" if SMP
> +       range 0 0 if SMP
> +       default "0" if !SMP
> +       default "0" if SMP
>        ---help---
>          This allows you to specify the maximum number of CPUs which this
>          kernel will support.  The maximum supported value is 6 and the
> -         minimum value which makes sense is 2.
> +         minimum value which makes sense is 2.  But a limit of zero is
> +         so much safer!
>
>          This is purely to save memory - each supported CPU adds
>          approximately eight kilobytes to the kernel image.
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index bd72669..fea0e6d 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -373,16 +373,17 @@ config SMP
>          If you don't know what to do here, say N.
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-4096)"
> -       range 2 4096
> +       int "Maximum number of CPUs (0-0)"
> +       range 0 0
>        depends on SMP
> -       default "4096"
> +       default "0"
>        help
>          You should set this to the number of CPUs in your system, but
>          keep in mind that a kernel compiled for, e.g., 2 CPUs will boot
> but
>          only use 2 CPUs on a >2 CPU system.  Setting this to a value
> larger
>          than 64 will cause the use of a CPU mask array, causing a small
> -         performance hit.
> +         performance hit.  And setting it larger than zero risks all
> +         manner of software bugs, so we just play it safe.
>
>  config HOTPLUG_CPU
>        bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
> index ef80a65..68b9e88 100644
> --- a/arch/m32r/Kconfig
> +++ b/arch/m32r/Kconfig
> @@ -300,14 +300,16 @@ config CHIP_M32700_TS1
>        default n
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-32)"
> -       range 2 32
> +       int "Maximum number of CPUs (0-0)"
> +       range 0 0
>        depends on SMP
> -       default "2"
> +       default "0"
>        help
>          This allows you to specify the maximum number of CPUs which this
>          kernel will support.  The maximum supported value is 32 and the
> -         minimum value which makes sense is 2.
> +         minimum value which makes sense is 2.  Zero may not make sense,
> +         but given that there is much in this world that does not make
> +         sense, zero it is!
>
>          This is purely to save memory - each supported CPU adds
>          approximately eight kilobytes to the kernel image.
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5ab6e89..3d7d06c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2192,16 +2192,16 @@ config NR_CPUS_DEFAULT_64
>        bool
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-64)"
> -       range 1 64 if NR_CPUS_DEFAULT_1
> +       int "Maximum number of CPUs (0-0)"
> +       range 0 0 if NR_CPUS_DEFAULT_1
>        depends on SMP
> -       default "1" if NR_CPUS_DEFAULT_1
> -       default "2" if NR_CPUS_DEFAULT_2
> -       default "4" if NR_CPUS_DEFAULT_4
> -       default "8" if NR_CPUS_DEFAULT_8
> -       default "16" if NR_CPUS_DEFAULT_16
> -       default "32" if NR_CPUS_DEFAULT_32
> -       default "64" if NR_CPUS_DEFAULT_64
> +       default "0" if NR_CPUS_DEFAULT_1
> +       default "0" if NR_CPUS_DEFAULT_2
> +       default "0" if NR_CPUS_DEFAULT_4
> +       default "0" if NR_CPUS_DEFAULT_8
> +       default "0" if NR_CPUS_DEFAULT_16
> +       default "0" if NR_CPUS_DEFAULT_32
> +       default "0" if NR_CPUS_DEFAULT_64
>        help
>          This allows you to specify the maximum number of CPUs which this
>          kernel will support.  The maximum supported value is 32 for 32-bit
> @@ -2212,7 +2212,8 @@ config NR_CPUS
>          This is purely to save memory - each supported CPU adds
>          approximately eight kilobytes to the kernel image.  For best
>          performance should round up your number of processors to the next
> -         power of two.
> +         power of two.  And just think how much more memory we will
> +         save by setting the limit to zero!
>
>  source "kernel/time/Kconfig"
>
> diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
> index 8f1c40d..85fc112 100644
> --- a/arch/mn10300/Kconfig
> +++ b/arch/mn10300/Kconfig
> @@ -201,7 +201,8 @@ config SMP
>  config NR_CPUS
>        int
>        depends on SMP
> -       default "2"
> +       range 0 0
> +       default "0"
>
>  source "kernel/Kconfig.preempt"
>
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 242a1b7..358eaf8 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -254,10 +254,10 @@ config HPUX
>        depends on !64BIT
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-32)"
> -       range 2 32
> +       int "Maximum number of CPUs (0-0)"
> +       range 0 0
>        depends on SMP
> -       default "32"
> +       default "0"
>
>  endmenu
>
> diff --git a/arch/powerpc/platforms/Kconfig.cputype
> b/arch/powerpc/platforms/Kconfig.cputype
> index 425db18..5e607e0 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -356,11 +356,11 @@ config SMP
>          If you don't know what to do here, say N.
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-8192)"
> -       range 2 8192
> +       int "Maximum number of CPUs (0-0)"
> +       range 0 0
>        depends on SMP
> -       default "32" if PPC64
> -       default "4"
> +       default "0" if PPC64
> +       default "0"
>
>  config NOT_COHERENT_CACHE
>        bool
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index d172758..f9bc067 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -169,15 +169,17 @@ config SMP
>          Even if you don't know what to do here, say Y.
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-64)"
> -       range 2 64
> +       int "Maximum number of CPUs (0-0)"
> +       range 0 0
>        depends on SMP
> -       default "32" if !64BIT
> -       default "64" if 64BIT
> +       default "0" if !64BIT
> +       default "0" if 64BIT
>        help
>          This allows you to specify the maximum number of CPUs which this
>          kernel will support.  The maximum supported value is 64 and the
> -         minimum value which makes sense is 2.
> +         minimum value which makes sense is 2.  The minimal value that
> +         makes sense might well be 2, but we all know that the only
> +         -sane- value is zero!
>
>          This is purely to save memory - each supported CPU adds
>          approximately sixteen kilobytes to the kernel image.
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 713fb58..5ddc7c0 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -705,18 +705,19 @@ config SMP
>          If you don't know what to do here, say N.
>
>  config NR_CPUS
> -       int "Maximum number of CPUs (2-32)"
> -       range 2 32
> +       int "Maximum number of CPUs (0-0)"
> +       range 0 0
>        depends on SMP
> -       default "4" if CPU_SUBTYPE_SHX3
> -       default "2"
> +       default "0" if CPU_SUBTYPE_SHX3
> +       default "0"
>        help
>          This allows you to specify the maximum number of CPUs which this
>          kernel will support.  The maximum supported value is 32 and the
>          minimum value which makes sense is 2.
>
>          This is purely to save memory - each supported CPU adds
> -         approximately eight kilobytes to the kernel image.
> +         approximately eight kilobytes to the kernel image.  Debloating
> +         is the way, NR_CPUS to zero today!!!
>
>  config HOTPLUG_CPU
>        bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index ca5580e..0de9f0f 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -177,10 +177,10 @@ config SMP
>  config NR_CPUS
>        int "Maximum number of CPUs"
>        depends on SMP
> -       range 2 32 if SPARC32
> -       range 2 1024 if SPARC64
> -       default 32 if SPARC32
> -       default 64 if SPARC64
> +       range 0 0 if SPARC32
> +       range 0 0 if SPARC64
> +       default 0 if SPARC32
> +       default 0 if SPARC64
>
>  source kernel/Kconfig.hz
>
> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> index 11270ca..a05112c 100644
> --- a/arch/tile/Kconfig
> +++ b/arch/tile/Kconfig
> @@ -126,14 +126,15 @@ source "init/Kconfig"
>  menu "Tilera-specific configuration"
>
>  config NR_CPUS
> -       int "Maximum number of tiles (2-255)"
> -       range 2 255
> +       int "Maximum number of tiles (0-0)"
> +       range 0 0
>        depends on SMP
> -       default "64"
> +       default "0"
>        ---help---
>          Building with 64 is the recommended value, but a slightly
>          smaller kernel memory footprint results from using a smaller
> -         value on chips with fewer tiles.
> +         value on chips with fewer tiles.  To minimize both memory
> +         footprint and bugs, use zero and only zero.
>
>  source "kernel/time/Kconfig"
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5bed94e..a6977f2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -773,19 +773,21 @@ config MAXSMP
>
>  config NR_CPUS
>        int "Maximum number of CPUs" if SMP && !MAXSMP
> -       range 2 8 if SMP && X86_32 && !X86_BIGSMP
> -       range 2 512 if SMP && !MAXSMP
> -       default "1" if !SMP
> -       default "4096" if MAXSMP
> -       default "32" if SMP && (X86_NUMAQ || X86_SUMMIT || X86_BIGSMP ||
> X86_ES7000)
> -       default "8" if SMP
> +       range 0 0 if SMP && X86_32 && !X86_BIGSMP
> +       range 0 0 if SMP && !MAXSMP
> +       default "0" if !SMP
> +       default "0" if MAXSMP
> +       default "0" if SMP && (X86_NUMAQ || X86_SUMMIT || X86_BIGSMP ||
> X86_ES7000)
> +       default "0" if SMP
>        ---help---
>          This allows you to specify the maximum number of CPUs which this
>          kernel will support.  The maximum supported value is 512 and the
>          minimum value which makes sense is 2.
>
>          This is purely to save memory - each supported CPU adds
> -         approximately eight kilobytes to the kernel image.
> +         approximately eight kilobytes to the kernel image.  But
> +         the first supported CPU brings a lot of bugs with it, so
> +         for ultimate reliability, set the number of CPUs to zero.
>
>  config SCHED_SMT
>        bool "SMT (Hyperthreading) scheduler support"
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hexagon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--f46d040713dd2d7cb504bc8f6081
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div><br></div><div>I didn&#39;t actually try to compile the =
patch below; it didn&#39;t look like C code so I wasn&#39;t sure what compi=
ler to run it through. =C2=A0I guess maybe its python? =C2=A0However, I&#39=
;m very sure that the patches are completely correct, because I read them, =
and I also know that Paul is a trustworthy programmer. =C2=A0Thus, please a=
dd my ack</div>

<div><br></div>Ack&#39;ed by: Linas Vepstas &lt;<a href=3D"mailto:linasveps=
tas@gmail.com">linasvepstas@gmail.com</a>&gt;<br><br><br><div class=3D"gmai=
l_quote">On 31 March 2012 11:33, Paul E. McKenney <span dir=3D"ltr">&lt;<a =
href=3D"mailto:paulmck@linux.vnet.ibm.com">paulmck@linux.vnet.ibm.com</a>&g=
t;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Although there have been numerous complaints=
 about the complexity of<br>
parallel programming (especially over the past 5-10 years), the plain<br>
truth is that the incremental complexity of parallel programming over<br>
that of sequential programming is not as large as is commonly believed.<br>
Despite that you might have heard, the mind-numbing complexity of modern<br=
>
computer systems is not due so much to there being multiple CPUs, but<br>
rather to there being any CPUs at all. =C2=A0In short, for the ultimate in<=
br>
computer-system simplicity, the optimal choice is NR_CPUS=3D0.<br>
<br>
This commit therefore limits kernel builds to zero CPUs. =C2=A0This change<=
br>
has the beneficial side effect of rendering all kernel bugs harmless.<br>
Furthermore, this commit enables additional beneficial changes, for<br>
example, the removal of those parts of the kernel that are not needed<br>
when there are zero CPUs.<br>
<br>
Signed-off-by: Paul E. McKenney &lt;<a href=3D"mailto:paulmck@linux.vnet.ib=
m.com">paulmck@linux.vnet.ibm.com</a>&gt;<br>
Reviewed-by: Thomas Gleixner &lt;<a href=3D"mailto:tglx@linutronix.de">tglx=
@linutronix.de</a>&gt;<br>
---<br>
<br>
=C2=A0alpha/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 11 ++++++-----<br>
=C2=A0arm/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +++---<br>
=C2=A0blackfin/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A03 ++-<br>
=C2=A0hexagon/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A09 +++++----<br>
=C2=A0ia64/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 +++++----<br>
=C2=A0m32r/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 10 ++++++----<br>
=C2=A0mips/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 21 +++++++++++----------<br>
=C2=A0mn10300/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A03 ++-<br>
=C2=A0parisc/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 +++---<br>
=C2=A0powerpc/platforms/Kconfig.cputype | =C2=A0 =C2=A08 ++++----<br>
=C2=A0s390/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 12 +++++++-----<br>
=C2=A0sh/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 11 ++++++-----<br>
=C2=A0sparc/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A08 ++++----<br>
=C2=A0tile/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 +++++----<br>
=C2=A0x86/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 16 +++++++++-------<br>
=C2=A015 files changed, 78 insertions(+), 64 deletions(-)<br>
<br>
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig<br>
index 56a4df9..1766b4a 100644<br>
--- a/arch/alpha/Kconfig<br>
+++ b/arch/alpha/Kconfig<br>
@@ -541,14 +541,15 @@ config HAVE_DEC_LOCK<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0default y<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (2-32)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 32<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;32&quot; if ALPHA_GENERIC || ALPHA_MAR=
VEL<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;4&quot; if !ALPHA_GENERIC &amp;&amp; !=
ALPHA_MARVEL<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if ALPHA_GENERIC || ALPHA_MARV=
EL<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if !ALPHA_GENERIC &amp;&amp; !=
ALPHA_MARVEL<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MARVEL support can handle a maximum of 3=
2 CPUs, all the others<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with working support have a maximum of =
4 CPUs.<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with working support have a maximum of =
4 CPUs. =C2=A0But why take<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 chances? =C2=A0Just stick with zero CPUs.<br>
<br>
=C2=A0config ARCH_DISCONTIGMEM_ENABLE<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Discontiguous Memory Support (EXPERI=
MENTAL)&quot;<br>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig<br>
index a48aecc..1f07a3a 100644<br>
--- a/arch/arm/Kconfig<br>
+++ b/arch/arm/Kconfig<br>
@@ -1551,10 +1551,10 @@ config PAGE_OFFSET<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0default 0xC0000000<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (2-32)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 32<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;4&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot;<br>
<br>
=C2=A0config HOTPLUG_CPU<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Support for hot-pluggable CPUs (EXPE=
RIMENTAL)&quot;<br>
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig<br>
index abe5a9e..6a78549 100644<br>
--- a/arch/blackfin/Kconfig<br>
+++ b/arch/blackfin/Kconfig<br>
@@ -241,7 +241,8 @@ config SMP<br>
=C2=A0config NR_CPUS<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default 2 if BF561<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
+ =C2=A0 =C2=A0 =C2=A0 default 0 if BF561<br>
<br>
=C2=A0config HOTPLUG_CPU<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Support for hot-pluggable CPUs&quot;=
<br>
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig<br>
index 9059e39..daab009 100644<br>
--- a/arch/hexagon/Kconfig<br>
+++ b/arch/hexagon/Kconfig<br>
@@ -158,13 +158,14 @@ config SMP<br>
<br>
=C2=A0config NR_CPUS<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int &quot;Maximum number of CPUs&quot; if SMP<b=
r>
- =C2=A0 =C2=A0 =C2=A0 range 2 6 if SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;1&quot; if !SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;6&quot; if SMP<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0 if SMP<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if !SMP<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if SMP<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0---help---<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This allows you to specify the maximum n=
umber of CPUs which this<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel will support. =C2=A0The maximum s=
upported value is 6 and the<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum value which makes sense is 2.<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum value which makes sense is 2. =C2=A0B=
ut a limit of zero is<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 so much safer!<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is purely to save memory - each sup=
ported CPU adds<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0approximately eight kilobytes to the ker=
nel image.<br>
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig<br>
index bd72669..fea0e6d 100644<br>
--- a/arch/ia64/Kconfig<br>
+++ b/arch/ia64/Kconfig<br>
@@ -373,16 +373,17 @@ config SMP<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you don&#39;t know what to do here, s=
ay N.<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (2-4096)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 4096<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;4096&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0You should set this to the number of CPU=
s in your system, but<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keep in mind that a kernel compiled for,=
 e.g., 2 CPUs will boot but<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0only use 2 CPUs on a &gt;2 CPU system. =
=C2=A0Setting this to a value larger<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0than 64 will cause the use of a CPU mask=
 array, causing a small<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 performance hit.<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 performance hit. =C2=A0And setting it larger =
than zero risks all<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 manner of software bugs, so we just play it s=
afe.<br>
<br>
=C2=A0config HOTPLUG_CPU<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Support for hot-pluggable CPUs (EXPE=
RIMENTAL)&quot;<br>
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig<br>
index ef80a65..68b9e88 100644<br>
--- a/arch/m32r/Kconfig<br>
+++ b/arch/m32r/Kconfig<br>
@@ -300,14 +300,16 @@ config CHIP_M32700_TS1<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0default n<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (2-32)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 32<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;2&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This allows you to specify the maximum n=
umber of CPUs which this<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel will support. =C2=A0The maximum s=
upported value is 32 and the<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum value which makes sense is 2.<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum value which makes sense is 2. =C2=A0Z=
ero may not make sense,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 but given that there is much in this world th=
at does not make<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 sense, zero it is!<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is purely to save memory - each sup=
ported CPU adds<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0approximately eight kilobytes to the ker=
nel image.<br>
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig<br>
index 5ab6e89..3d7d06c 100644<br>
--- a/arch/mips/Kconfig<br>
+++ b/arch/mips/Kconfig<br>
@@ -2192,16 +2192,16 @@ config NR_CPUS_DEFAULT_64<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (2-64)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 1 64 if NR_CPUS_DEFAULT_1<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0 if NR_CPUS_DEFAULT_1<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;1&quot; if NR_CPUS_DEFAULT_1<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;2&quot; if NR_CPUS_DEFAULT_2<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;4&quot; if NR_CPUS_DEFAULT_4<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;8&quot; if NR_CPUS_DEFAULT_8<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;16&quot; if NR_CPUS_DEFAULT_16<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;32&quot; if NR_CPUS_DEFAULT_32<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;64&quot; if NR_CPUS_DEFAULT_64<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if NR_CPUS_DEFAULT_1<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if NR_CPUS_DEFAULT_2<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if NR_CPUS_DEFAULT_4<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if NR_CPUS_DEFAULT_8<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if NR_CPUS_DEFAULT_16<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if NR_CPUS_DEFAULT_32<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if NR_CPUS_DEFAULT_64<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This allows you to specify the maximum n=
umber of CPUs which this<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel will support. =C2=A0The maximum s=
upported value is 32 for 32-bit<br>
@@ -2212,7 +2212,8 @@ config NR_CPUS<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is purely to save memory - each sup=
ported CPU adds<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0approximately eight kilobytes to the ker=
nel image. =C2=A0For best<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0performance should round up your number =
of processors to the next<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 power of two.<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 power of two. =C2=A0And just think how much m=
ore memory we will<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 save by setting the limit to zero!<br>
<br>
=C2=A0source &quot;kernel/time/Kconfig&quot;<br>
<br>
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig<br>
index 8f1c40d..85fc112 100644<br>
--- a/arch/mn10300/Kconfig<br>
+++ b/arch/mn10300/Kconfig<br>
@@ -201,7 +201,8 @@ config SMP<br>
=C2=A0config NR_CPUS<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;2&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot;<br>
<br>
=C2=A0source &quot;kernel/Kconfig.preempt&quot;<br>
<br>
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig<br>
index 242a1b7..358eaf8 100644<br>
--- a/arch/parisc/Kconfig<br>
+++ b/arch/parisc/Kconfig<br>
@@ -254,10 +254,10 @@ config HPUX<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on !64BIT<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (2-32)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 32<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;32&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot;<br>
<br>
=C2=A0endmenu<br>
<br>
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platform=
s/Kconfig.cputype<br>
index 425db18..5e607e0 100644<br>
--- a/arch/powerpc/platforms/Kconfig.cputype<br>
+++ b/arch/powerpc/platforms/Kconfig.cputype<br>
@@ -356,11 +356,11 @@ config SMP<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you don&#39;t know what to do here, s=
ay N.<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (2-8192)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 8192<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;32&quot; if PPC64<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;4&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if PPC64<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot;<br>
<br>
=C2=A0config NOT_COHERENT_CACHE<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig<br>
index d172758..f9bc067 100644<br>
--- a/arch/s390/Kconfig<br>
+++ b/arch/s390/Kconfig<br>
@@ -169,15 +169,17 @@ config SMP<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Even if you don&#39;t know what to do he=
re, say Y.<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (2-64)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 64<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;32&quot; if !64BIT<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;64&quot; if 64BIT<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if !64BIT<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if 64BIT<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This allows you to specify the maximum n=
umber of CPUs which this<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel will support. =C2=A0The maximum s=
upported value is 64 and the<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum value which makes sense is 2.<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 minimum value which makes sense is 2. =C2=A0T=
he minimal value that<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 makes sense might well be 2, but we all know =
that the only<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 -sane- value is zero!<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is purely to save memory - each sup=
ported CPU adds<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0approximately sixteen kilobytes to the k=
ernel image.<br>
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig<br>
index 713fb58..5ddc7c0 100644<br>
--- a/arch/sh/Kconfig<br>
+++ b/arch/sh/Kconfig<br>
@@ -705,18 +705,19 @@ config SMP<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you don&#39;t know what to do here, s=
ay N.<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (2-32)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 32<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of CPUs (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;4&quot; if CPU_SUBTYPE_SHX3<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;2&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if CPU_SUBTYPE_SHX3<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This allows you to specify the maximum n=
umber of CPUs which this<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel will support. =C2=A0The maximum s=
upported value is 32 and the<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0minimum value which makes sense is 2.<br=
>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is purely to save memory - each sup=
ported CPU adds<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 approximately eight kilobytes to the kernel i=
mage.<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 approximately eight kilobytes to the kernel i=
mage. =C2=A0Debloating<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 is the way, NR_CPUS to zero today!!!<br>
<br>
=C2=A0config HOTPLUG_CPU<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Support for hot-pluggable CPUs (EXPE=
RIMENTAL)&quot;<br>
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig<br>
index ca5580e..0de9f0f 100644<br>
--- a/arch/sparc/Kconfig<br>
+++ b/arch/sparc/Kconfig<br>
@@ -177,10 +177,10 @@ config SMP<br>
=C2=A0config NR_CPUS<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int &quot;Maximum number of CPUs&quot;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 32 if SPARC32<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 1024 if SPARC64<br>
- =C2=A0 =C2=A0 =C2=A0 default 32 if SPARC32<br>
- =C2=A0 =C2=A0 =C2=A0 default 64 if SPARC64<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0 if SPARC32<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0 if SPARC64<br>
+ =C2=A0 =C2=A0 =C2=A0 default 0 if SPARC32<br>
+ =C2=A0 =C2=A0 =C2=A0 default 0 if SPARC64<br>
<br>
=C2=A0source kernel/Kconfig.hz<br>
<br>
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig<br>
index 11270ca..a05112c 100644<br>
--- a/arch/tile/Kconfig<br>
+++ b/arch/tile/Kconfig<br>
@@ -126,14 +126,15 @@ source &quot;init/Kconfig&quot;<br>
=C2=A0menu &quot;Tilera-specific configuration&quot;<br>
<br>
=C2=A0config NR_CPUS<br>
- =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of tiles (2-255)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 255<br>
+ =C2=A0 =C2=A0 =C2=A0 int &quot;Maximum number of tiles (0-0)&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;64&quot;<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0---help---<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Building with 64 is the recommended valu=
e, but a slightly<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smaller kernel memory footprint results =
from using a smaller<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 value on chips with fewer tiles.<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 value on chips with fewer tiles. =C2=A0To min=
imize both memory<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 footprint and bugs, use zero and only zero.<b=
r>
<br>
=C2=A0source &quot;kernel/time/Kconfig&quot;<br>
<br>
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig<br>
index 5bed94e..a6977f2 100644<br>
--- a/arch/x86/Kconfig<br>
+++ b/arch/x86/Kconfig<br>
@@ -773,19 +773,21 @@ config MAXSMP<br>
<br>
=C2=A0config NR_CPUS<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int &quot;Maximum number of CPUs&quot; if SMP &=
amp;&amp; !MAXSMP<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 8 if SMP &amp;&amp; X86_32 &amp;&amp; !X86_B=
IGSMP<br>
- =C2=A0 =C2=A0 =C2=A0 range 2 512 if SMP &amp;&amp; !MAXSMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;1&quot; if !SMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;4096&quot; if MAXSMP<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;32&quot; if SMP &amp;&amp; (X86_NUMAQ =
|| X86_SUMMIT || X86_BIGSMP || X86_ES7000)<br>
- =C2=A0 =C2=A0 =C2=A0 default &quot;8&quot; if SMP<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0 if SMP &amp;&amp; X86_32 &amp;&amp; !X86_B=
IGSMP<br>
+ =C2=A0 =C2=A0 =C2=A0 range 0 0 if SMP &amp;&amp; !MAXSMP<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if !SMP<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if MAXSMP<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if SMP &amp;&amp; (X86_NUMAQ |=
| X86_SUMMIT || X86_BIGSMP || X86_ES7000)<br>
+ =C2=A0 =C2=A0 =C2=A0 default &quot;0&quot; if SMP<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0---help---<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This allows you to specify the maximum n=
umber of CPUs which this<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel will support. =C2=A0The maximum s=
upported value is 512 and the<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0minimum value which makes sense is 2.<br=
>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is purely to save memory - each sup=
ported CPU adds<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 approximately eight kilobytes to the kernel i=
mage.<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 approximately eight kilobytes to the kernel i=
mage. =C2=A0But<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 the first supported CPU brings a lot of bugs =
with it, so<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 for ultimate reliability, set the number of C=
PUs to zero.<br>
<br>
=C2=A0config SCHED_SMT<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;SMT (Hyperthreading) scheduler suppo=
rt&quot;<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-hexago=
n&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</blockquote></div><br>

--f46d040713dd2d7cb504bc8f6081--
