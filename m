Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Tue, 10 Jun 2003 16:10:47 +0200
From: Robert Schwebel <robert@schwebel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: init does not run on 405GP system
Message-ID: <20030610141047.GU9379@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm currently porting u-boot and Linux to an IBM 405GP based board. The
problem is now that init seems not to be running and does not give any
output. Up to that point where init should make some noise the kernel
boots smoothly (serial console), I see all output and NFS-Root is
mounted via an Intel 82559 network chip. The kernel threads are also
running, I see kupdated & friends being put into the run queue from time
to time.

I have replaced /sbin/init by a statically linked "hello world" (which
also does not give any output). My impression is that the binary code of
the init ELF binary is never run. When I switch on the SHOW_SYSCALLs
macro in arch/ppc/kernel/entry.S I see the system calls for open(),
dup(), dup() and execve() which come from init/main.c. Opening the
console works, execve() to /sbin/init as well. When I follow the path of
execution up to load_elf_binary() in fs/binfmt_elf.c I can even see the
correct code being load and pointed to by elf_entry in that file. But
there is never any output from init, nor does something happen when I
replace init by a piece of code which should immediately make a zero
pointer exception.

Nevertheless, the kernel runs smoothly. I can ping the machine, I can
even floodping it with 0% packet loss. Only that there is no userspace
running.

Has anybody seen something like this before?

- Kernel is 2.4.21-rc2 with bitkeeper from 20030515 plus board port
- userland was tested with Debian bootdisks, Denx 4xx boot image and
  others
- toolchain is the Debian powerpc-linux cross toolchain.

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
