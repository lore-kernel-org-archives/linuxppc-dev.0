To: David Updegraff <dave@cray.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mem= flag behaviour 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Jun 2002 11:15:46 CDT."
             <3D062232.3010003@cray.com>
Date: Tue, 11 Jun 2002 18:34:52 +0200
Message-Id: <20020611163457.DD91C102F8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear David,

in message <3D062232.3010003@cray.com> you wrote:
>
> I'm trying to keep a small trace buffer over re-boots
> of linux from ppcboot, so give a mem=31M flag to linux
> kernel.  Yet by the time linux is up, it has overwritten
> that memory anyway..   PPCBOOT is properly leaving it
> be (with PRAM feature) and correct arg. goes to kernel..

Let me guess... you boot with a ramdisk image?

> After 'reboot' from linux, the memory contents of
> the last meg are still valid (in ppcboot) but by the time linux
> is back up, the region has been trashed.  Why?

If you use a ramdisk image, you should read the documentation for the
"initrd_high" environment variable in
http://www.denx.de/doc/TQM8xxL/ppcboot.html#PPCBOOT-VARIABLES
(or in the PPCBoot README).

> Help, please.  How to prevent linux from talking to
> that memory region during bootup?

Linux does not use the memory beyond what you tell it with "mem=".

Hope this helps...

[BTW: your CD is in the mail.]

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Machines take me by surprise with great frequency.      - Alan Turing

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
