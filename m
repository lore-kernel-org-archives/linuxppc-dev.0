Date: Tue, 2 Nov 1999 15:11:37 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: Dan Malek <dan@netx4.com>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: ASM-PPC Include File Rework Proposal: Processor / Board Header
 Files
Message-ID: <Pine.SGI.4.10.9911021458010.170338-100000@brule.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2 Nov 1999, Dan Malek wrote:
> Some time before that, Grant Erickson wrote:
>> As more PowerPC processor variants get added and as more board types are
>> supported by the stock Linux/PPC distribution the current state of affairs
>> in the asm-ppc directory is going to get a little unruly.
> 
> It isn't only the include directory, it is the entire structure
> of the generic software we all want to utilize, plus the ability
> (especially for embedded stuff) to remove any configuration items
> we really don't want.

Precisely. The include files just seemed like a place to start.

Providing the greatest degree of access to and functionality in the
generic software, while at the same time eliminating specific things you
don't need, is an excellent goal. It seems to be a tenet of the Linux
kernel. Honestly, that's the beauty of the Linux kernel... there's an
astoundingly high degree of platform independence in it (or at least the
illusion thereof).

At the PowerPC processor level, I'm hoping we can carry that torch further
and minimize and confine the PPC-family specific code as much as possible
to both prevent breaking things and unnecessarily duplicating effort. Of
course, keeping an eye for performance, maintainability and extensibility.

However, right now there seems to be a great degree of intermingling of
the generic and the specific.

>> The real ugliness comes with the large number of ifdef's sprinkled all
>> over the place.
> 
> Beauty is in the eye of the beholder :-). I don't really think it is
> that bad. There are a few nasty spots, but overall it is much neater
> than some commercial projects I have seen in the past.

I'm all for intelligent code and performance, but I'm also against kernel
bloat. There's a delicate balance and trade-offs between function accesses
though function pointers, keying off the processor version register (PVR),
and defines/ifdefs. Each has its pros/cons.

I think*, based on initial impressions, that things could be "virtualized"
(for lack of a better term) a bit more in the PowerPC implementation as it
stands in 2.3.xx (e.g. MMU handling in particular).

>> Dan has a nice solution to board-specific information with the mpc8xx.h
> 
> Perhaps this is where we start with your 4xx stuff.  Although I
> have currently stretched the "mpc8xx.h" to include some of the
> new 82xx stuff, you could just add your 4xx into it as well.
> Change the name if you like, but make it work first.

Sounds reasonable. Either way, if that's the path we take then the name
should change otherwise it just adds to confusion for new comers to the
kernel (e.g. "So, I'm including mpc8xx.h to add support for the PowerPC
4xx?!").

> Although it is logical and certainly appropriate to separate this
> information, from my experience this is getting harder to do because
> of the integration of the processors.

Sure. Case and point: the IBM 405GP. It's got a PCI bus, I2C bus, Ethernet
MAC, two 16550 UARTs, SDRAM controller, power management, and a number of
timer facilities all on the die. Is it a board or is it a processor? ;)

> Processors either dictate a certain board configuration, or are so
> flexible the board configuration describes a processor configuration.  
> Your "generic" processor definitions become very few.

Agreed. Again though, if things really are that flexible then we need to
keep an eye to that so that when some other new board or system comes
along a year later, it's easy just to plug in some new parameters and get
up and running quickly.

>> Also, processor.h has a smattering of all sorts of information. Some of it
>> processor related, some of it board related, and almost all of it specific
>> to the 6xx/7xx processor cores.
> 
> This is where Linux/PPC started and most of the work continues.

Absolutely. However, I'm of the opinion that in the next year or two,
embedded systems running Linux will eclipse that segment.

This doesn't mean one camp should spurn the other and go their separate
ways, but rather look at it as an opportunity to architect things so that
the kernel cleanly accommodates both.

>> ..... I'd like to define several new files,
> 
> Here is where I have a _real_ opinion.   I don't like lots of
> files that basically describe the same thing.

I agree 100%. However, all the processor files I proposed would contain
very different things (e.g. those things that are only specific to that
processor or family). The generic file is 'ppc.h' and it would contain
things generic to all PowerPC processors as they exist today. At present,
the contents of that file are pretty small.

> The problem lies in the update of generic software. When I make a
> kernel modification that affects everyone, I have to update several
> different files in a similar manner and hope I don't break something
> for someone else.

Agreed. Right now, I've defined head_4xx.S in my code tree, which bothers
me because 85% of it is totally in common with head.S and head_8xx.S.
However, the parts that are different are pretty incompatible (mostly the 
exception handlers).

So, I see an opportunity for us to split out the common code among head.S,
head_4xx.S and head_8xx.S and make that generic. The rest can stay in some
platform specific file.

> As I have said in a previous e-mail, my goal is to remove
> all of these 8xx board specific files by reprogramming the 8xx
> to a generic Linux/PPC address space.

Again, I'm in total agreement when and where it's possible to do that.

So let's take the two IBM evaluation boards I've got. Without taking the
effort of writing a new boot ROM for both of them, I'm pretty much limited
to linking the kernel at physical address 0x80010000 (due to the physical
location of RAM and the boot ROMs odd image load format), loading it
there, and making the first jump to it there. Only then can I virtually
map it in at 0xc0000000 and copy it down to physical address 0x00000000.

So, does this mean I probably need to write a boot loader then that gets
loaded at 0x80010000, copies/unzips Linux down to 0x0000000 and then jumps
to it there, thereby leaving KERNELBASE and KERNELLOAD alone?

> When all of this is in a single place, it forces you to think about
> how your unique changes are going to affect everyone else.  It
> should also make you try to find a more generic solution to your
> new addition.  In the end, it will make it easier for everyone
> to maintain.

Again, I agree 100%. The point I'm trying to drive home is that many
instances, we don't really have, good, clean generic interfaces available
in the PowerPC-specific portion of the Linux kernel. Take, for example,
mm/init.c. Most of the code here is VERY board and processor specific.

> I tend to find processor.h rather convenient.

Here there's assembly definitions and macros (seems like these should be
in kernel/ppc_asm.{h,tmpl}), task-specific stuff (the non-existent
asm-ppc/task.h perhaps), and a number of things that seem like they belong
in residual.h.

> There are others in this list as well, like pgtable.h and mmu.h.

Again, two files, most of which are completely incompatible with the 4xx
architecture.

> When you start changing things for a new processor or board type,
> you have all of the current information described there.

On the flip side, it increases the amount of potentially irrelevant
information you might not need to understand to add support in for your
new board or processor.

> We recently split head.S into head.S and head_8xx.S.  I don't
> think that was such a good idea......Now, generic changes to
> the VM or task subsystem have to be applied in both files.  It
> actually makes it harder for me because I now have to track
> 6xx/7xx changes more carefully to make sure 8xx still works.

See above. It increases readability (a good thing IMHO), but it makes
maintainability more difficult. It sounds like there's more for us to do
with regards to head_xxx.S.

> My suggestion is to simply add your 4xx along the path of the
> 8xx and let's try to sort out some kind of "embedded" solution.

Sounds reasonable for the present.

> There is a long history of Prep/CHRP/PMac and 6xx/7xx software
> that has defined the structure of the Linux/PPC kernel, and I
> would rather not change that.

To be certain, I have no interest in breaking it. If my Power Mac / Linux
machine is out of order, I'm sunk. ;)

However, if that structure impedes progress or makes it difficult to
cleanly architect support for new platforms and processors in the PowerPC
family then it seems like that structure shouldn't be immutable to change.

> I have been working on the kernel almost daily for many years now,
> and there are few others that do the same.  When you get old like
> me, it helps to have some consistency in your life :-).  I know what
> is in all of the files and where to go and change something.

If things are really, really documented well (this doesn't just mean
comments, but defines where appropriate, header names that reflect what's
in them, etc) in the all the headers and sources then it's typically
pretty easy to figure out what is what.

Take for example, this define in kernel/ppc_asm.h

/* This instruction is not implemented on the PPC 603 or 601 */

#define tlbia \
        li      r4,128; \           <-- # TLB entries for just the 601 and 603?
        mtctr   r4; \                   All PPC processors?
        lis     r4,KERNELBASE@h; \
0:      tlbie   r4; \               
        addi    r4,r4,0x1000; \     <-- default page size? maximum page size?
        bdnz    0b                      page size when this define is used?

> As I said in the beginning, I don't find the confusion or challenge in
> the include/asm directory.  The challenge is in the source code
> itself, trying to sort out all of the configuration options and
> utilizing the generic software.

In short, I think we're pretty much in agreement on the goal but are just
differing on the means to get there.

I neither want to do a 4xx port only to end up having it being so
4xx-centric that it gets split off from the main kernel tree and falls
into irrelevance nor do I want to completely redo the work of Paul, Cort,
yourself and many others that have been working on the PPC port for the
last several years.

After looking at the TiVo code, most of it is all so platform-specific and
derivative from the core Linux tree that there's little hope it'll ever be
included in the official tree as it stands now--and IMHO that's
unfortunate. I really would like to avoid that path if at all possible.

Thanks for your thoughts and opinions. Both are welcome and appreciated as
I work on this port!

Regards,

Grant

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
