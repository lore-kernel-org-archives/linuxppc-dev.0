To: Paul.Mackerras@cs.anu.edu.au
Cc: Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 10 Aug 1999 09:18:21 +0200
In-Reply-To: Paul Mackerras's message of "Tue, 10 Aug 1999 11:00:29 +1000"
Message-ID: <d34si8xfwi.fsf@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Paul" == Paul Mackerras <paulus@cs.anu.edu.au> writes:

Paul> If you take out the eieios, you will break other drivers,
Paul> starting with the OHCI USB host driver.  Can we think of another
Paul> way around the problem?  You could use le32_to_cpup for loading
Paul> from the frame buffer, but there isn't currently an equivalent
Paul> for stores, unfortunately (one could be invented, though).

This is quite easily solved by putting in mb()'s in the right
places. This is how it is done for other drivers that are supposed to
work on the Alpha.

Paul> I thought the point of the aty_ld/st* routines was to avoid one
Paul> add instruction each time by using the PPC indexed addressing
Paul> mode.  Anyway, IMO the aty_ld/st* routines *should* include the
Paul> eieio.  That would mean you wouldn't need the explicit eieio()
Paul> calls scattered through the rest of the driver.  I guess it's
Paul> just luck that it works where you do a sequence of aty_st_le32's
Paul> to set up some drawing command and then call wait_for_fifo (or
Paul> wait_for_idle) which does an aty_ld_le32.  Or doesn't it matter
Paul> if the load gets done before all of the stores have completed?

Having mb()'s explicitly put into the driver in the right places also
makes sure that a driver will work on other architectures. Right now a
driver that is written for the PPC is likely not to work on the Alpha
if the author expects readl/writel to guarantee write ordering.

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
