Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id D30B468926
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jan 2006 20:43:00 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Qt,  forks and threads = segmentation faults?
Date: Mon, 30 Jan 2006 10:42:52 +0100
References: <000301c623a2$13b98fc0$6405a8c0@absolut>
In-Reply-To: <000301c623a2$13b98fc0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601301042.53254.david.jander@protonic.nl>
Cc: Russell McGuire <rmcguire@uwbt.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Russell,

On Saturday 28 January 2006 01:30, Russell McGuire wrote:
> This is a more general question, and if anyone knows of a more specialized
> list this should be posted to, I'd be happy to do so...
>
> Small picture of hardware:
> DENX Linux 2.4.25 / PowerPC MPC8280 / 32 MBs of RAM
>
> I am using QT Embedded for a small GUI that does BSD sockets, also using
> DENX's SM501 video driver. Everything is quite stable, recently I added a
> additional process to the application using fork() for the listening
> 'accept' call for the sockets.
>
> After many tests I decided that due to the nature of the fork() command and
> the GUI half of the program, that this was a large waste of memory, as I
> was duplicating the entire GUI system. So I started looking alternatives,
> and have landed at the 'pthread' library.

It shouldn't be a waste of memory, since Linux uses copy-on-write for memory 
pages. That means, although it looks like your child process wates a lot of 
memory (same initial VSS size as parent), it actually shares its memory with 
the parent until the child starts modifying memory contents (write fault 
occurs). At that moment the page being written to is copied, and the write 
access succeeds on the copied page. So fork() is nowadays quite efficient in 
linux systems..... exactly as efficient as creating a thread.

> However, now I have lots of segmentation faults, particularly when I send a
> message using QT's postEvent commands back to the main thread.

Eeek. You might want to compile QT with thread support compiled in (don't know 
if that helps though).
Anyway, it is probably a better idea to stick with fork() (see above).

> I was curious if anyone had any better idea of a more stable or perhaps a
> suggestion on why I am able to only get about 30 seconds of run time out of
> the app using pthread, verses fork() seems to be much stabler.

Use fork().

Greetings,

-- 
David Jander
