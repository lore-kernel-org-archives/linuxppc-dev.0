Date: Mon, 22 Nov 1999 21:00:14 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel debugging??
In-Reply-To: <19991118110244.017425@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.05.9911222058180.369-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Nov 1999, Benjamin Herrenschmidt wrote:
> On Wed, Nov 17, 1999, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> >Are you sure about the version? I just checked out this tree, and it's
> 2.3.22,
> >according to the Makefile. Perhaps I made a mistake? This is the first time I
> >used rsync (`rsync -auvz samba.anu.edu.au::linux-pmac-devel .').
> 
> To my knowledge, Paul's tree is now at
> 
> rsync -auvz linuxcare.com.au::linux-pmac-devel .

Using this, 2.3.28 boots a bit further. It locks up right before the SCSI
device probing. After `scsi : 2 hosts.', I can still toggle the Caps Lock LED
for one second, but after that interrupts no longer seem to come through.

    ncr53c8xx: IO region 0x1400 to 0x147f is in use
    mesh: assuming 50MHz clock frequency
    scsi0 : sym53c8xx - version 1.3c
    scsi1 : MESH
    scsi : 2 hosts.
HERE ------------------>
      Vendor: QUANTUM   Model: VIKING II 4.5WLS  Rev: 3506
      Type:   Direct-Access                      ANSI SCSI revision: 02

Fortunately the kernel gets sufficiently far to resume working on frame buffer
device, cfr. the patch I just posted.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
