Date: Tue, 10 Jun 2003 23:21:57 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Re: init does not run on 405GP system
Message-Id: <20030610232157.2f012435.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 10 Jun 2003, Robert Schwebel wrote:

> I'm currently porting u-boot and Linux to an IBM 405GP based board. The
> problem is now that init seems not to be running and does not give any
> output. Up to that point where init should make some noise the kernel
> boots smoothly (serial console), I see all output and NFS-Root is
> mounted via an Intel 82559 network chip. The kernel threads are also
> running, I see kupdated & friends being put into the run queue from time
> to time.
>
> I have replaced /sbin/init by a statically linked "hello world" (which
> also does not give any output). My impression is that the binary code of
> the init ELF binary is never run. When I switch on the SHOW_SYSCALLs
> macro in arch/ppc/kernel/entry.S I see the system calls for open(),
> dup(), dup() and execve() which come from init/main.c. Opening the
> console works, execve() to /sbin/init as well. When I follow the path of
> execution up to load_elf_binary() in fs/binfmt_elf.c I can even see the
> correct code being load and pointed to by elf_entry in that file. But
> there is never any output from init, nor does something happen when I
> replace init by a piece of code which should immediately make a zero
> pointer exception.

This is probably not the issue, but you do have CONFIG_BINFMT_ELF
enabled in the kernel, don't you (although I would assume you would
get some kind of kernel error message when you tried to exec /sbin/init
if CONFIG_BINFMT_ELF wasn't enabled).

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
