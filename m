Message-ID: <C08678384BE7D311B4D70004ACA371050B76351D@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Jerry Van Baren'" <vanbaren_gerald@si.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Can I run linux without a file system?
Date: Fri, 21 Jun 2002 13:41:49 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It's not *that* bad, is it? ;)

I have to admit I stumbled around for a while before
I got it right, but I do have a shell script for making
a RAM disk image, and I use it all the time.  Is anyone
interested in a copy?

-----Original Message-----
From: Jerry Van Baren [mailto:vanbaren_gerald@si.com]
Sent: Friday, June 21, 2002 1:12 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can I run linux without a file system?



You need at least a RAM file system for "/" and a bunch of subdirectories
such as /dev, /lib, etc.  The common way to do this on a minimalistic
system is to create a file system image in ROM (often compressed) and copy
it to RAM on start up.  Given the questions you are asking, I am very
confident creating a minimal RAM disk image will challenge you sufficiently
:-).  I'm not being snide, lots of people with lots of linux knowledge have
tried and failed.  Most people use someone else's pre-configured minimal
file systems and add/subtract (mostly add :-) programs to it.  This is
because it is very, very hard to create a minimal file system (that works,
that is).

Pointers to development systems with example RAM disk images:
   http://www.denx.de/solutions-en.html
     ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/
   http://www.mvista.com/
   (there are others, I'm just too lazy to do the google search for you)

Trying to run linux without a file system of any sort would require you to
rewrite of pretty much everything and the three or four things you didn't
rewrite, you would have to rebuild (static link, no shared
libraries).  There are a lot of software engineers and hackers that would
turn down the opportunity to do this at any price.  On the other hand, a
lot of naivety and a even more coffee sometimes generates remarkable
results :-).

You really want to look at eCOS or one of the other light weight tasking
OSs.
   http://www.redhat.com/embedded/technologies/ecos/

gvb


At 12:42 PM 6/21/2002 -0700, Tim Lai wrote:

>I am interested in both input/output operation
>on the console. If I just set CONFIG_SERIAL_CONSOLE,
>will I be able read input from the console?
>The main application will be started from init(),
>and the application will need to read and write
>to the console. Are there are method to communicate
>to the serial port other than open("/dev/ttyS0")?
>
>
> >
> > You don't need a filesystem to get output on the
> > serial console
> > you just need to enable the console with
> > CONFIG_SERIAL_CONSOLE=y
> > in your kernel configuration (atleast for mpc860
> > that all)
> > but you will have a hard time producing much more
> > than a blinking
> > cursor if you boot a Linux kernel and have no
> > application that
> > it then can run on the root-filesystem - what would
> > be the point
> > of such a setup - 1MB kernel code for a blinking
> > cursor on a
> > serial port seems expensive.
> >
> > hofrat
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
