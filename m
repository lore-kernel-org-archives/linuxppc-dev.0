To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 console problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Feb 2001 18:51:20 EST."
             <3A95A5F8.DF6FB60B@mvista.com>
Date: Fri, 23 Feb 2001 02:18:16 +0100
Message-Id: <20010223011822.EBA86287E8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A95A5F8.DF6FB60B@mvista.com> you wrote:
>
> The code in the mbxboot directory is also used by (many) people
> that flash the kernel and initrd into rom.  One of the nice things
> about this code is you can boot an image over a network for testing,
> and then flash the identical compressed bits when you get it working.

Yes, that's what we do with PPCBoot, too. You don't need the  mbxboot
stuff for this.

> > Is there a good, urgent reason to _change_ the current state?
>
> When I get a chance to step back and take a breath from the recent
> set of merges (yours are in the pipeline now :-), the bd_info stuff
> is going to disappear and follow the new boot record method used by
> other PPC booters.  That is the first major step to removing the whole
> variety of different boot loaders.

Seems I'm missing a bit of information here. Which "new  boot  record
method"  are you talking about? Where are things like this discussed?
Is there any documentation available?


> > Right now the "kernel interface" is pretty well  defined  (starts  at
> > address  0,  r3: ptr to bd_info, r4: start of initrd or 0, r5: end of
> > initrd, r6: start of command line, r7: end of command line). What are
> > you going to change, and why?
>
> No one but 8xx uses that calling convention anymore.  To standardize

Really? Isn't this still in use on 4xx, 8xx, and  PREP?  Ummm...  I'm
talking about 2.4.0 here; has this been changed sice?

> new boot record method.  Regardless of how a board and boot rom store
> and provide information, the code in the "boot" directory collects
> this into a standard format and presents it to the kernel.

That's OK for all those boards that come with  any  usable  firmware;
some  others  will be using PPCBoot, and it is our intention that you
don't need any additional "glue" layer when booting with PPCBoot.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Remember that Beethoven wrote his first symphony in C ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
