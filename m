Message-ID: <36F1F4B5.C0843FF5@wanadoo.fr>
Date: Fri, 19 Mar 1999 07:54:45 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Patrik Jonsson <patrik@ucolick.org>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: egcs-1.1.2 build problems
References: <Pine.GSO.4.03.9903181139140.22956-100000@isis.ucolick.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Patrik Jonsson wrote:
> 
> Hi all,
> I'm trying to build the latest egcs, but it fails with the following
> error:
> 
> In file included from ../../../egcs-1.1.2/libio/iolibio.h:1,
>                  from ../../../egcs-1.1.2/libio/libioP.h:40,
>                  from ../../../egcs-1.1.2/libio/iogetline.c:26:
> ../../../egcs-1.1.2/libio/libio.h:168: stdio-lock.h: No such file or
> directory
> 
> Where is the stdio-lock.h file supposed to come from?

It is supposed to be in /usr/include, but it is not there, because
glibc-1.99 is not quite glibc-2. If you have libg++-devel installed,
there is one in /usr/include/g++ which you could copy to /usr/include.

Or you could change the definition of __GLIBC__ from 2 to 1 in
/usr/include/features.h. This takes care of many of these "lying
glibc-961212" problems and introduces some others.

Or you could hack libio/libio.h to not include stdio-lock.h any more.

Or you could install pre-R5. This is what I have.

I don't know what those who compiled egcs-1.1.2 sucessfully under R4
were doing. I suppose Gary Thomas has a solution?

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
