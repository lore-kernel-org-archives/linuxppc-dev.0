Date: Wed, 30 Aug 2000 16:05:50 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michel Lanners <mlan@mcp.cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm in OF?
In-Reply-To: <200008301344.PAA10410@mcp.cpu.lu>
Message-ID: <Pine.HPX.4.10.10008301549190.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Michel,


> > All the OF I have seen had the capability to build new words in asm, with
> > a `code' definition IIRC. Maybe Apple's OF are crippled ?
>
> Apple's OF seems to have that capability as well (I think, guess and hope ;-).
> However, it does _not_ seem to have an assembler built-in. The 'code' word
> is defined all right.

You don't have any ppc-assembler vocabulary or similar, then ?

> When I do a 'see hido@', I only get:
>  >0 see hid0@ code hid0 ok
>  >0

Ok, how can something this close to the machine be delivered without an
assembler ?

> What I can do is look at the hex dump of the hid0@ word, and that gives me asm
> statements like for you (except that in Apple's OF, r20 holds the top stack
> item ;-). The fact that ' ' hid0@ dis' gives me a hex dump and not a
> disassembly is another evidence that Apple's OF doesn't know anything about
> asm....

Well, sincee you can type in hex, there is still some hope...

> > The syntax to build with an unknwown SPR is strange:
> > code ictc@
> > stwu r28,-4(r31)
> > 33f mfspr r28,*
> > bcctr 20,0
> >
> > generates the correct code, since I don't have ictc spr defined.
> > Otherwise mfspr 28,ictc might work.
>
> I will try this tonight, but I doubt I will be able to enter this as asm
> words. Do you know the alternate syntax? Would something lime this work:
>
> code 60000000 l, 6000000 l,

I think so, let me try:

ok code ictc@ ok 979ffffc l, 7f99faa6 l, 4e800420 l, ;code
ok see ictc@
code ictc@
edcc5c     stwu    r28,-4(r31)
edcc60     mfspr   r28,spr1017
edcc64     bcctr   always
ok ictc@ .
264d2
ok

It just works and returns garbage on a 603e, everytime a different value.

> as a sequence of 2 NOP's? How do you terminate a 'code' sequence?

Oops, forgot about it, my bad. With ';code', isn't it obvious ?

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
