From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Fwd: CPU features
Date: Sat, 31 Mar 2001 11:16:15 +0200
Message-Id: <20010331091615.3225@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I finally finished my cpu table & features stuff. It's in my rsync
kernel at penguinppc::linux-2.4-benh. It may still need some fixes
for 4xx/8xx and power3/4, so please, look at it and send me patches ;)

Basically, every CPU calls identify_cpu (head.S) during startup.
Each CPU is matched via a table (cputable.c), and a pointer to
it's table entry stored in an array. The table contains a few
things (and can be extended as offsets for the asm code are
computed my mk_defs.c):

 - PVR mask/value (used to match the CPU model/rev)
 - the CPU name
 - the i/d cache line sizes (well, maybe not needed)]
 - the CPU features bit mask
 - the CPU "setup" function

The call to enable_caches is replaced by a call to the CPU
setup function provided by the table entry.

C code can just get the pointer to the table entry to get the
CPU features and test them. For assembly code, I added an
additional trick to avoid the overhead of reading from memory,
testing the bit, etc.. Mostly because I wanted to avoid
an unpredictable branch in code path such as transfer_to_handler
and because such asm code may run with either MMU translation on
or off, making the retreival of the CPU features potentially
tricky.

Basically, if you have a bit of asm code that depends on a
given CPU feature, enclose it with a couple of macros defined
in cputable.h. The second macro takes a couple of feature
masks as a parameter (matched by the usual (ftr&mask)==value
so you can test for either the presence or absence of the
feature).

The macros will add references to the enclosed code in a
table stored in the __ftr_fixup section. head.S will parse
this table after identifying CPU0 and will replace the code
with nop's if the required features are not matched.

I mostly use this for altivec so no need to test for
it dynamically in head.S or entry.S.

If we end up nop'ing out larger bits of code, it's easy to
modify the fixup routine to replace the first nop with a branch
to after the code section, avoiding the execution of all the nops.
For now, I didn't feel the need for it since it never replace more
than 2 instructions with nop's in real life.

It could also be used for the 601-only SYNCs to avoid a compile
option: those syncs would be nop'ed out automagically when running
on a non-601 CPU. Other candidates I didn't touch yet are the
cache flush/inval routines (split/non-split caches), etc..

For larger chunks of code, it would be wiser to add function
pointers to the cpu table entries.

Please, don't hesitate to comment, send patches, etc... I plan
to push all this by the end of next week, once it's tested
enough on various hardware and missing bits for embedded CPUs
and power3/4 are added.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
