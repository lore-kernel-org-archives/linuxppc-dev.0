To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 8xx_io/uart.c 
In-Reply-To: Message from Dan Malek <dan@embeddededge.com>
   of "Sun, 09 Feb 2003 15:52:14 CDT." <3E46BF7E.3080408@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Feb 2003 12:08:04 +1100
Message-ID: <18854.1044839284@ull>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 09 Feb 2003 15:52:14 -0500, Dan Malek <dan@embeddededge.com> writes:
>> Now, why do you do the same thing just a few lines up if it wasn't needed?
>
>It is needed there.  These same functions support xmon and kgdb.  In order
>to do that the serial port is used in three different phases.  One, as it
>was configured by the boot rom/loader, two, by an early serial initialization
>before general memory management and buffering is available, and finally
>after the driver has been completely initialized.  None of this is needed
>to simply support the Linux console.  This has all been discussed too many
>times before....
>
>> How about checking your own facts and provide an accurate analysis before
>> bitching at me for trying to help out?
>
>All I asked is you somehow show it is broken, and that something has
>been fixed before we start patching things.  If there is really something
>wrong with it, I would like to know what that is and how it is triggered.

It is quite clearly broken - a quick perusal of the code will convince you
of this. The problem will be triggered whenever a character with decimal
value 10 is transmitted via my_console_write(), and the buffer address resides
in DPRAM. Either this is a bug, or the DPRAM test is redundant.

It appears that the code originally didn't take into account buffer addresses
that may be in DPRAM, and when it was updated to do so, whoever did it, updated
the first instance of the code, but not the second (which is intended to
convert <linefeed> into <linefeed><carriage-return> - which I reckon is back
to front anyway :-).

It may be that no consequences arise from possibly writing the number 13 into
a random memory location, but I for one would like to see this bug fixed. In
fact, I have a vague recollection that the same bug also existed in the 8260
version of this code, and that I submitted a fix for it among the 8260 uart
patches I posted some time ago.

Having just checked my version of both linuxppc_2_4_devel and linuxppc-2.5
I see this bug still exists everywhere (both 2.4-devel and 2.5, and both
8xx and 8260) - and it is indeed fixed in my local version of 2.4_devel
(which means I did post this fix).

This serves to highlight the difficulty of getting stuff into the "official"
linuxppc kernel sources, although it is only a minor case. Old-timers such
as myself tend to post our patches so they exist on the public record, and
then basically go back to our work when the patches are ignored, usually for
the most lame reasons, simply because we don't have the time to debate the
issue.

However, I believe linuxppc suffers because of this - especially since we are
usually talking about the "development" version of the kernel which people
should expect to be broken occasionally. Another thing to note here, is that
certain people and/or companies have no problem getting their stuff in.

I don't know what to do about this, which is probably why I haven't bothered
to say anything up until now, I just thought this comment followed on logically
from this case. I guess it simply means that if you want the best linuxppc
kernel, you can't simply clone the linuxppc trees - you have to then hunt
around the mailing lists and other places for fixes for various things. Some
people have been so frustrated in the past, that they have set up their own
source trees. I don't like this sort of thing, but then again maybe my apathy
is worse. Food for thought. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
