Message-Id: <199907082014.PAA19744@www2.tuckeris.com>
Date: Thu, 08 Jul 1999 15:01:51 -0500
Subject: Re: QuickTime Streaming Server for Linux.. on x86
From: "Charles A. Jolley" <charles.jolley@zeratec.com>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 
> Also, lots and lots of "warning: multi-character character constant" coming
> from lines like
>
> static const FourCharCode kFractionLostPacketsSig = 'frac';
>
> Should those single ticks be quotes?
>
> -Hollis

The MacOS makes extensive use of 4-character constants (32-bit values) to
identify file and creator types, and also the types of resources in the
resource fork of a file.  The single quote method is a standard way of
indicating these constants and all MacOS compilers will take it without
complaint.  I encountered this same problem when porting some Mac stuff to
Linux some time ago.  I seem to recall that the compiler complained but
produced the right results anyway.  My Linux systems are down right now so I
can't check to make sure and I've since updated all my old code to work
around it.

Changing the single ticks to quotes will most definitely introduce errors,
though, because that will cause the compiler to produce a 32-bit pointer to
a NULL terminated string "frac", rather than a 32-bit value equal to the
four characters 'frac'.  This can be particularly deadly in code where types
are explicitly cast because it is still a 32-bit value either way.

Cheers,
-Charles


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
