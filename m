Date: Sun, 21 Feb 1999 16:05:23 +0100
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Strange PPC things (was: 601 vs head.S)
Message-Id: <19990221160523.008759@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Feb 21, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>Found it... had to take out the 2 nop's in hash_page this time.  Vger
>(cvs) and samba (rsync) have the fix, if you want a precompiled
>kernel, try ftp://ftp.linuxppc.org/linuxppc/kernel/powermac/test/vmlinux.

Is this the problem you already mentioned here about some 601 needing a
special alignement for the rfi instruction ? This issue will certainly
arise again when porting to NuBus machines... Is there any way, via
eventually some assembler directives, to align it all the time the way it
should be or is the problem more tricky ? We could have kind of "fix 601"
option for the kernel like there is for some bogus x86.

Actually, you wrote:

<<<<
Sync and isync turn out to be needed on some revs of some chips
(particularly the 601) around rfi and mtmsr instructions.

(In fact the 601 seems to have another weird bug - in the hash_page
routine in head.S, the location of the rfi instruction w.r.t. cache
lines appears to be critical on the 601; if it's wrong, you get a
machine check on the rfi instruction.  At one stage I found that with
2, 3, 6, or 7 nops added, it would work; with 0, 1, 4 or 5 nops added
it wouldn't. :-)
>>>>

I prefer making BootX bootstrap rock solid, so I'll put back a couple of
syncs. Do I need both sync and isync ?

Also, did you experiment show you that this rfi had to be aligned in this
specific case (exception ?) or is it a generic problem with rfi ? I do
have one rfi in the new BootX bootloader, so I'm wondering...

I have one other "strange" things about the PPC, I'll dump it now:

Apple's implementation of CompareAndSwap is using both sync and isync, I
don't know why exactly. It does some other "interesting" things so I'm
wondering if there could be so;e problems with the reservation too. If
you want to look at it, use macsbug and do an "ilp CompareAndSwap". On my
PowerBook, I have approximately:

(on entry, r5=ptr to value, r3=old value, r4=new value)

 clrlwi.r6,r5,1e
 beq    do_compare_and_swap
 b      some_other_piece_of_code
do_compare_and_swap: 
 lwarx  r6,0,r5
 cmpw   r6,r3
 bne    failed
 sync
 stwcx. r4,0,r5
 bne-   do_compare_and_swap
 sync
 isync
 li     r3,1
 blr
failed:
 sync
 stwcx. r6,0,r5
 li     r3,0
 blr

Note that this changed with versions of Apple's lib, and I don't know for
sure why it's doing the second stwcx. (looks like it's trying to put back
the previously read value. I beleive they do that to get rid of the
reservation when leaving the function. The early version of the
DriverServicesLib did something much more simple, but still with the sync.

Note also that if the value to CompareAndSwap is not strictly aligned on
a cache line boundary, they jump to some other piece of code I've not
traced yet, looks like there is a potential issue here too. We don't have
any of those things in linux implementation of atomic operations.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
