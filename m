From: "Jon-Erling Dahl" <jon-erling.dahl@its4mobility.com>
To: "Michael Habermann" <MHabermann@gmx.de>,
	"'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: libraryopt
Date: Sat, 2 Mar 2002 10:53:58 +0100
Message-ID: <GKEKJGELJKLLBBAFIGAIMEKACAAA.jon-erling.dahl@its4mobility.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <5.1.0.14.0.20020301083221.01d7da58@pop.gmx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >I'm having problems getting libraryopt doing something.
> >(http://libraryopt.sourceforge.net)
> >Is there anybody out there that have used this utility
> >successfully?
>
> There was a thread about this topic, with detailed descriptions.
> Maybe this
> link helps you:
> http://lists.linuxppc.org/linuxppc-embedded/200110/msg00156.html
>
> I have not managed to use libraryopt (I tried not very hard), but was
> successful with mklibs.sh.
> If you are using hardhat linux, libraryopt is recommended.

I managed to get it working. The libopt program seems to look
for the build script in the wrong directory (at least according
to my setup ;). Changing that, and the build script executed.

However, the build script is supposed to get all needed object
files as input. My build script didn't get any object files at
all and I think its because of this:

I have an application 'myapp' that depends on a shared library
'mylib'. 'mylib' in turn depends on 'somelib', like this:

myapp -> mylib -> somelib -> libc, libstdc++, etc

What I tried was to create an optimizer for somelib. But since
myapp doesn't depend on somelib directly, it seems that libopt
doesn't think any of the object files in 'somelib' is needed,
and hence no object files as input to the build script.
Is this correct? Does libopt only work when an application is
linked directly against the lib you're trying to optimize?
Am I completely missing something here?
I built an optimizer for 'mylib', and it worked correctly...

Are there any other utilities for solving this problem? Does
mklibs.sh solve it better?

Regards,
Jon-Erling

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
