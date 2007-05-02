Return-Path: <robert@stopthespam_remove.staven.no>
Received: from fri.itea.ntnu.no (fri.itea.ntnu.no [129.241.7.60])
	by ozlabs.org (Postfix) with ESMTP id AA798DDF93
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 03:46:13 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by fri.itea.ntnu.no (Postfix) with ESMTP id 5B4F69622
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 19:46:08 +0200 (CEST)
Received: from [127.0.0.1] (unknown [129.241.154.56])
	by fri.itea.ntnu.no (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 19:46:07 +0200 (CEST)
Message-ID: <4638CE5B.2090803@stopthespam_remove.staven.no>
Date: Wed, 02 May 2007 19:46:03 +0200
From: Robert Staven <robert@stopthespam_remove.staven.no>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problem inkluding *.h files when compiling module
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

I suspect this is slightly 'off topic' but have seen similar threads in 
the lists archive so I go for it.

Testing some code (UDP by sockets example), and it compiles and works 
great on both host(i386) and target (mpc8250)

I move the code to a module I'm working on and when I compile (for the 
embedded platform) some of the needed header files is not found.

I suspect this is cause I'm missing some basic understanding of how 
gcc/makefile/compiling modules works. But can't find any useful info.

Snip from my makefile:

KDIR    := /home/mykernel/linuxppc-2.6
SDIR     := /home/prog/sdlc
default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(SDIR) modules

The KDIR is the problem, header files not found is under this dir (or 
sub dirs).
But KDIR is supposed to point to my kernel source, isn't it?

Checking with gcc I find the places to look for my header files:
# powerpc-linux-gcc -print-search-dirs
<snip>
libraries: =
/opt/amltd/powerpc-linux/gcc-3.4.3-glibc-2.3.5/lib/gcc/powerpc-linux/3.4.3/:
/usr/lib/gcc/powerpc-linux/3.4.3/:
/opt/amltd/powerpc-linux/gcc-3.4.3-glibc-2.3.5/lib/gcc/powerpc-linux/3.4.3/../../../../powerpc-linux/lib/powerpc-linux/3.4.3/:
/opt/amltd/powerpc-linux/gcc-3.4.3-glibc-2.3.5/lib/gcc/powerpc-linux/3.4.3/../../../../powerpc-linux/lib/

But these dirs dosn't have my kernel source (as needed by KDIR)?

Any way to give the makefile several paths to search for files needed?

Grateful for any tips, places to find info or more relevant mail-lists!

br
Robert Staven
