Subject: Re: TLB and CSSBAR problems with MPC8540 and BDI2000
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Dan Malek <dan@embeddededge.com>
Cc: fabidi@ultsol.com, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3FFF276C.4060003@embeddededge.com>
References: 
	 <704F2B356FCC3E49A909C625BD9E5C4002143D@ultsol01.tewks.ultsol.local>
	 <3FFEEAD9.80308@embeddededge.com>
	 <1073677509.10794.14.camel@chuck.arlut.utexas.edu>
	 <3FFF276C.4060003@embeddededge.com>
Content-Type: text/plain
Message-Id: <1073686698.3275.10.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Fri, 09 Jan 2004 16:18:18 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>      Yes, but that isn't the problem.
>
> >         Could anyone familiar with that workaround listed below verify
> > that
> > this could be causing the CPU to freeze/crash?
>
>      I've been there and done it.  The CCSRBAR can't be changing while you
>      are using the BDI2000 for debug.  The debug registers the BDI2000 is
>      trying to access are in this space.  If you move the space without the
>      BDI2000 knowing (i.e. in your code), the BDI2000 doesn't seem to be
>      able to track those changes and continues to try and access the
>      debug registers in the last known space.
>
>
>      So, what you have to do is (simply :-) ensure the CCSRBAR isn't
>      changing when you are debugging the software.

That leaves me with one question. When I don't do anything in the init
section of the bdi2000 except one command which is to remove the L2SRAM
from the initial MMU page and then I proceed with booting the board
boots fine. If I halt the board examine the CCSRBAR it has moved from
the default location.

I must be missing something, any ideas?

Thanks

--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
