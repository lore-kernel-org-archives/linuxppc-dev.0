Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18720.42209.880409.297291@cargo.ozlabs.ibm.com>
Date: Mon, 17 Nov 2008 09:55:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/7] Porting dynmaic ftrace to PowerPC
In-Reply-To: <20081116212428.938752312@goodmis.org>
References: <20081116212428.938752312@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt writes:

> The following patches are for my work on porting the new dynamic ftrace
> framework to PowerPC.  The issue I had with both PPC64 and PPC32 is
> that the calls to mcount are 24 bit jumps. Since the modules are
> loaded in vmalloc address space, the call to mcount is farther than
> what a 24 bit jump can make. The way PPC solves this is with the use
> of trampolines. The trampoline is a memory space allocated within the
> 24 bit region of the module. The code in the trampoline that the
> jump is made to does a far jump to the core kernel code.

Thanks for doing this work.  I'll go through the patches in detail
today, but first I'd like to clear up a couple of things for you.  The
first is that unconditional branches on PowerPC effectively have a
26-bit sign-extended offset, not 24-bit.  The offset field in the
instruction is 24 bits long, but because all instructions are 4 bytes
long, two extra 0 bits get appended to the offset field, giving a
26-bit offset and a range of +/- 32MB from the branch instruction.

> PPC64, although works with 64 bit registers, the op codes are still
> 32 bit in length.  PPC64 uses table of contents (TOC) fields
> to make their calls to functions. A function name is really a pointer
> into the TOC table that stores the actual address of the function
> along with the TOC of that function. The r2 register plays as the
> TOC pointer. The actual name of the function is the function name
> with a dot '.' prefix.  The reference name "schedule" is really
> to the TOC entry, which calls the actual code with the reference
> name ".schedule". This also explains why the list of available filter
> functions on PPC64 all have a dot prefix.

A little more detail: the TOC mainly stores addresses and other
constants.  Functions have a descriptor that is stored in a .opd
section (not the TOC, though the TOC may contain pointers to procedure
descriptors).  Each descriptor has the address of the code, the
address of the TOC for the function, and a static chain pointer (not
used for C, but can used for other languages).  As you note, the
symbol for a function will be the address of the descriptor rather
than the address of the function code.

> When a funtion is called, it uses the 'bl' command which is a 24
> bit function jump (saving the return address in the link register).
> The next operation after all 'bl' calls is a nop. What the module
> load code does when one of these 'bl' calls is farther than 24 bits
> can handle, it creates a entry in the TOC and has the 'bl' call to

The module loader allocates some memory for these trampolines, but
that's a distinct area from the TOC and the OPD section.

> that entry. The entry in the TOC will save the r2 register on the
> stack "40(r1)" load the actually function into the ctrl register

"counter" register, actually, not "ctrl".

> The work for PPC32 is very much the same as the PPC64 code but the 32
> version does not need to deal with TOCS. This makes the code much
> simpler. Pretty much everything as PPC64 is done, except it does not
> need to index a TOC.

Right.

> I've tested the following patches on both PPC64 and PPC32. I will
> admit that the PPC64 does not seem that stable, but neither does the
> code when all this is not enabled ;-)  I'll debug it more to see if
> I can find the cause of my crashes, which may or may not be related
> to the dynamic ftrace code. But the use of TOCS in PPC64 make me
> a bit nervious that I did not do this correctly. Any help in reviewing
> my code for mistakes would be greatly appreciated.

Hmmm.  What sort of crashes are you seeing?

Regards,
Paul.
