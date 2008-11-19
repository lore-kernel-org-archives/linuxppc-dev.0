Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18724.36588.435729.738363@cargo.ozlabs.ibm.com>
Date: Thu, 20 Nov 2008 09:10:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] powerpc: allow configuring max stack dump depth
In-Reply-To: <1227095318.26243.17.camel@johannes.berg>
References: <1225534317.3560.8.camel@johannes.berg>
	<18723.38125.245930.196074@cargo.ozlabs.ibm.com>
	<1227095318.26243.17.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> On my screen, when something crashes, I only have space for maybe
> 16 functions of the stack trace before the information above it
> scrolls off the screen. It's easy to hack the kernel to print out
> only that much, but it's harder to remember to do it. This patch
> introduces a config option for it so that I can keep the setting
> in my config.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> Sure, here's an updated version. I used DEBUG_KERNEL since the
> ADVANCED_CONFIGURATION help text implies it's for MM and can cause the
> kernel to not boot, not something this config is related to.

Um, with this I get a compile error when DEBUG_KERNEL=n:

  CC      arch/powerpc/kernel/process.o
/home/paulus/kernel/powerpc/arch/powerpc/kernel/process.c:1001: error: 'CONFIG_PRINT_STACK_DEPTH' undeclared here (not in a function)
make[2]: *** [arch/powerpc/kernel/process.o] Error 1

I think it needs to look like this:

+config PRINT_STACK_DEPTH
+	int "Stack depth to print" if DEBUG_KERNEL
+	default 64
+	help
+	  This option allows you to set the stack depth that the kernel
+	  prints in stack traces. This can be useful if your display is
+	  too small and stack traces cause important information to
+	  scroll off the screen.
+

Paul.
