Message-Id: <v04003a0ab4c83ad28027@[216.81.27.16]>
In-Reply-To: <Pine.HPX.4.10.10002101022110.1866-100000@gra-ux1.iram.es>
References: <v04003a01b4c7a49e41c5@[216.81.27.16]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 10 Feb 2000 04:26:27 -0600
To: Gabriel Paubert <paubert@iram.es>
From: Tony Mantler <eek@escape.ca>
Subject: Re: Porting MOL to Intel Linux?
Cc: Brad Boyer <flar@pants.nu>, Dan Bethe <dan_bethe@yahoo.com>,
        linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:47 AM -0600 2/10/2000, Gabriel Paubert wrote:
>On Wed, 9 Feb 2000, Tony Mantler wrote:
[...]
>> It shouldn't be terribly complicated to come up with PPC equivilant code
>> for x86 operands and set up a little virtual userlevel-only x86
>> environment. Optimizing it, however, is another thing entirely. :)
>
>Indeed, there is a small realmode x86 emulator out there which I wrote
>only to execute BIOS ROM code (otherwise the screen would never come up
>right). It is in my prepboot bootloader and a user mode version is at
>ftp://vlab1.iram.es/pub/other/em86_user.tgz.
>
>Missing features:
>- protected mode segmentation (not very complex, but maybe heavy penalty
>if you want to perform all checks)
>- FPU (hard)
>- paging, hard if you want to be fast, but applications should not
>even know that paging exists
>- debug registers, you don't even want to know that they exist...
>
>in other words it's a 486SX real mode only emulator. The current version
>is small (24kB), running at the speed of a 33MHz 386 on a 200MHz 603e.
>There are ways to make it theoretically faster but at a significant cost
>in size which could make it a cache pig (the fact that it currently runs
>entirely out of the cache even on a 603e is a big boost to performance).
>What this emulator solves is the problem of efficiently emulating the
>flags (just have a look at the code).

In theory, one could completely gut the linux kernel, prop it up in an
emulator inside an optimisticly simple virtual machine, and run all the
ia32 binaries you want in there, but that's a bit of a different design
goal than running ia32 binaries transparently (for suitably broad
definitions of the word) beside ppc binaries.

Though, come to think of it, that idea's almost worth pursuing on it's own
merit...


>> PPC PEM section 3.1 seems to indicate that the PPC chip reverses every
>> aligned double word, then mangles the ea of the operand to point to the
>> right address.
>>
>> Somehow that looks to me like it would break very painfully on any
>> structure (maybe?) or misaligned scalar (definatley) that was passed
>> between le and be code.
>
>No you don't want to run the PPC in LE mode, BE and use *brx instruction
>to access memory (and even memory image of registers in my emulator) since
>these instructions do exactly what you want when running the processor in
>BE mode.

Ah, I see. The PPC PEM documentations was a bit sparse about the
differences between the endian-reverse load and store instructions, and the
LE/BE modes. I'm assuming that the endian-reversed instructions are much
more sane than then LE mode then?


>Besides running the PPC in LE mode requires changing the setup of the host
>bridge if you ever access devices or handle this case specially (and you
>don't want to add a a check for device/memory access on every instruction
>which accesses memory, every single added check is a serious hit on
>performance).

In theory, since all the x86 code is userspace, any locally mapped IO range
could be flagged to generate an exception on access, at which point the
emulator would start sane-ifying things on an access by access basis.

Of course, avoiding the situation entirely would be a much preferable
solution. Most userspace shouldn't have to access IO, and anything that
does should be native PPC already.


>Now what happens in an SMP system if you run one processor in BE and the
>other in LE mode, I claim that this is slightly conflictual ;-)

A sanity nightmare atleast. :)


[...]
>Basically, I came to the conclusion that the capcbility to switch endian
>modes on every interrupt/task switch on PPC is a joke. You have to be
>always in the same mode.

I'm wondering if the whole LE mode on the PPC is a joke, or maybe some sort
of microsoft-pacifier to get them to port NT to PPC. (Hmm, on second
thought, perhaps that's a can of worms not worth opening)


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
