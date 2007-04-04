Return-Path: <pradyumna.sampath@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 19F61DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 17:30:31 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so547616ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 04 Apr 2007 00:30:30 -0700 (PDT)
Message-ID: <f87351060704040030q7aa52b47we2cf168795630f75@mail.gmail.com>
Date: Wed, 4 Apr 2007 13:00:29 +0530
From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: >= 2.6.20-rt8 ppc compile error
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everyone,

I am trying to get the linux >= 2.6.20-rt8 (+ Tsutomu's patches) to
2.6.21-rt11 for the lite5200b compiled and have been getting a bunch
of compile time errors. Please let me know if I am doing something
wrong here.

thanks in advance
regards
prady

Here is the error log:

[prady@marvin linux-2.6.20]$ make ARCH=ppc CROSS_COMPILE=ppc_6xx-
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/ppc/Kconfig
#
# configuration written to .config
#
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-ppc
  CC      arch/ppc/kernel/asm-offsets.s
In file included from arch/ppc/include/asm/hw_irq.h:110,
                 from include/asm/system.h:10,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
include/linux/irqflags.h:83:1: warning: "raw_local_irq_save" redefined
In file included from include/asm/system.h:10,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
arch/ppc/include/asm/hw_irq.h:103:1: warning: this is the location of
the previous definition
In file included from arch/ppc/include/asm/hw_irq.h:110,
                 from include/asm/system.h:10,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
include/linux/irqflags.h:88:1: warning: "raw_local_irq_restore" redefined
In file included from include/asm/system.h:10,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
arch/ppc/include/asm/hw_irq.h:62:1: warning: this is the location of
the previous definition
In file included from include/linux/time.h:7,
                 from include/linux/timex.h:57,
                 from include/linux/sched.h:50,
                 from arch/ppc/kernel/asm-offsets.c:12:
include/linux/seqlock.h: In function '__read_seqretry':
include/linux/seqlock.h:139: warning: implicit declaration of function
'local_irq_save'
include/linux/seqlock.h:140: warning: implicit declaration of function
'local_irq_restore'
  GEN     include/asm-ppc/asm-offsets.h
  HOSTCC  scripts/genksyms/genksyms.o
  SHIPPED scripts/genksyms/lex.c
  SHIPPED scripts/genksyms/parse.h
  SHIPPED scripts/genksyms/keywords.c
  HOSTCC  scripts/genksyms/lex.o
  SHIPPED scripts/genksyms/parse.c
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  CC      init/main.o
In file included from include/asm/system.h:10,
                 from include/linux/spinlock.h:95,
                 from include/linux/module.h:9,
                 from init/main.c:13:
arch/ppc/include/asm/hw_irq.h:62:1: warning: "raw_local_irq_restore" redefined
In file included from include/linux/spinlock.h:93,
                 from include/linux/module.h:9,
                 from init/main.c:13:
include/linux/irqflags.h:88:1: warning: this is the location of the
previous definition
In file included from include/asm/system.h:10,
                 from include/linux/spinlock.h:95,
                 from include/linux/module.h:9,
                 from init/main.c:13:
arch/ppc/include/asm/hw_irq.h:65:46: error: macro
"raw_local_irq_disable" passed 1 arguments, but takes just 0
In file included from include/asm/system.h:10,
                 from include/linux/spinlock.h:95,
                 from include/linux/module.h:9,
                 from init/main.c:13:
arch/ppc/include/asm/hw_irq.h:66: error: syntax error before '{' token
arch/ppc/include/asm/hw_irq.h:72: warning: type defaults to 'int' in
declaration of 'msr'
arch/ppc/include/asm/hw_irq.h:72: error: braced-group within
expression allowed only inside a function
arch/ppc/include/asm/hw_irq.h:72: warning: type defaults to 'int' in
declaration of 'rval'
arch/ppc/include/asm/hw_irq.h:72: warning: data definition has no type
or storage class
arch/ppc/include/asm/hw_irq.h:72: error: parse error before '}' token
arch/ppc/include/asm/hw_irq.h:77:45: error: macro
"raw_local_irq_enable" passed 1 arguments, but takes just 0
arch/ppc/include/asm/hw_irq.h:78: error: syntax error before '{' token
arch/ppc/include/asm/hw_irq.h:84: warning: type defaults to 'int' in
declaration of 'msr'
arch/ppc/include/asm/hw_irq.h:84: error: redefinition of 'msr'
arch/ppc/include/asm/hw_irq.h:72: error: previous definition of 'msr' was here
arch/ppc/include/asm/hw_irq.h:84: error: braced-group within
expression allowed only inside a function
arch/ppc/include/asm/hw_irq.h:84: warning: type defaults to 'int' in
declaration of 'rval'
arch/ppc/include/asm/hw_irq.h:84: warning: data definition has no type
or storage class
arch/ppc/include/asm/hw_irq.h:84: error: parse error before '}' token
arch/ppc/include/asm/hw_irq.h:103:1: warning: "raw_local_irq_save" redefined
In file included from include/linux/spinlock.h:93,
                 from include/linux/module.h:9,
                 from init/main.c:13:
include/linux/irqflags.h:83:1: warning: this is the location of the
previous definition
In file included from include/linux/time.h:7,
                 from include/linux/stat.h:57,
                 from include/linux/module.h:11,
                 from init/main.c:13:
include/linux/seqlock.h: In function '__read_seqretry':
include/linux/seqlock.h:139: warning: implicit declaration of function
'local_irq_save'
include/linux/seqlock.h:140: warning: implicit declaration of function
'local_irq_restore'
In file included from include/linux/rtc.h:102,
                 from include/linux/efi.h:19,
                 from init/main.c:43:
include/linux/interrupt.h: In function 'cli':
include/linux/interrupt.h:188: warning: implicit declaration of
function 'local_irq_disable'
include/linux/interrupt.h: In function 'sti':
include/linux/interrupt.h:192: warning: implicit declaration of
function 'local_irq_enable'
include/linux/interrupt.h: In function 'save_flags':
include/linux/interrupt.h:196: warning: implicit declaration of
function 'local_save_flags'
init/main.c: In function 'start_kernel':
init/main.c:547: warning: implicit declaration of function 'irqs_disabled'
{standard input}: Assembler messages:
{standard input}:218: Error: symbol `msr' is already defined
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
