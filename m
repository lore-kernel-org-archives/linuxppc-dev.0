Date: Fri, 19 Jan 2001 08:54:15 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Alois Fertl <alois_fertl@talknet.de>,
        LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ncr810 problem on powerstack
In-Reply-To: <20010119000309.A17347@altus.drgw.net>
Message-ID: <Pine.LNX.4.05.10101190851170.27117-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Jan 2001, Troy Benjegerdes wrote:
> On Tue, Jan 16, 2001 at 09:44:07PM +0100, Alois Fertl wrote:
> > I tried the recent 2.4.1-pre1 kernel on a powerstack but the ncr810 based
> > SCSI code does not work. The driver complains about CACHE INCORRECTLY CONFIGURED.
> >
> > Anybody knows what this comes from. Attached if the full boot log of the system.
>
> Arrrgh, the same thing happens on my powerstack.
> I'd track this down, but
>
> a) I don't have time
> b) the machine is my mail server and runs the linuxppc_2_2 tree happily.

I saw a similar thing on my LongTrail (with '875 card) after I added a call to
pci_assign_unassigned_resources() to arch/ppc/kernel/pci.c (like PReP) did, and
before I fixed the test for ppc_md.pcibios_enable_device_hook.

Perhaps PReP doesn't like ppc_md.pcibios_enable_device_hook instead of
pci_assign_unassigned_resources?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
