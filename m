To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: access memory mapped registers 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Jan 2003 16:03:54 PST."
             <885489B3B89FB6449F93E525DF78777F06453E@srvnt506.ALLOPTIC.COM>
Date: Fri, 10 Jan 2003 01:25:44 +0100
Message-Id: <20030110002549.97BD3C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <885489B3B89FB6449F93E525DF78777F06453E@srvnt506.ALLOPTIC.COM> you wrote:
> why would it be better to use the device driver than via the mmap from user
> space?

Reliability, robustnes, clean design, ...

Why do we have a separation into kernel and user space at all?

> one of my criteria was to make sure no software mistake will cause the
> kernel to hang, as
> in the case of vxWorks we are running.  So, if I implement my access to the

Then don't weaken the memory protection of the Unix design.

> device
> in the device driver, doesn't that means if there are problem with the
> device driver
> portion, i will cause the kernel to hang?  Furthermore, any enhancement to

Don't you think that an application process that  will  write  random
data to your hardware will have a much higher potential to cause harm
than  a  carefully designed, implementred, reviewed and tested device
driver?

> driver will require me to reinstall the kernel?  whereas if all my user
> space
> application handles the access to those devices, I can stop the user space
> application,
> update it with the new application without requiring the system to reboot?

You can dynamically load and unload device drivers.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Wish not to seem, but to be, the best."                  - Aeschylus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
