Date: Mon, 22 Mar 1999 11:32:57 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Generic problem with BootX
In-Reply-To: <19990322141544.028907@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.990322113136.7474C-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Mar 1999, Benjamin Herrenschmidt wrote:

> I think I finally found the cause of the crash: During relocation of the
> kernel by BootX, it looks like the UW is still DMA-ing things to main
> memory, damaging the kernel. I added a reset of the Symbios chip just
> before switching the MMU off, and now, my kernel boots again on the G3.
> 
> This is a generic problem with any device that may do DMA. I thought most
> of this would be fixed by the shutdown-proc mecanism used in bootx, but
> apparently, this is not the case.
> 
> So, I'll soon release a version of BootX that resets this card before
> booting, and also resets all the DBDMA channels (could someone send me a
> list of all possible DBDMA channels on various chips ? I think I know
> where the mac-io ones are, but I don't have a Grand-Central not OHare
> based machine available now).

Please, if you do this, please make it do a similar reset before booting
MkLinux.  The stock G3 UW cards have been a thorn in our side for the same
reason.


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
