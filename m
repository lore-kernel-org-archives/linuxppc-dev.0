Message-ID: <383A0E2D.CFACF894@jlc.net>
Date: Mon, 22 Nov 1999 22:46:53 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: LiuTao <tliu@ict.ac.cn>
CC: linuxppc <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: need suggestions
References: <3839F122.3BF6FEDF@ict.ac.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


LiuTao wrote:

> ........ The board
> is running well with vxWorks now.
> I want to make a bootloader on the board.


How do you load vxWorks?  I have worked on several vxWorks projects,
and all of the systems had the vxWorks TFTP loader in the rom.  Use
the same thing (whatever that is) to load the Linux/PPC image.

The zImage is linked such that you can just treat it as a bag o' bits
to dump into memory.  Even with non-standard boot loaders, all you
need to do is write a simple program to strip the 64K ELF header, place
your own header on the top, make sure it gets loaded above 0x180000
and jump to the start of the image.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
