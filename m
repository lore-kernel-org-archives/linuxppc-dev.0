Date: Thu, 13 Sep 2001 15:51:23 -0400
Message-Id: <200109131951.f8DJpN228832@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: mlocke@mvista.com
Cc: cdonovan@lanier.com, linuxppc-embedded@lists.linuxppc.org
In-reply-to: <3BA0FA9E.5010204@mvista.com> (message from Matthew Locke on Thu,
	13 Sep 2001 11:27:42 -0700)
Subject: Re: Status on 403 (Oak) support
References: <C97ABDA0DC2DD511BA400002A50974132804F1@jdry.lanier.com> <3BA0FA9E.5010204@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I'm trying to run linux on a board with a 403GCX processor on it. I ran into
> an error while trying to compile the kernel as follows:
>
> {standard input}: Assembler messages:
> {standard input}:83: Error: unsupported relocation type
> {standard input}:84: Error: unsupported relocation type
> {standard input}:111: Error: unsupported relocation type
> {standard input}:128: Error: unsupported relocation type
> {standard input}:145: Error: unsupported relocation type
> {standard input}:149: Error: unsupported relocation type
> {standard input}:64: Error: unsupported relocation type
> make[1]: *** [ppc4xx_pic.o] Error 1
> make[1]: Leaving directory `/d/ctemp/src/src-linuxppc_2_4/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Error 2
>
> While searching the archives I found a thread which mentioned that that
> kernel no longer compiles for the 403 processor and there was no mention of
> a solution to the problem. Which version of the kernel should work on the
> 403GCX? Thanks for your help.

To figure this out we need to know which instructions the assembler
was trying to assemble.

To do this attempt to build the kernel, and when it fails, cd to
arch/ppc/kernel, paste in the command line that was used to compile
ppc4xx_pic.o, and replace the '-c -o ppc4xx_pic.o' with '-S'.

Then open up ppc4xx_pic.s in an editor, and pull out the
instruction(or directives) at lines 83,84,111,128,145,149 and 64, and
send them to the list.

>From there we might have a clue what went wrong.  Better yet, add in
the source code lines(by reading the third number in the nearest
.stabn directive preceding the line that generats the 'unsupported
relocation type').

--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
