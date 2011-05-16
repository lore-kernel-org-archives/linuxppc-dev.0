Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id D40CEB6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 01:33:28 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.51])
	by hrndva-qmta02.mail.rr.com with ESMTP
	id <20110516152826581.ZBO5185@hrndva-qmta02.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2011 15:28:26 +0000
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Drewry <wad@chromium.org>
In-Reply-To: <1305169376-2363-1-git-send-email-wad@chromium.org>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Mon, 16 May 2011 11:26:47 -0400
Message-ID: <1305559607.5456.11.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Ralf Baechle <ralf@linux-mips.org>, "H. Peter
	Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	jmorris@namei.org, Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@elte.hu>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, microblaze-uclinux@itee.uq.edu.au,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
	Roland McGrath <roland@redhat.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Eric Paris <eparis@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Tejun Heo <tj@kernel.org>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>, agl@chromium.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry to be absent from this thread so far, I just got back from my
travels and I'm now catching up on email.


On Wed, 2011-05-11 at 22:02 -0500, Will Drewry wrote:

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 377a7a5..22e1668 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1664,6 +1664,16 @@ config SECCOMP
>  	  and the task is only allowed to execute a few safe syscalls
>  	  defined by each seccomp mode.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config CC_STACKPROTECTOR
>  	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index eccdefe..7641ee9 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -129,6 +129,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  endmenu
>  
>  menu "Advanced setup"
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 8e256cc..fe4cbda 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2245,6 +2245,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config USE_OF
>  	bool "Flattened Device Tree support"
>  	select OF
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8f4d50b..83499e4 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -605,6 +605,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  endmenu
>  
>  config ISA_DMA_API
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 2508a6f..2777515 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -614,6 +614,16 @@ config SECCOMP
>  
>  	  If unsure, say Y.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  endmenu
>  
>  menu "Power Management"
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 4b89da2..00c1521 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -676,6 +676,16 @@ config SECCOMP
>  
>  	  If unsure, say N.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config SMP
>  	bool "Symmetric multi-processing support"
>  	depends on SYS_SUPPORTS_SMP
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index e560d10..5b42255 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -270,6 +270,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs"
>  	depends on SPARC64 && SMP
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index cc6c53a..d6d44d9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1485,6 +1485,16 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config SECCOMP_FILTER
> +	bool "Enable seccomp-based system call filtering"
> +	depends on SECCOMP && EXPERIMENTAL
> +	help
> +	  Per-process, inherited system call filtering using shared code
> +	  across seccomp and ftrace_syscalls.  If CONFIG_FTRACE_SYSCALLS
> +	  is not available, enhanced filters will not be available.
> +
> +	  See Documentation/prctl/seccomp_filter.txt for more detail.
> +
>  config CC_STACKPROTECTOR
>  	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
>  	---help---

You just cut-and-pasted 8 copies of a config selection. The proper way
to do that is to add the Kconfig selection in a core kernel Kconfig,
have it depend on "HAVE_SECCOMP_FILTER" and then in each of these
configs, simply add in the arch Kconfig:

config <ARCH>
	[...]
	select HAVE_SECCOMP_FILTER


That way you don't need to duplicate the config option all over the
place.

-- Steve
