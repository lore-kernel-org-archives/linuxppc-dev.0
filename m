To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: execute from flash? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Feb 2002 15:17:14 EST."
             <D73A25AA6E54D511AD74009027B1110F0F30B0@ORION>
Date: Mon, 25 Feb 2002 21:50:37 +0100
Message-Id: <20020225205042.64FC9109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven,

in message <D73A25AA6E54D511AD74009027B1110F0F30B0@ORION> you wrote:
>
> Does anyone know how I can run a program in flash from my embedded linux
> kernel that is also running in flash?  Below is the code that I tried but it

I don't think your kernel is running from  flash.  It  is  stored  in
flash,  but  usually  then it gets loaded (and probably uncompressed)
into RAM, and is running from RAM.

YOu can do similar things whith your own code:  you  can  put  it  in
flash,  and load it from flash into RAM to run it. This requires that
you have some way to access  the  flash  memory  -  under  Unix  this
requires  either  a basic device driver (character device), or a more
sophisticated device driver (block device) that allows you to  put  a
filesystem in flash.

> 	int addr = 0xfff80000;

You cannot access arbitrary physical addresses  from  an  application
program.  Linux  uses  virtual memory, and you should get used to the
idea that you cannot access physical memory or devices except through
some special interfaces  provided  by  the  OS  (system  calls  which
usually require some device drivers).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I must follow the people.  Am I not their leader? - Benjamin Disraeli

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
