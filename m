Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 18:52:46 +1100
Message-Id: <1132645967.26560.221.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: powerpc  boot sequence rework
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm about to start significantly reworking the boot sequence of ppc32 to
make it look more like ppc64, and to move both ppc32 and ppc64 into a
scheme where less "magic" is done by the architecture before
start_kernel and we rely more on setup_arch. This is all for
ARCH=powerpc only of course.

This is an explanation of what I intend to do and a request for comments
of course. However, at this point, I can only do ppc64 and CONFIG_6xx
ppc32, other processors will need equivalent changes done by their
various maintainers.

Here's a quick review of what happens now before my intended changes and
some hilights of the ppc32/ppc64 differences. I intentionally ignored
APUS as I don't even pretend to understand what it does, it will have to
adapt to our changes anyway :)

  - prom_init/bootx_init(). This is called right away, in whatever
context we were when entering the kernel, if the right "signature" is
found in registers on entry. Both of these are "trampolines" that just
call back into __start with a flattened device-tree. In fact, they could
almost be moved to be a completely separate binary, if it wasn't for the
only "hack" I kept around where they actually share a couple of globals
with the kernel: the initial btext setup for early debug to screen and
it's associated early display BAT.

  - early_init() (ppc32 only). Called in the same context as above. This
clears bss, does the CPU detection & features fixup and returns. This is
mostly a remain of arch/ppc early_init() which used to also call
prom_init/bootx_init. The CPU feature stuff diverges from ppc64 here. On
ppc64, both detection and fixup are done from assembly at very different
times: while detection is also done early in a similar way, fixup is
done after some early initialisation C code has been run, giving a
chance to the kernel to "override" some of the CPU features based on
properties in the device-trees among others. 

 - TLBs/BATs are cleanup up, some initial BATs are setup for mapping the
beginning of memory (and eventually some debug IOs) but MMU isn't turned
on yet. We do the CPU setup at this point. It's done on ppc64 in a
similar place, at the same time as we are identifying it in fact, while
it's two separate calls on ppc32.

 - The kernel is relocated to 0 and the MMU turned on. At this point, we
run with an initial mapping set by the BATs that maps part of the RAM
(enough for the kernel .text/.data/.bss and the flattened device tree
blob is what matters here). On non-6xx CPUs, we do some equivalent
mapping using pinned TLB entries of some sort or other equivalent
facilities. On ppc64, instead, we stick to real mode due to a nice
"feature" of ppc64 processors which is to ignore the top 2 bits of
addresses when running in real mode. Thus code/data linked at
0xc000000000000000 will be accessed just fine when this really is at
0 :) In both case, this "initial" MMU setup (or absence of it on ppc64)
is there so we can run some early C code that identifies the machine and
sets up the proper MMU configuration. Thus, even if practically
different (pinned mapping vs. real mode), this is functionally
equivalent.

 - we get to start_here() (ppc32) and it's equivalent on ppc64
(start_here_multiplatform(), iSeries is a bit different for now, but
that's irrelevant to this discussion). After some housekeeping, like
clearing BSS, setting the PACA and TOC registers on ppc64, some initial
stack pointer, etc... so we can call C code, we get to what is called
early_setup() on ppc64, and machine_init() followed by MMU_init() on
ppc32. While there is a significant difference in the implementations of
these beasts, their goal is fairly similar: Do some early
initialisations like figuring out the machine type, setting up ppc_md.
etc... and configure the MMU properly. This is where ppc64 gets a chance
to change the CPU features before the dynamic patching is done, while
ppc32 has already done it. While the MMU code has to be different, the
way the ppc_md is selected and the early parsing of the device-tree has
no good reason to remain different.

 - Here, there is a significant difference in code flow. After coming
back from MMU_init, ppc32 will enable the MMU and call start_kernel()
(the main entry point in the common code). Further initialisations will
be done from setup_arch() that is called almost right away by
start_kernel() itself. ppc64 first goes through setup_system() which
does a huge amount of things which are mostly equivalent of those same
initialisations that ppc32 does in setup_arch(), then comes back to
head_64.s which then finally calls start_kernel. ppc64 additionaly also
does some more initialisations in it's own setup_arch().
My recent changes already made the early bits of ppc32 setup_arch() look
very similar to what happens in ppc64 setup_system(). One notable
addition is the call to ppc_md.init_early() which gives a chance to the
platform to do some initialisations (typically setup some early debug
output) very early during boot. It existed on ppc64 but was never called
on ppc32.

Ok, now let's quickly explain what I have in mind:

So while the implementation differs a lot, the global idea is the same,
and can be defined by 4 major steps:

 - Very early trampoline code from the firmware (prom_init/bootx_init)
that could eventually be moved to a boot wrapper but is currently kept
in the kernel for convenience.

 - Relocation of the kernel to its final location with MMU disabled

 - Setup of an initial MMU environment that allows running of C code &
access to the kernel text/data/bss and the device-tree blob (but not
necessarily all of RAM), typically using pinned tlb entries, BATs or
real mode depending on the CPU/architecture, then call into that C code
that will, from within that environment, identify the machine and setup
the necessary bits & pieces so the MMU can be fully enabled

 - Fully enable the MMU, do some additional initialisation & start the
kernel.

Now, my first idea is that a lot of those magic "*_init_*" functions
that are called from asm could go. There is absolutely no need for them.
In fact, once we have setup the initial MMU environment (BATs, pinned
TLBs or real mode), we could directly go to start_kernel.

start_kernel() itself will then conveniently call setup_arch() which
should be able to do all that is necessary in order from _one_ spot in
the arch code instead of 3. Instead of returning to head_*.S for
enabling the MMU, for example, setup_arch() would simply call into an
MMU startup function (let's call mmu_enable()) that returns with the MMU
fully enabled.

The code in setup_arch() would be entirely common to ppc32 and ppc64
with just the right "hooks" to deal their differences in
implementations.

The only "issue" with that first idea is that start_kernel() will do a
couple of things before calling setup_arch() and we need to be sure
those won't cause the kernel to blow up because they rely on things
being more initialized than they already are:

 - lock_kernel: hopefully should not be a problem
 - page_address_init(): this is just a bunch of initialisation of
globals, and thus shouldn't be a problem
 - printk(): this is the biggest one, but at this point, no console
driver is registered yet, so it should just dump it's output into the
buffer without any problem

The only possible "issue" I've seen is that spinlocks must already be
operational, that is if your spinlock implementation relies on some CPU
feature patching, it hasn't been done yet, that sort of thing.

Here is a more detailed description of the code flow i have in mind from
setup_arch(), which would be entered directly from start_kernel() after
MMU has been turned on with the "initial" mapping (or left off on
ppc64). Note that the BSS init is supposed to have been moved to the asm
like it is on ppc64 and thus called before that point. This is also the
case of the initial CPU identification and setup, but not of the dynamic
patching, thus all matching what ppc64 does.

 - early_init_devtree(). Stores the pointer to the flattened blob,
initializes some critical kernel globals based on what is in the
flattened tree like the LMB array, the command line, etc...

 - probe machine type. This would be done in a way similar to what ppc64
does, by calling repeately into all present ppc_md's probe() callback
until one 'gets' it. I will probably kill the ppc_md. pointer array that
ppc64 has now though and have the ppc_md's all be stored in a separate
ELF section that can be iterated and discarded so avoid ifdef's in
setup.c. I'll also probably make ppc_md.'s statically initialized (at
least for most of the callbacks). The probe() function should _not_ rely
on any _machine number as this will _not_ have been set for you unlike
what happens now. It should use the device-tree and is the one to set
_machine (at least for now, until it gets deprecated). The functions for
iterating the flat device-tree are available for use at this point. That
means that things like pmac_init(), chrp_init() and prep_init() are
gone. Dead. Good riddance.  At this point, we have done what current
platform_init() does on ppc32 and we are half-way through what current
early_setup() does on ppc64.

 - mmu_initialize(). The MMU is fully initialized but not turned "On"
yet, that is, all necessary data structures for using the MMU in it's
"final" setup are initialized, hash table allocated, etc... but the MMU
is still running on it's initial setup. On ppc64, that means doing
htab_initialize() and slb_initialize/stab_initialize(). On ppc32, that
means doing pretty much what MMU_init currently does.
This _might_ contain a callback to ppc_md. to allow the platform to
intervene but I'd rather avoid it if I can. (That is the current
ppc_md.setup_io_mappings()). Note about ppc64: Setting the hash table
access function pointers will be already done at this point, and thus no
longer done in whatever platform init_early() callback is called later
on, thus the #ifdef's and platform type tests can be fone from
htab_initialize() among others. It's the platform probe() routine which
is reponsible for setting a global indicating the type of mmu callbacks
to use (probably a firmware feature, I've not completely decided yet,
firmware features should be initialized from probe() anyway). Whatever
is also done currently by mm_init_ppc64() goes here, that function is
totally obsolete.

 - we apply the CPU feature fixups now. The 3 step aboves had all a
chance to modify some of the CPU features, this is now over and the
dynamic patching of asm code is done now.

 - mmu_enable(). This is an asm routine (hopefully) called from C code
in the initial setup that should return to C code with the MMU fully
active on the "final" setup. On ppc64 or ppc32 with hash table, that
means SDR1 has been set to point to the hash table, kernel segments have
been configured (if relevant), and the BATs are loaded with their final
values, etc... Upon return from this function, it's expected that the
entire linear mapping is accessible, and that early ioremap can be done
(using the ioremap_bot technique for allocating early virtual space)

 - Now we get into the typical sequence done today by ppc32 setup_arch()
and ppc64 setup_system(), that is unflatten_device_tree(),
check_for_initrd(),initialize_cache_info() (ppc64 only),
rtas_initialize(), ppc_md.init_early(), find_legacy_serial_ports()
(might be worth having a config option for that one ?),
finish_device_tree(), xmon_init(), and register_early_udbg_console(). I
don't want to get into too much details here, suffice to say that we
basically start with unflattening the device-tree (we should set some
global somewhere to make the early flat tree walking functions fail from
that point btw) and give a chance to the architecture to do some very
early initializations. That's where powermac will initialize it's
"feature" stuff (detecting northbridge & IO chip, initializing bits &
pieces of them), and setup some udbg stuff to get early debug output. If
your platform doesn't use the legacy serial ports, it might want to do
similar things here.

 - Now we have reached the end of ppc64 current setup_system() and are
half way through ppc32 current setup_arch(). The rest of setup_arch()
can be merged trivially, with a few ifdef's here or there, it's mostly
random data structure/globals initialisations that can be made common or
moved elsewhere (init_mm init should definitely be elsewhere :), calling
do_init_bootmem(), etc... No need to get into details here, I'll deal
with these bits once I'm actually writing the code. It all ends with
calling the platform's own setup_arch() if any, and paging_init().

I also intend to kill ppc_init(), platforms can do their own
arch_initcall() if they need it, CPU regisitration for sysfs should go
to sysfs.c which can be made common) etc...

It will take me a few days to go through the rework and I'll need help
testing & fixing things. In the meantime, comments on the above are
welcome.

Ben.
