To: Dan Malek <dan@mvista.com>
Cc: jtm@smoothsmoothie.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 console problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Feb 2001 15:36:12 EST."
             <3A95783C.6618E177@mvista.com>
Date: Thu, 22 Feb 2001 22:45:56 +0100
Message-Id: <20010222214601.5A173287E8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A95783C.6618E177@mvista.com> Dan Malek wrote:
>
> > PPCBoot does not use _anything_ from the stuff in arch/ppc/mbxboot/
>
> I'm not sure that is such a good idea.......I'm assuming code from

IMHO the code in that directory is  things  that  shoud  be  done  by
firmware  in  the  frist  place.  In my experience, a lot significant
amount of work to get Linux running on a new board  dealt  with  that
stuff. This pain is gone since we use PPCBoot on all systems.

Why do I have to add another serial driver for a  console  interface,
when  the  firmware  already  has one? Why add uncompression code (to
each kernel image!) when we can have this in a central location -  in
the firmware. Etc. etc.

> that directory is run when I am writing low level kernel code.  You
> are going to constantly be updating PPCBoot, and finding that older

Ummm... Why don't _you_ switch to PPCBoot  then?  I  would  certainly
appreciate your halp there...

> versions aren't going to support new kernels.  That code has to be
> run, makes assumptions about the MMU and cache states upon entry,

Is there a good, urgent reason to _change_ the current state?

> and at most expects a bd_info structure from the boot rom.

Right now the "kernel interface" is pretty well  defined  (starts  at
address  0,  r3: ptr to bd_info, r4: start of initrd or 0, r5: end of
initrd, r6: start of command line, r7: end of command line). What are
you going to change, and why?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The light at the end of the tunnel is usually a "No Exit" sign.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
