Message-Id: <v04003a01b319eec4b201@[205.161.35.44]>
In-Reply-To: <19990319214102.000691@mail.mipsys.com>
References: 
 <Pine.LNX.4.05.9903191529140.14954-100000@p05-10.hartford.dialin.ntplx.com
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 20 Mar 1999 19:42:40 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Douglas Godfrey <dvdoug@tiac.net>
Subject: Re: SCSI crashes with vger
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Reoly to Benjamin Herrenschmidt, 3/19/99 9:41 PM +0100: Re: SCSI crashes
with vger
>On Fri, Mar 19, 1999, Tom Rini <tmrini@ntplx.net> wrote:
>
>>Er, I guess I wasn't too clear.  The wrong patch looked nothing like the
>>right patch. :)  The "right" patch was the generic scsi fix listed in the
>>2.2.2 rel notes, not sure what files tho.  However in skimming the 2.2.2
>>patch I saw some changes to linux/drivers/scsi/ncr53c8xx.c.  reversing
>>this had no effect I take it? (didn't look at the full context of where
>>the diff went, might not effect us at all..)
>
>I saw them but I didn't find them related to the problem. I may have been
>wrong in my jugement however, I'll give this a closer look. I havent seen
>any related fix to the SCSI generic code (only in some drivers),
>apparently anything that looks like related to this bug. I may have
>missed something and I'll look more closely.
>
>Apparently, adding a save_flags()/cli()/restore_flags() in the
>ncr_complete() function makes the code go a little bit further (to just
>after the restore_flags() in my first test). I'm still moving the
>restore_flag around to find out what is the exact critical region, but my
>first impression is that part of the request structure itself (the
>structure or some associated stuff) is beeing deallocated by another
>interrupt. I still have to determine if another ncr interrupt happens at
>this point or if it's something eventually coming from the MESH driver.
>
>
The interrupt code that completes an I/O request must verify that the
interrupt is actually an I/O completion before deallocating any structures
relating to a request. The DMA engine in the NCR chip could still be in
progress and the page containing the SCSI command list could be re-used,
corrupting the SCSI commands and causing the NCR chip to stomp on any
random piece of memory.

This may be caused by mis-interpreting an interrupt in code that (wrongly)
asumes that there is no other device active that can cause an interrupt.

If this error only happens on G3 or 604E CPUs then the code should be
added to the interrupt handler synchronize the CPU with the NCR chip.
i.e. sync(), Read, write and read again the NCR chips status register.

Thanx...
  Doug



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
