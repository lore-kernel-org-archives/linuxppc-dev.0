From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15393.32955.759625.567860@argo.ozlabs.ibm.com>
Date: Thu, 20 Dec 2001 17:10:03 +1100 (EST)
To: BURJAN Gabor <burjang@elte.hu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel panic at boot [3c59x]
In-Reply-To: <20011219202337.GA30003@csoma.elte.hu>
References: <20011219202337.GA30003@csoma.elte.hu>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BURJAN Gabor writes:

> Perhaps you've read this on linux-kernel list too.  I have a problem
> with booting 2.4.17-rc1 on a RS/6000 (43P-140), when Vortex support is
> compiled into the kernel.  Andrew Morton helped me in debugging the
> problem.
[snip]
> The first printk showed the right ioaddress which belonged to the device
> (shown by `lspci -v').  The second printk was not executed because the
> kernel paniced before it.  He wrote it's definitely a platform issue.
> Any suggestions are welcome.

This is ultimately a known problem which I haven't got around to
fixing yet.  The 140 has a PCI-PCI bridge and the firmware configures
it to pass through a range of I/O and memory addresses.  The problem
is that the firmware assumes a 1GB I/O space (yes, it thinks you might
need a *billion* I/O port addresses!) and configures the bridge up in
the high end of that range.  Linux uses a much smaller range of I/O
addresses (0 to 16M-1, from memory) and reconfigures devices to have
I/O addresses in that range.  Unfortunately the code to reconfigure
bridges isn't there yet.  The I/O address that you mentioned,
0x3f7ffc00, is up near the end of the 1GB I/O region and shows that
the card hasn't been reconfigured.

You would have the vortex card in slot 4 or 5, which are the slots
behind the PCI-PCI bridge.  Moving the card to one of the other slots
would help, but if you have nothing behind the bridge you will strike
another known problem, which is that the firmware will then configure
the bridge with all its windows closed, which confuses the code that
reads the bridge configuration.  You can get around that problem for
now by removing the riser card that provides slots 4 and 5.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
