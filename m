Message-ID: <3B670458.77D4CB22@mvista.com>
Date: Tue, 31 Jul 2001 15:17:44 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Pergola, Michael" <MichaelPergola@Danfoss.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SCC character recognition/DMA
References: <E1836A7F3557D311A14000805F9F36FCD4E3DE@usdfo011.usac.danfoss.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Pergola, Michael" wrote:

>         The 823e that comes with the Embedded Planet Dev Box
>         has 3 SCCs but one is dedicated to USB while another is
>         used for Ethernet.

Not exactly.  The USB controller is a USB controller.  It is
mapped into the address space of one SCC, and may use some of that
peripheral hardware, but it is not configurable as a SCC.
Since you have the 823e, yes SCC3 can be used.

> .... I guess my real question is, rather then
>         re-invent the code, is there an implementation of the
>         character recognition out there in GPL land?

I believe all the "character recognition" does is either map characters
or terminate buffer operations.  If the device is still used as a uart,
just modify the driver to initialize the characters you want (as it
stores defaults right now).  You can be a little more fancy and add an
ioctl() if you want.  If you want a custom driver that isn't a uart,
then you have to write a new driver.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
