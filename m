From: Michel Lanners <mlan@mcp.cpu.lu>
Message-Id: <200008301344.PAA10410@mcp.cpu.lu>
Subject: Re: asm in OF?
To: paubert@iram.es (Gabriel Paubert)
Date: Wed, 30 Aug 2000 15:44:03 METDST
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPX.4.10.10008301050220.15978-100000@gra-ux1.iram.es>; from "Gabriel Paubert" at Aug 30, 100 11:48 am
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Gabriel,

> All the OF I have seen had the capability to build new words in asm, with
> a `code' definition IIRC. Maybe Apple's OF are crippled ?

Apple's OF seems to have that capability as well (I think, guess and hope ;-).
However, it does _not_ seem to have an assembler built-in. The 'code' word
is defined all right.

> On one of my MVME2600 boxes (the only one which I can still switch to Open
> Bug^WFirmware):
>
> ok see hid0@
> code hid0@
> e49110     stwu    r28,-4(r31)
> e49114     mfspr   r28,hid0
> e49118     bcctr   always

When I do a 'see hido@', I only get:
 >0 see hid0@ code hid0 ok
 >0

What I can do is look at the hex dump of the hid0@ word, and that gives me asm
statements like for you (except that in Apple's OF, r20 holds the top stack
item ;-). The fact that ' ' hid0@ dis' gives me a hex dump and not a
disassembly is another evidence that Apple's OF doesn't know anything about
asm....

> ok see hid0!
> code hid0!
> e4912c     sync
> e49130     isync
> e49134     mtspr   hid0,r28
> e49138     isync
> e4913c     sync
> e49140     lwz     r28,0(r31)
> e49144     addi    r31,r31,4
> e49148     bcctr   always
> ok

Apple's code looks very similar....

> The syntax to build with an unknwown SPR is strange:
> code ictc@
> stwu r28,-4(r31)
> 33f mfspr r28,*
> bcctr 20,0
>
> generates the correct code, since I don't have ictc spr defined.
> Otherwise mfspr 28,ictc might work.

I will try this tonight, but I doubt I will be able to enter this as asm
words. Do you know the alternate syntax? Would something lime this work:

code 60000000 l, 6000000 l,

as a sequence of 2 NOP's? How do you terminate a 'code' sequence?

Thanks a lot

Michel

--
.sig eater at work

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
