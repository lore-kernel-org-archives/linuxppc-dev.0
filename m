Return-Path: <shawnxjin@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id CB043B70DE
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Aug 2010 16:59:34 +1000 (EST)
Received: by ewy2 with SMTP id 2so3168046ewy.15
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 23:59:32 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 20 Aug 2010 23:59:30 -0700
Message-ID: <AANLkTinb9yJk10yE2nAT_exNaANHyFbAH59LOM=Jy7Oz@mail.gmail.com>
Subject: How to build the kernel without any optimization?
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm tracing the execution of ds1307_probe() and find that some of
variables or function arguments cannot be printed in gdb because they
are optimized out or not in the current context. This really gives
some headache. Is there a way to build the kernel without any
optimization? What gcc option shall I disable or add?

I already added the following to arch/powerpc/Makefile.

# Prevent GDB from jumping around in the code when trying to single step
ifeq ($(CONFIG_DEBUG_KERNEL),y)
KBUILD_CFLAGS           += -fno-schedule-insns -fno-schedule-insns2
endif

Thanks,
-Shawn.
