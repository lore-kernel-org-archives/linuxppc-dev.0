Message-ID: <3B714D74.F5AF49D1@aps.anl.gov>
Date: Wed, 08 Aug 2001 09:32:20 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: "Karaaslan, Utku" <UKaraasl@drs.ca>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: A Question on Physical Memory Access from Applications
References: <47EE8DCFB8C6D311A23700508B8BAD5903DAF7@THEBRAIN2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Karaaslan, Utku" wrote:
>
> I have a problem: we've got a number of ADA applications which are
> using direct memory access to certain hardware registers. Under
> VxWorks, this is not a problem as it lacks kernelspace/userspace
> separation. Under Linux, I know I can do direct memory access (through
> /dev/mem), but in this case I want to use the applications as they are,
> with no change to the ADA code. Is there any way to do physical memory
> access transparently wrt the application? Many thanks in advance.

If you don't mind inserting some code into the application startup then
you could probably do something with mmap(), either with /dev/mem or
(safer) by writing your own kernel driver for the relevent hardware that
supports mmap()ing just the relevent physical range into user-space (and
makes it non-cacheable).  It might be possible to use LD_PRELOAD to do
this at startup without changing the application at all, although I
suspect you might have to make some changes to get the address of the
mmapped region - I'm not sure that you could guarantee to place it where
you want in virtual memory.

HTH,

- Andrew
--
The world is such a cheerful place when viewed from upside-down
It makes a rise of every fall, a smile of every frown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
