To: Norm Legare <normlegare@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Flash setup 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 22 Oct 2002 07:45:13 PDT."
             <20021022144513.36073.qmail@web13401.mail.yahoo.com>
Date: Tue, 22 Oct 2002 19:36:25 +0200
Message-Id: <20021022173630.9F90E10148@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Norm,

in message <20021022144513.36073.qmail@web13401.mail.yahoo.com> you wrote:
>
> I would like to powerup my board and have Linux come up automatically
> to the prompt.  To do this I would like to store ppcboot in partition
> 1, the kernel in partition 2, and the root fs in partition 3 and have

What do you mean with "root fs" ? If this is  a  ramdisk  image,  you
don;t need any flash support in the Linux kernel at all.

> ppcboot transfer control to Linux through some environment settings.
> I have searched the archives and found an email that seems to outline
> this, it says, that the kernel config should have CONFIG_FLASH and
> CONFIG_AMD_FLASH turned on, as well as, adding a definition to file
> drivers/char/flash_config.c for my board (board = MBX860 and the
> definition is the same as TQM8xx).  Then a dd command can write the
> images to the partitions.  I have done this, but I get the following
> problem:

This refers to our (old) character device flash driver. It  does  not
help  you  at  all  when you're trying to mount a filesystem - you'll
need a block device than - i. e. support for MTD.

> See below for the contents of my dev subdir.  Also, is it possible to
> do a serial download of the images from a host to the flash with a
> target root filesystem utilizing busybox?

Yes, of course this is possible.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Why don't you have a Linux partition installed so you can be  working
in  a  programmer-friendly environment instead of a keep-gates'-bank-
account-happy one? :-)                            -- Tom Christiansen

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
