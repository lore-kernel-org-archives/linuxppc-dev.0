Date: Mon, 8 Feb 1999 21:01:27 -0600 (CST)
From: Takashi Oe <toe@unlinfo.unl.edu>
To: Beecher Greenman <rbg6038@ritvax.isc.rit.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: A different Window Maker problem
In-Reply-To: <01J7H7PIJZ9EA3CISC@ritvax.isc.rit.edu>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990208203524.5997A-100000@selq119.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Sun, 7 Feb 1999, Beecher Greenman wrote:

> 
> Recently I tried to install XFree86 on my R4 system. I downloaded the 
> 3.3.3.1 binaries from ftp.xfree86.org, and everything installed fine. 
> However, now Window Maker refuses to start. WHen it tries, it complains 
> about an error in the shared libs...
> 
> wmaker:error in loading share libraries
> : undefined symbol _Xsetlocale

This is because X libs from ftp.xfree86.org are compiled without
-DX_LOCALE.

> 
> No indication of what library to use or anything. A recompile did not 
> appear to solve the problem. Other windowmanagers compile and run fine. I 

You might have a mixture of things in your system.  All of your X apps 
which use X's locale will refuse to run since the locale support is not
compiled in.  If you want to continue using the binaries from the xfree86
site, make sure there is no -DX_LOCALE or something similar when you
compile Window Maker or any other X apps that may need X's locale.

It would be nice if glibc-1.99 based X libs available at ftp.xfree86.org
are compiled with -DX_LOCALE for compatibility since most glibc-1.99 based
X apps available for ppc platform are compiled with -DX_LOCALE.

For glibc-2.1 based libs or X apps, however, -DX_LOCALE is no more.  We
have got the semi-working locale support from glibc now.


Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
