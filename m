Message-ID: <3FFF276C.4060003@embeddededge.com>
Date: Fri, 09 Jan 2004 17:13:00 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Cc: fabidi@ultsol.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: TLB and CSSBAR problems with MPC8540 and BDI2000
References: <704F2B356FCC3E49A909C625BD9E5C4002143D@ultsol01.tewks.ultsol.local>	 <3FFEEAD9.80308@embeddededge.com> <1073677509.10794.14.camel@chuck.arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew S. McClintock wrote:

>  So more specifically, if the bdi2000 init section moves the CCSRBAR and
> maps a TLB to the location the CCSRBAR was moved too you can't just
> moved the CCSRBAR back to its default location?

     No, because the BDI2000 doesn't know that _you_ have done that in
     your code.  If you do it in the BDI init secion, it will know.


> .... One would also need to
> remap the TLB entry to CCSRBAR?

     Yes, but that isn't the problem.

>         Could anyone familiar with that workaround listed below verify
> that
> this could be causing the CPU to freeze/crash?

     I've been there and done it.  The CCSRBAR can't be changing while you
     are using the BDI2000 for debug.  The debug registers the BDI2000 is
     trying to access are in this space.  If you move the space without the
     BDI2000 knowing (i.e. in your code), the BDI2000 doesn't seem to be
     able to track those changes and continues to try and access the
     debug registers in the last known space.


     So, what you have to do is (simply :-) ensure the CCSRBAR isn't
     changing when you are debugging the software.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
