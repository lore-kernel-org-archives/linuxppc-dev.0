To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rid of unused data in LKM 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 24 Jul 2002 13:39:18 +0200."
             <3D3E91E6.4000500@esd-electronics.com>
Date: Wed, 24 Jul 2002 17:49:09 +0200
Message-Id: <20020724154914.5C03C10875@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D3E91E6.4000500@esd-electronics.com> you wrote:
>
> I am writing a LKM that contains a huge constant array of data that is used
> as firmware for a PCI card that is connected to the system where the LKM is loaded.
>
> The module_init function writes the constant data array into the PCI card's RAM and triggers
> a CPU on that card to jump to the firmware code. This works fine.

Why don't you load the firmware using some  ioctl()  _after_  loading
the module?

> But after doing so, the firmware data is still wasting kernel memory on the host system
> and is not used anymore.
> How can I free that memory ? Is there a better way to handle that data ?

If you really think you must link the data with the  module:  Declare
it using "__initdata" ?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
This is an unauthorized cybernetic announcement.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
