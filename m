Date: Thu, 20 Jun 2002 03:07:35 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Samuel Rydh <samuel@ibrium.se>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sycall asm inline
In-Reply-To: <20020619032400.8069@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0206200246250.17959-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 Jun 2002, Benjamin Herrenschmidt wrote:

>
> >where __syscall_clobbers is just r4-r12. At a later point, some syscalls
> >are instantiated as inline functions:
> >
> >	static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
> >
> >Of course, as long as the syscall reside in a separate function,
> >the ABI guarantees that nothing bad will happen. But when the
> >function is inlined the undeclared side effects could cause problems,
> >or am I missing something?
>
> Probably not missing anything. Now we have to figure the proper set
> of clobbers, though I'm wondering if we could replace those inline
> syscalls by direct calls to the proper sys_xxx function. The only
> advantage I see in doing the syscall from the kernel is that you
> can "patch" it from a module or whatever, but is this feature used at
> all ?

Please use "cr0" instead of "cc" in the clobbers.

Although I wished that syscalls had been defined to clobber exactly
the same registers as ordinary function calls through blr. It's probably
too late now, and syscall entry/exit code could be streamlined to avoid
saving/restoring xer/ctr/lr/r11/r12, avoiding the use of scratch SPRG.

Note that recent GCC allow to use "xer" in the list of clobbers, although
I've not yet seen any instruction pattern in the machine description file
that splits carry setters and users. However, instead of using addic in
some of the atomic ops, I'd rather use addi and a "b" constraint for the
source register.

I had a patch that did exactly this, but I don't know where it is anymore
(too many bk trees :-)) Anyway you don't want to see my inline version of
atomic_clear_mask which selected the best instruction (among rlwinm,
andi., andis., and andc) through a maze of macros and builtin_constant_p
(I did this for fun since atomic_clear_mask is almost never used).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
