Date: Thu, 3 Oct 2002 16:20:14 -0500
Mime-Version: 1.0 (Apple Message framework v546)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: RFC: generic vector unit support?
From: Kumar Gala <kumar.gala@motorola.com>
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <E81F90F8-D715-11D6-B5AB-003065BFB10E@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In added in the context switching code for the signal processing engine
on the e500 core I noticed that a fair amount of the code matched what
is being down for altivec.

SPE is a 64-bit wide vector engine on the e500 core (it extends the GPR
register file).

I was wondering if it would make sense to change the altivec code to be
more generic and have the SPE code and AltiVec code share the same
functions.  It is not possible to have both AltiVec and SPE in the same
processor (they share opcode space).

Changes would include:
CONFIG_ALTIVEC/CONFIG_SPE -> CONFIG_VECTOR
(we would still have some CONFIG_ALTIVEC/CONFIG_SPE for altivec/spe
specific handling)

last_task_used_altivec -> last_task_used_vector
giveup_altivec -> giveup_vector
dump_altivec -> dump_vector
enable_kernel_altivec -> enable_kernel_vector

I am not sure about what to do about ptrace.  We extended the interface
to have two new request types (PTRACE_GETVRREGS, PTRACE_SETVRREGS)
which return the full altivec state (all registers, vscr, vrsave).  We
could overload these request types to return all the 'vector' state
depending on which processor we are.  This would mean debuggers would
have to know which processor we are to know how big of a buffer to have
for ptrace calls, the memory layout, etc.

We also extend generic vector idea to allow dumping of altivec/SPE
register state into core files (which we do not do currently).

If we think this is the way to go, I will make a set of patches for the
2.4devel and 2.5 trees.

thanks

- kumar


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
