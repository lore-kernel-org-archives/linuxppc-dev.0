Message-Id: <v04003a00b43d2b8b3cd6@[216.81.1.41]>
In-Reply-To: <Pine.HPX.4.10.9910271432490.18743-100000@gra-ux1.iram.es>
References: <3816BEA7.23AF7175@agelectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 27 Oct 1999 17:39:02 -0500
To: Gabriel Paubert <paubert@iram.es>
From: Tony Mantler <eek@escape.ca>
Subject: Re: question about altivec registers
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:21 AM -0500 10/27/99, Gabriel Paubert wrote:
[...]
>And why would you want to use a bitmap ? This seems braindead to me, put a
>value between 0 and 32 in vrsave. Since all registers are identical
>in use and purpose, save registers 0 to n. Disclaimer: I've not seen if
>the ABI specifies how and which Altivec registers are saved restored
>across calls.

It would seem to me that using a bitmap to mark used registers would allow
more flexibility on the compiler side to play with register usage without
incurring longer context switch times. I wouldn't try to guess the relative
tradeoff values though.


>Paranoid point of view: the restore must reload all altivec registers
>(or clear the ones which are not specified as used by VRSAVE), otherwise
>you might leak the contents of the Altivec registers of another process.
>I'm not a security expert, but I don't like this possibility at all.
[...]

Beyond security, clearning the registers would also serve to enforce strict
usage of whatever is defined as the VRSAVE format, and avoid the
possibility of a mouth-breathing code-typist releasing a binary that
doesn't mark it's registers, which in theory would only break once a
different application touches the altivec registers, resulting in a
situation of either A: the kernel being forced to save all altivec
registers (bad) or B: allowing those binaries to be broken and upsetting
it's users (slightly less bad). Obviously pre-breaking those binaries would
be the preferable solution, so they never need see the light of day.


That's my 2c.

Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
