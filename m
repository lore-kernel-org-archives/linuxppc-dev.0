Subject: Re: Asiliantfb (Frame Buffer) Driver
From: Adrian Cox <adrian@humboldt.co.uk>
To: Dieu Morales <dieumorales@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040620204028.58544.qmail@web60402.mail.yahoo.com>
References: <20040620204028.58544.qmail@web60402.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1087806284.1547.44.camel@newt>
Mime-Version: 1.0
Date: Mon, 21 Jun 2004 09:24:44 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-06-20 at 21:40, Dieu Morales wrote:
[snip]
> I have added console=tty0 to the kernel command line
> and have not identified any other configuration items
> needed.  The serial console I/O which I am expecting
> to see on the monitor shows the driver initialized
> without errors.  Am I missing something in terms of
> configuration?  I have also noticed that when using
> vga_con no graphics card is detected in vgacon.c so
> goto no_vga and conswitchp = &dummy_con;
> Would this be related to the problem?

The problem is that vgacon and frame buffer consoles are different
things:

vgacon is a console using the text modes of VGA cards. To stand a chance
of working it requires the boot firmware of your board to execute the
VGA BIOS code on the graphics adapter. It works on PCs and possibly some
non-x86 workstations.

Frame buffer consoles (fbcon) use the graphics modes of the video card,
and chipset specific drivers.  I wrote the original asiliantfb for the
69030 chip. Saito.K & Jeanne replaced the 69030 support with 69000, and
it got into the kernel.

First, try removing vgacon and checking that you have fbcon enabled.
If that fails, try contacting the driver's authors. There's no contact
address for them in the source, though Google finds one other driver by
them with this attribution:
MODULE_AUTHOR("Saito.K & Jeanne <ksaito at interface.co.jp>");

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
