Message-Id: <200008302138.XAA00750@piglet.grunz.lu>
Date: Wed, 30 Aug 2000 23:38:24 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: asm in OF? YES!
To: paubert@iram.es
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPX.4.10.10008301549190.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Yep, it works! I can boot off mesh again ;-)

On  30 Aug, this message from Gabriel Paubert echoed through cyberspace:
>> Apple's OF seems to have that capability as well (I think, guess and hope ;-).
>> However, it does _not_ seem to have an assembler built-in. The 'code' word
>> is defined all right.
>
> You don't have any ppc-assembler vocabulary or similar, then ?

Nope. Definitely not. We have hexdump and l, , isn't that enough? No
real hacker would use an assembler; thats for lamers ;-)

> Ok, how can something this close to the machine be delivered without an
> assembler ?

See above ;-))

> Well, sincee you can type in hex, there is still some hope...

Hex worked.

>> I will try this tonight, but I doubt I will be able to enter this as asm
>> words. Do you know the alternate syntax? Would something lime this work:
>>
>> code 60000000 l, 6000000 l,
>
> I think so, let me try:
>
> ok code ictc@ ok 979ffffc l, 7f99faa6 l, 4e800420 l, ;code
> ok see ictc@
> code ictc@
> edcc5c     stwu    r28,-4(r31)
> edcc60     mfspr   r28,spr1017

1017 is actually l2cr, but never mind...

> edcc64     bcctr   always
> ok ictc@ .
> 264d2
> ok

>> How do you terminate a 'code' sequence?
>
> Oops, forgot about it, my bad. With ';code', isn't it obvious ?

Hm, doesn't work in Apple's OF 1.0.5. end-code is the answer ;-). Here
is my ictc! implementation, if anyone's interested:

code ictc!
        7e9bfba6 l, 829f0000 l, 3bff0004 l, 4e800020 l,
end-code

That is roughly this in asm:

	mtictc	r20	(or mtspr 1019,r20)
	lwz	r20,0(r31)
	addi	r31,r31,4
	blr

Verifyed to slow the system on a busy loop:

: loop
	begin
	1- dup 0<
	until
	drop
;

11 ictc! slows this loop by a factor of 4.

Now, go figure why this helps the MESH driver... It seems to use some
busy loop timing somewhere; however there is the ms word available which
uses the timebase and is accurate even on my upgraded box.... That would
have been the better choice, unless the driver uses sub-1ms loops. Which
would explain...

Anyway, thanks for your help, Gabriel!

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
