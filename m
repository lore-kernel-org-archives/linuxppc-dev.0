Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 11 Sep 2002 15:38:48 -0400 (EDT)
From: Alban Wood <awood@bloodwolf.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx fpu emu
Message-ID: <Pine.LNX.4.44.0209111537420.1731-100000@manoir.bloodwolf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I forgot to mention that I was able to verify that the floating point
emulator *works*. I examined the result of a floating point division in
memory and it was valid. So I guess it is the libc I am using. Like I
said, could it be that it was compiled with -msoft-float?

I'm also not sure I can draw conclusions from the following fact, but I
disassembled the libc used on the board, and found no floating point
instructions. I did the same with a libc on a powerpc 604 I have here, and
did find floating point instructions.

Regards,

Alban



Alban Wood wrote:
> hello,
>
> Regarding my problem, I searched the list archives and did found some
mpu
> emul related posts but they were not exactly like my case.
>
> Basically, I have an RPX Lite-M board. The mpc850 does not have an fpu,
> but I have a need for non-intensive fpu operations. I don't want to
> compile applications and librairies with -msoft-float - for my needs the
> fpu emulator is really the way to go.
>
> The board successfully boots a slightly modified linux 2.4.9. I've
> compiled the kernel with and without math emulation.
>
> I also compiled a very simple application that does a floating point
> division and prints it. I explicitly specified -msoft-hard. (same with
the
> kernel btw), checked out the resulting assembly and did in fact find an
> fdiv instruction.
>
> Without the emulation, executing the program results in a floating point
> exception. This is normal.
>
> With the math emu kernel, the exception is caught and seemingly handled
as
> it should. However, a printf of a float results in "nan" (not a number).
>
> If I invoke the printf binary (printf "%f\n" 43.34343) it is able to
print
> a float.
>
> I didn't compile my own toolchain. I switch between the binary
> distributions I got from www.qslinux.org and timesys. I'm not sure this
is
> a good idea.
>
> Any ideas as to what could be wrong? Could it be that the libs in the
root
> filesystem I'm using for the board were compiled with -msoft-float,  and
> that as a result printf cannot properly output a float? (even though
it's
> been properly handled by the fpu emulator?)
>
>
> Thank you,
>
>
> Alban
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
