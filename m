In-Reply-To: <Pine.LNX.4.05.9903191529140.14954-100000@p05-10.hartford.dialin.ntplx.com>
Date: Fri, 19 Mar 1999 21:41:02 +0100
To: Tom Rini <tmrini@ntplx.net>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: SCSI crashes with vger
Message-Id: <19990319214102.000691@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 19, 1999, Tom Rini <tmrini@ntplx.net> wrote:

>Er, I guess I wasn't too clear.  The wrong patch looked nothing like the
>right patch. :)  The "right" patch was the generic scsi fix listed in the
>2.2.2 rel notes, not sure what files tho.  However in skimming the 2.2.2
>patch I saw some changes to linux/drivers/scsi/ncr53c8xx.c.  reversing
>this had no effect I take it? (didn't look at the full context of where
>the diff went, might not effect us at all..)

I saw them but I didn't find them related to the problem. I may have been
wrong in my jugement however, I'll give this a closer look. I havent seen
any related fix to the SCSI generic code (only in some drivers),
apparently anything that looks like related to this bug. I may have
missed something and I'll look more closely.

Apparently, adding a save_flags()/cli()/restore_flags() in the
ncr_complete() function makes the code go a little bit further (to just
after the restore_flags() in my first test). I'm still moving the
restore_flag around to find out what is the exact critical region, but my
first impression is that part of the request structure itself (the
structure or some associated stuff) is beeing deallocated by another
interrupt. I still have to determine if another ncr interrupt happens at
this point or if it's something eventually coming from the MESH driver.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
