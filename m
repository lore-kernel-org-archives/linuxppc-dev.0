Date: Wed, 4 Jun 2003 12:16:28 +0200
From: Magnus Damm <damm@opensource.se>
To: Darin.Johnson@nokia.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Failsafe bootloader
Message-Id: <20030604121628.7d042138.damm@opensource.se>
In-Reply-To: <F0B628F30F48064289D8CCC1EE21B7A8012E39C8@mvebe001.americas.nokia.com>
References: <F0B628F30F48064289D8CCC1EE21B7A8012E39C8@mvebe001.americas.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 3 Jun 2003 23:47:22 -0700
Darin.Johnson@nokia.com wrote:

> It also could be very nice if you could upgrade the lowest level of software, the boot loader or system initializer (ppcboot, etc).  We had found a bug in our loader at one point, and because many registers are "write once" it was difficult to fix these settings from the application software.  But finding a foolproof and reliable way to upgrade the boot loader software is difficult, especially if you are relying on customers and operators to do the upgrading.

And that's why you should use Miniboot as your first bootloader. =)
It's not upgradeable itself, but it is used to load and update a
secondary bootloader. Miniboot itself should be very small and simple
to keep the number of bugs low. It only requires the internal memory
of the mpc8xx so almost all hardware initialization is made
after miniboot has run, and therefore is upgradeable.

Need to upgrade your hardware configuration?
No problem as long as you haven't changed CS0 or your SMC... =)
And yes, it runs with watchdog on and leaves that configuration
up to the secondary bootloader.

http://opensource.se/projects/miniboot/index.html

However, the number of boards / processors supported are limited at the moment.
I've also heard that uboot/ppcboot could be used to update itself, but I've never
tested it myself.

/ magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
