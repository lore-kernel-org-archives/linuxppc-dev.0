Date: Wed, 30 Aug 2000 11:48:11 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm in OF?
In-Reply-To: <200008291737.TAA00677@piglet.grunz.lu>
Message-ID: <Pine.HPX.4.10.10008301050220.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 29 Aug 2000, Michel Lanners wrote:

>
> Hi all,
>
> Does anybody know how to embed machine code into an OF script (into
> nvramrc, that is)? I suppose OF doesn't have an assembler built-in, so
> machine code would be the only option.

All the OF I have seen had the capability to build new words in asm, with
a `code' definition IIRC. Maybe Apple's OF are crippled ?

> For the curious, what I'm trying to do is get my box (7600 upgraded with
> G3/300) to boot again from my IBM disk on the MESH SCSI bus. Right now,
> it does that only if I run the G3 below 200 MHz, or the bus speed around
> 40 MHz. Anything faster, and I can't access that disk on the MESH bus.
> The external (53c96) is o, however... but much slower.
>
> So, I wanted to check whether using the L1 cache throttling mechanism to
> slow down the CPU during boot would help anything... I can then release
> the brake later, once Linux is up (which doesn't have any problem with
> the MESH).
>
> To use the cache throttling, I need to access the ICTC register, but
> there is no OF method to do that. So I would have to code one myself...
>
> Since it seems the OF MESH driver is at fault, I could try to patch that
> one, but that seems like an even harder task...
>
> I could also try and copy other special register access methods (like
> hid0@ and hid0!) if I knew how...

On one of my MVME2600 boxes (the only one which I can still switch to Open
Bug^WFirmware):

ok see hid0@
code hid0@
e49110     stwu    r28,-4(r31)
e49114     mfspr   r28,hid0
e49118     bcctr   always
ok see hid0!
code hid0!
e4912c     sync
e49130     isync
e49134     mtspr   hid0,r28
e49138     isync
e4913c     sync
e49140     lwz     r28,0(r31)
e49144     addi    r31,r31,4
e49148     bcctr   always
ok

The syntax to build with an unknwown SPR is strange:
code ictc@
stwu r28,-4(r31)
33f mfspr r28,*
bcctr 20,0

generates the correct code, since I don't have ictc spr defined.
Otherwise mfspr 28,ictc might work. After this, I have:

ok see ictc@
code ictc@
edcc5c     stwu    r28,-4(r31)
edcc60     mfspr   r28,spr1017
edcc64     bcctr   always
ok

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
