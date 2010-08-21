Return-Path: <hofrat@hofr.at>
Received: from mail.hofr.at (hofr.at [212.69.189.236])
	by ozlabs.org (Postfix) with ESMTP id 28994B70DB
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Aug 2010 17:37:13 +1000 (EST)
Date: Sat, 21 Aug 2010 09:31:16 +0200
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: How to build the kernel without any optimization?
Message-ID: <20100821073116.GA1597@opentech.at>
References: <AANLkTinb9yJk10yE2nAT_exNaANHyFbAH59LOM=Jy7Oz@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinb9yJk10yE2nAT_exNaANHyFbAH59LOM=Jy7Oz@mail.gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 Aug 2010, Shawn Jin wrote:

> Hi,
> 
> I'm tracing the execution of ds1307_probe() and find that some of
> variables or function arguments cannot be printed in gdb because they
> are optimized out or not in the current context. This really gives
> some headache. Is there a way to build the kernel without any
> optimization? What gcc option shall I disable or add?
> 
> I already added the following to arch/powerpc/Makefile.
> 
> # Prevent GDB from jumping around in the code when trying to single step
> ifeq ($(CONFIG_DEBUG_KERNEL),y)
> KBUILD_CFLAGS           += -fno-schedule-insns -fno-schedule-insns2
> endif
>

much of the kernel can not be build without optimization - what you 
can do though is slectively try to disable optimization for specific
files by putting 

 CFLAGS_REMOVE_objfilenam.o = -SOME_OPT

in the Makefile. I think that is safer than what you did above as this would
always depend on the order of options that ultimately get passed to gcc.

hofrat 
