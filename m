Subject: Re: aic7xxx panics (long)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Weinstein <e-d0uble@stinkfoot.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3F00E86B.1000309@stinkfoot.org>
References: <3EFFD86B.7060007@stinkfoot.org>
	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org>
Content-Type: text/plain
Message-Id: <1057053589.32576.310.camel@gaston>
Mime-Version: 1.0
Date: 01 Jul 2003 11:59:50 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-07-01 at 03:48, Ethan Weinstein wrote:

> Ben,
>
> Unfortunately, xmon gives no output except that is't attempting to use a
> serial port.  This machine (G4 MDD) has no serial, so I'm at a loss
> getting any type of serial console working unless you have a suggestion.
> I see the xmon source mentions using firewire, but I have no idea how
> I'd get that working, as this is the only machine here with fw.

Edit arch/ppc/xmon/start.c, line 133, change use_screen = 0 to
use_screen = 1. At least, xmon will display it's full message on screen
though you'll still won't be able to type commands.

If you additionally load your kernel with it's system.map (that is add
a line that says "sysmap=/boot/System.map" to /etc/yaboot.conf, and make
sure /boot/System.map is what was produced when you built the kernel),
then you'll have at least some symbolic output that can be useful.

Additionally, you can tweak xmon to force display of a stack backtrace
when it is entered. Edit arch/ppc/xmon/xmon.c, line 394, just before
"last_cmd = NULL;", add "backtrace(excp);".

Finally, you can also disable xmon in the kernel config and see if you
get an Oops message you can copy manually.

> The aic7xxx driver's output is as usual, it begins to initialize... and
> then we get the crash.
>
> Is there anything else I can do here?  I've heard I can replace the
> internal modem with a third party serial interface.  I'd be willing to
> try this to get a serial console for debugging.

Additionally, you can try upgrading to Justin Gibbs latest driver
(I don't have the URL at hand right now though, but I'll soon update
my "devel" rsync with a 2.4.22-pre snapshot that contains that latest
version)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
