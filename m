Return-Path: <benh@ozlabs.org>
Subject: Re: printk time confusion?
From: Benjamin Herrenschmidt <benh@ozlabs.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1207146186.3957.11.camel@johannes.berg>
References: <1207146186.3957.11.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 03 Apr 2008 21:48:44 +1100
Message-Id: <1207219724.10388.319.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arndb@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-02 at 16:23 +0200, Johannes Berg wrote:
> Hi,
> 
> Not sure whether the lockdep patches or something else is causing this
> as I haven't checked w/o the patches yet, but I seem to be having some
> confusion of printk timestamps:

Tried reverting the patches ?

> [...]
> [  176.440255] iwl4965: No space for Tx
> [...]
> [  147.983705] ioctl32(gnome-terminal:6361): Unknown cmd fd(25) cmd(0000530b){t:'S';sz:0} arg(0fd7bbe0) on /dev/pts/2
> [...]
> [  173.589209] BUG kmalloc-2048: Poison overwritten
> [...]
> [  208.385226] ioctl32(gnome-terminal:6498): Unknown cmd fd(29) cmd(0000530b){t:'S';sz:0} arg(0fd7bbe0) on /dev/pts/6
> [...]
> [  139.026724] ioctl32(gnome-terminal:6521): Unknown cmd fd(30) cmd(0000530b){t:'S';sz:0} arg(0fd7bbe8) on /dev/pts/7
> [...]
> [  155.982345] ioctl32(gnome-terminal:6543): Unknown cmd fd(31) cmd(0000530b){t:'S';sz:0} arg(0fd7bbe0) on /dev/pts/8
> [...]
> [  218.918388] tg3: eth0: Link is down.
> [...]
> 
> Yes, these entries really were printed in that order. Btw, what's with
> the unknown ioctls?

Proably ioctl's that lack a 32 bits conversion, you'll have to dig in
the pty stuff to find out which ones it is and if it can be a problem...

> Kernel version is 2.6.25-rc8-wl-04519-g6648ff7-dirty where -wl/-dirty
> refers to wireless patches and the lockdep patches and otherwise it's
> just -rc8.
> 
> johannes
