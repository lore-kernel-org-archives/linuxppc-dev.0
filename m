Message-ID: <C08678384BE7D311B4D70004ACA371051119462A@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Muaddi, Cecilia'" <cecilia.muaddi@alloptic.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: access memory mapped registers 
Date: Thu, 9 Jan 2003 17:18:45 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For what it's worth, I've done a couple of quick-and-dirty
devices, in the way you described (mmap from user space).
And you are right that (1) an app may not crash the kernel as
easily -- but remember that a root application can mmap
*anything*, and (2) you don't have to reboot the kernel to try a
code change.  Also (3) I found it easy to code, and (4) I didn't
have to mess with IRQs -- meaning that the person who wrote
the FPGA code had less work to do, & he was already pressed for
time.  (Also I've a "proper" device driver, but it was a very
simple one.)

For one project, the mmap worked fine.  For the other project,
it also worked OK (the demo ran, and the vendor was pleased,
and the project was done start-to-finish, PPC/Linux & FPGA/VHDL
etc., in a very short amount of time), but it made some coding
awkward, and it affected performance.  In particular, my
application was in a loop listening for one of four things:

*	Keystrokes at the console
*	A PF_UNIX (local) socket
*	A PF_INET (UDP)   socket
*	A packet received at my device (an FPGA)

Thanks to the design of Unix, I could select() for the
first three, and the OS would tell me when any of them
was ready.  But since I did the quick-and-dirty mmap()
thing for my FPGA, I had to poll it by reading the mmap.
So I ended up choosing which to service more quickly --
the longer I sat in select(), the less time between checks
to the FPGA, increasing latency there.  The less time I sat
in select(), the more CPU time I ate up, and also my latency
worsened for servicing network packets.

Wolfgang can no doubt give you many more reasons, perhaps
some philosophical, to do a "real" driver.  However, the above
example is a practical one -- performance.


-----Original Message-----
From: Muaddi, Cecilia [mailto:cecilia.muaddi@alloptic.com]
Sent: Thursday, January 09, 2003 5:06 PM
To: 'Wolfgang Denk'
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: RE: access memory mapped registers



Sorry, forgot to mentioned those devices are T1 framers, custom FPGA, and
ethernet switching chips.
Don't know if that makes any difference.

-Cecilia
-----Original Message-----
From: Muaddi, Cecilia
Sent: Thursday, January 09, 2003 4:04 PM
To: 'Wolfgang Denk'; Muaddi, Cecilia
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: access memory mapped registers


why would it be better to use the device driver than via the mmap from user
space?

one of my criteria was to make sure no software mistake will cause the
kernel to hang, as
in the case of vxWorks we are running.  So, if I implement my access to the
device
in the device driver, doesn't that means if there are problem with the
device driver
portion, i will cause the kernel to hang?  Furthermore, any enhancement to
the device
driver will require me to reinstall the kernel?  whereas if all my user
space
application handles the access to those devices, I can stop the user space
application,
update it with the new application without requiring the system to reboot?

Sorry if those sounded like silly questions.

Thanks

Cecilia

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thursday, January 09, 2003 3:14 PM
To: Muaddi, Cecilia
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: access memory mapped registers


In message <885489B3B89FB6449F93E525DF78777F06453B@srvnt506.ALLOPTIC.COM>
you wrote:
>
> I will like to access some memory mapped registers through user space
> applications.
> Do i just use the "mmap" function calls to map the physical memory to my
> user space?

You don't. Design a proper device driver interface instead.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
By the way, ALL software projects are done by iterative  prototyping.
Some companies call their prototypes "releases", that's all.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
