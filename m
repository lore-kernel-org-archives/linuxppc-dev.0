In-Reply-To: <v04011701b2ba429e00af@[209.86.156.161]>
Date: Thu, 7 Jan 1999 12:59:44 +0100
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        "Timothy A. Seufert" <tas@mindspring.com>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Great IDE perf (WAS: Strange PMAC IDE performance)
Message-Id: <19990107125944.017660@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 7, 1999, Timothy A. Seufert <tas@mindspring.com> wrote:

>This works on the PowerBook 2400 as well.  It so happens that the IDE
>controllers also sit at 0xf3020000 and 0xf3021000 on the O'Hare.  The value
>of the register at offset 0x200 is slightly different under MacOS:
>0x221025.  I tried both values, it didn't seem to make a difference.  I did
>a quick hack to ide-pmac.c (it just stuffs the value in, no questions
>asked, though it does actually use the correct base address instead of hard
>coding 0xf3020000) and that worked.  Performance is up to 5.6 MB/s (was in
>the region of 1.6 before).

Great ! I also included this initialisation in my latest set of patch and
test kernel but currently, I test against "heathrow-ata" in the
compatible property, so it won't do it on your machine. Could you tell me
the value of the compatible property of the ATA on the 2400 ? I'll add
similar code with 0x221025 for OHare and 0x211025 for heathrow, just to
be safe.

>Any guesses about the meaning of this register?  It feels wrong somehow to
>just ape MacOS without knowing what's really going on.  :)

Good question ;-) I'm wondering if this could configure the timing of the
DMA engine on the data port. I tried with my CD-ROM and it works too (I
didn't hdparm it but at least, the CD mounts weel and I didn't see any
problem). It would be great to test with really slow devices however (my
CD is a very fast one).

Another question about IDE: Does someone have any info about IDE ZIP
drives ? I received a mail from someone which is having all sorts of
trouble with a ZIP in the expansion bay. Looks like the beast is not
correctly answering ATAPI commands sent by the driver (yeah, ATAPI, I
thought a ZIP would be plain IDE or floppy-IDE but apparently, his drive
is recognized as an ATAPI one).

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
