Date: Tue, 4 May 1999 09:36:27 -0500
From: Brian Ford <ford@vss.fsi.com>
To: Brendan Simon <brendan@dgs.monash.edu.au>
cc: Cross-GCC <crossgcc@cygnus.com>, egcs mailing list <egcs@cygnus.com>,
        linuxppc-user <linuxppc-user@lists.linuxppc.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: egcs-1.1.2 powerpc cross-compiler question.
In-Reply-To: <372E6B45.92CCD632@dgs.monash.edu.au>
Message-ID: <Pine.SGI.4.03.9905040924570.1503-100000@uscream.vss.fsi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 May 1999, Brendan Simon wrote:

> I've tried building egcs-1.1.2 as a powerpc-eabi cross compiler and a
> powerpc-linux cross compiler.  I had instructions from the LinuxPPC web
> site on building the powerpc-linux cross compiler.  The configure
> command was "configure --target=powerpc-linux --with-newlib".  The only
> difference between my setup and the instructions on the web site is that
> I am using the FULL egcs-1.1.2 source where as the instructions were for
> the CORE egcs-1.1.2 source.  I want to use C and C++ so I used the full
> distribution.  The error message I am getting looks like its related to
> the objective C build which I don't need but I am interested in trying
> it one day.  The errors are:
> 
> egcs-1.1.2/gcc/objc/runtime.h:31 stdio.h: No such file or directory
> egcs-1.1.2/gcc/objc/runtime.h:31 ctype.h: No such file or directory
> 
> I did not have these problems building the native linux build of
> egcs-1.1.2.  It obviously knows how/where to find the appropriate
> headers.
> 
> How can I get the objc build to find the appropriate header files ?
> Can I just delete the gcc/objc directory to avoid building objc ?
> 
You must use the --with-headers=dir configure flag to point to the c
library header files you will be using in your embeded system.  I do not
believe you can build objc without them.

Yes, I think you should be able to avoid building objc just by deleting it
or moving it to a new name.

> The CONFIGURE file in the INSTALL directory says that if you use
> --enable-languages=c++ then the other languages will be omitted.  I
> tried that but I still get the above error messages indicating that the
> objc compiler is trying to be built.
> 
I do not believe that that configure flag works with the 1.1.2 release,
only the current snapshots.  Please use make LANGUAGES='c c++' for this
purpose.  Also, you could just use make cross as it was designed for this
purpose.

> Thanks,
> Brendan Simon.
> 
> PS. The other difference I had to the LinuxPPC howto, is I included
> --program-prefix=powerpc-linux- when building egcs and binutils.  Will
> egcs have a problem finding the correct binutils with this option ?
> Would --exec-prefix help to solve this, if this is a problem ?
>
I don't quite know enough to be helpfull on this question, but if you
build binutils and egcs in one shot by putting links to the individual 
binutils packages in the egcs tree and use make cross, everything will
just work and the installed binaries will have the target as their prefix
without you needing to specify it.

> Brendan.
> 

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
