To: Sam Ravnborg <sam@ravnborg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Failsafe bootloader 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Jun 2003 21:28:51 +0200."
             <20030603192851.GA1921@mars.ravnborg.org>
Date: Tue, 03 Jun 2003 22:05:47 +0200
Message-Id: <20030603200552.AD3C3C5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030603192851.GA1921@mars.ravnborg.org> you wrote:
>
> A few of the added requirements on top of that are:
> 1) The target shall boot up in the old kernel, if a bogus kernel is loaded

Define "bogus kernel"! Depending if you mean one which was  corrupted
during  download/installation  you can use a checkum; if you mean one
which fails to start the application you can use a watchdog.

Both is trivial and supporeted by several bootloaders.

> 2) The target shall boot up in the old application, if a bogus
> 	application is loaded

Same as above. Here it comes handy if you don't have  to  bundle  the
application with the kernel into one image.

> 3) On the management side an update shall be handled as a single file,
> 	the target may decide to 'unpack' it when received.

OK, not too difficult.

> We have looked all over the net, but none of the bootloaders found
> so far could meet the above demands.

Ummm... how comes you missed to look into U-Boot? It easily  performs
all your reqirements. Without modifying a single line of code.

> The boot loaders usually have an interactive mode used to select
> between different configurations - and there are no feedback from
> the application side if the reboot actually went well.
> The interactiviness does not fit well with an embedded target.

U-Boot allows for canned command sequences and even shell scripts.

> Do you know of a boot loader that partially or fully meets the above
> requirements?

U-Boot meets your rrequirements fully (and some more :-)

> Today we are using VxWorks - for which we have made our own boot loader.
> The boot laoder allows the boot loader itself, and the application part
> to be upgraded - and if a restart is failed the old version will
> be activated on a subsequent build.
> I want the same behaviour in the Linux based target.

==> http://sourceforge.net/projects/u-boot

See also: http://www.denx.de/re/DPLG.html

If you have questions, send an email to the u-boot-users mailing list
(or to me).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Bus error -- please leave by the rear door.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
