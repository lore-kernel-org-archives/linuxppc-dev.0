Date: Mon, 22 Mar 1999 14:15:44 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Generic problem with BootX
Message-Id: <19990322141544.028907@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think I finally found the cause of the crash: During relocation of the
kernel by BootX, it looks like the UW is still DMA-ing things to main
memory, damaging the kernel. I added a reset of the Symbios chip just
before switching the MMU off, and now, my kernel boots again on the G3.

This is a generic problem with any device that may do DMA. I thought most
of this would be fixed by the shutdown-proc mecanism used in bootx, but
apparently, this is not the case.

So, I'll soon release a version of BootX that resets this card before
booting, and also resets all the DBDMA channels (could someone send me a
list of all possible DBDMA channels on various chips ? I think I know
where the mac-io ones are, but I don't have a Grand-Central not OHare
based machine available now).

I beleive I also need to reset an eventual adaptec board, and BootX will
probably require similar fixes for all sorts of boards (fortunately,
boards that DMA to system memory all the time even after a MacOS shutdown
are quite rare).

If you know of a device that may fall in this category, please send me
enough infos for me to reset it (device-tree name, how to reset it, etc...)


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
