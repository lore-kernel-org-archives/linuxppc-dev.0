Message-ID: <20021220170607.22771.qmail@web41207.mail.yahoo.com>
Date: Fri, 20 Dec 2002 09:06:07 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: Re: After Uncompresseing Linux..., what's next
To: Gary Thomas <gary@chez-thomas.org>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1040403153.32282.6220.camel@hermes.chez-thomas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gary,

I really appreciate your help. Here is what i am
doing. Sorry it is little long. But was necessasry.

1. I have a boot loader(xrom.elf) of size around 400KB
which basically have menu driven tests along with an
option to jump to linux kernel(zImage.initrd.elf).

2. xrom.elf is compiled to start at 0xfffffffc and
jump to 0x00000000 to have rest of functionality.
zImage.initrd.elf is compiled to start at 0x00400000.

3. I load zImage.initrd.elf first and then xrom.elf
(xilinx tool makes sure that they are loaded to
corresponding locations based on ELF header).

4. After loading both, i start running xrom.elf and it
shows up a menu in my UART terminal. I jump to linux
(0x00400000).

5. I see that linux is basically reading the board
info, setting UART, prints some boot messages onto it
and then performs uncompression (gunzip function takes
the rest of linux image and puts the uncompressed code
starting from 0x0).

6. Up untill, everything is ok. After this, control
jumps to 0x0 and starts executing.

My problems are,

a. Once the uncompression process is done, i am not
sure if the image is copied to 0x0 (i do see value
changes in memory starting from 0x0).
b. As uncompression process is embedded into
zImage.initrd.elf, i do not objdump does not tell me
which function it is going to execute after
uncompression.

Please suggest.

Thanks,
Prakash





--- Gary Thomas <gary@chez-thomas.org> wrote:
> On Fri, 2002-12-20 at 09:48, Prakash kanthi wrote:
> > I do have xilinx tools and i am working with their
> V2P
> > product. I completely understands what you are
> said.
> > But the problem is, right after the uncompression
> and
> > cpy to 0x00000000, i loose total control because i
> > don't have any clue what is getting executed.
> >
>
> What sort of things can you do with the Xilinx
> tools?  Is
> there any way to set [hardware] breakpoints or
> single step?
>
> > And also, i have my boot monitor code at
> 0x00000000,
> > before uncompress process overwrites it. I see
> that
> > some of that code is getting executed after jump
> to
> > 0x0. I reason i am overwriting 0x0 is because, i
> only
> > have 8MB RAM.
> >
>
> 8M should be plenty of RAM.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
