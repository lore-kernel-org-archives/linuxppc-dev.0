Message-ID: <XFMail.990420192904.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.9904201339320.26859-100000@mercator.cs.kuleuven.ac.be>
Date: Tue, 20 Apr 1999 19:29:04 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Subject: Re: Current egcs, binutils and kernel (fwd)
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I looked at the code in "misc.S" and it appears to me [by cursory glance]
that it already is "__lshrdi3" - i.e. the code that is there is doing a
logical shift and not an arithmetic one!

It seems to me that you could just add "__lshrdi3" as an alternate entry 
point.

I need to investigate the existing code and see if maybe my impression
is just "day's end..."

On 20-Apr-99 Geert Uytterhoeven wrote:
> 
> ---------- Forwarded message ----------
> Date: Tue, 20 Apr 1999 13:15:41 +0200
> From: Reinhard Nissl <rnissl@gmx.de>
> To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
> Cc: "linux-apus@sunsite.auc.dk" <linux-apus@sunsite.auc.dk>
> Subject: Re: Current egcs, binutils and kernel
> 
> Hi,
> 
> Geert Uytterhoeven wrote:
> 
>> On Wed, 14 Apr 1999, Reinhard Nissl wrote:
>> > has anyone had success in compiling (egcs-1.1.2 and binutils-2.9.1.0.23)
>> > the current APUS kernel with support for network block devices (nbd.c)?
>> >
>> > I get an undefined reference to __lshrdi3 from nbd_ioctl(), which looks
>> > like a compiler / binutils bug.
>>
>> Hence a __lshrdi3() routine needs to be added to arch/ppc/kernel/misc.S.
> 
> I had a look into misc.S and found similar routines (__ashrdi3) there. Then I
> searched in the egcs-1.1.2 sources for files, where such functions are
> referenced. I found definitions in egcs-1.1.2/gcc/config/rs6000/rs6000.md but
> they are not native ppc assembler instructions. As I'm not that much used to
> *.md files and ppc assembly code, I'm currently not able to define the missing
> function in misc.S myself.
> 
> I checked the kernel source diffs from version 2.2.4 to 2.2.6 for lshrdi3 and
> had only success for arch=sparc. So, is there anybody who can add the missing
> function to misc.S for arch=ppc?
> 
>> Greetings,
>>
>>                                                 Geert
> 
> Bye.
> --
> Dipl.-Inform. (FH) Reinhard Nissl
> mailto:rnissl@gmx.de
> 
> 
> 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
