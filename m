Message-ID: <20040621212131.61159.qmail@web60405.mail.yahoo.com>
Date: Mon, 21 Jun 2004 14:21:31 -0700 (PDT)
From: Dieu Morales <dieumorales@yahoo.com>
Subject: Re: Asiliantfb (Frame Buffer) Driver
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1087806284.1547.44.camel@newt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- Adrian Cox <adrian@humboldt.co.uk> wrote:
> The problem is that vgacon and frame buffer consoles
> are different
> things:
>
> vgacon is a console using the text modes of VGA
> cards. To stand a chance
> of working it requires the boot firmware of your
> board to execute the
> VGA BIOS code on the graphics adapter. It works on
> PCs and possibly some
> non-x86 workstations.
>
> Frame buffer consoles (fbcon) use the graphics modes
> of the video card,
> and chipset specific drivers.  I wrote the original
> asiliantfb for the
> 69030 chip. Saito.K & Jeanne replaced the 69030
> support with 69000, and
> it got into the kernel.
>
> First, try removing vgacon and checking that you
> have fbcon enabled.
> If that fails, try contacting the driver's authors.
> There's no contact
> address for them in the source, though Google finds
> one other driver by
> them with this attribution:
> MODULE_AUTHOR("Saito.K & Jeanne <ksaito at
> interface.co.jp>");
>
> - Adrian Cox
> Humboldt Solutions Ltd.

My firmware does initialize the CT69000 as an
environment option that allows what looks like VGA
mode consisting of a simple black screen with
white text.  As per some suggestions I have removed
vga_con and added fb_con but received different(worse)
results.  Without conswitchp = &fb_con I get an
exception shortly after the asiliant driver has been
initialized. And with conswitchp = &fb_con the system
hangs immediately after ppc.md.setup_arch in setup.c.




Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
