From: Keith Owens <kaos@ocs.com.au>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Where does ppc define __start___ksymtab? 
In-reply-to: Your message of "Thu, 03 Aug 2000 14:01:44 +0200."
             <Pine.HPX.4.10.10008031350200.9070-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Aug 2000 22:18:36 +1000
Message-ID: <31728.965305116@ocs3.ocs-net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000 14:01:44 +0200 (METDST),
Gabriel Paubert <paubert@iram.es> wrote:
>On Thu, 3 Aug 2000, Keith Owens wrote:
>> If we want anything in the kernel then we put it there, and say where
>> we want it.  Anything not explicitly listed is discarded.  I just did
>> this with ix86 and vmlinux shrank by 9K, mainly in .bss.  It would not
>> boot afterwards so obviously some part of that 9K is required but right
>> now it works by some "magic" storing the unknown sections.  I'm going
>> to track down which sections are not being explicitly placed.
>
>I have trouble parsing this, since the bss by definition does not occupy
>any space in vmlinux.

It is wierd.  Even though arch/i386/vmlinux.lds contains
".bss : { *(.bss) }", something extra is getting stored in .bss.  The
data has the same attributes as .bss, ALLOC only, alignment 2**5 but
its section name is not ".bss".  Adding

  .note : { *(.note) }
  .rest : { *(*) }

to the end of an otherwise untouched arch/i386/vmlinux.lds changes
vmlinux from this

 14 .bss          0003bb8c  c02a6c40  c02a6c40  001a7c40  2**5
                  ALLOC
 15 .comment      000044a0  00000000  00000000  001a7c40  2**0
                  CONTENTS, READONLY
 16 .note         00001680  c02e27cc  c02e27cc  001ac0e0  2**0
                  CONTENTS, READONLY

to this

 14 .bss          00014240  c02a6c40  c02a6c40  001a7c40  2**5
                  ALLOC
 15 .comment      000044a0  00000000  00000000  001a7c40  2**0
                  CONTENTS, READONLY
 16 .note         00001680  c02bae80  c02bae80  001ac0e0  2**0
                  CONTENTS, READONLY
 17 .rest         0002794c  c02bae80  c02bae80  001a7c40  2**5
                  ALLOC

Which is a lot more than 9K of unknown data.  I was looking at the on
disk size which contains the .note section, however removing that
should only shrink by 4K so I do not understand why vmlinux shrank by
9K.  The final step on i386 removes .note and
.comment from the bootable kernel anyway.

I'm trying to track down where the extra .bss like data is coming from.
I will mail the list when I find something.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
