Date: Wed, 29 Mar 2000 21:42:19 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Pismo Powerbook
Message-ID: <20000329214218.D4054@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <20000329155834.A30559@suse.de> <20000329185016.026926@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000329185016.026926@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 29, Benjamin Herrenschmidt wrote:

>
> On Wed, Mar 29, 2000, Olaf Hering <olh@suse.de> wrote:
>
> >I don't see the problem. What we really need is an app that creates the
> >os-chooser file, what we need is the partition number and the path to a
> >bootable SCSI device. I could do that from the Linux side via a bootable
> >CD, but it would be nice to do it with a Mac application.
>
> The good news is that I have the algorithm for writing to NVRAM on new
> machines. That means that I'll be able to make a version of nvsetenv (or
> nvtool) that works on all supported macs, probably this week-end.
>
> There's still the problem of figuring out the correct OF path however.
> Note that in my latest trees (and in bk 2.3.x), I've changed ide-pmac.c
> to set it's own interface type so that /proc returns "mac-io" instead of
> generic IDE. This should help differenciate the mac-io built-in IDE and
> the CMD646 on B&W G3.

I did a small update to the show_of_path.sh script, it display now
everything correct. It assumes that ultra0 is always the first hd,
ultra1 is the second. hdb can also be a cdrom drive, we have it in on of
our iMacs. The OF to SCSI devices is "guessed" from bootpath.
I think there is no real need for the exact path to an IDE controller.

It is available from
ftp://ftp.suse.com/pub/suse/ppc/update/BETA/show_of_path.sh

Everybody is invited to send us the output of
ftp://ftp.suse.com/pub/suse/ppc/update/BETA/suse_hw_info.sh

It is a little tar.gz file, 30kb.

New kernels with the status from linux-pmac-benh monday morning will
arrive tomorrow, we do some internal tests. It includes also pcmcia
support. They will support pmac, chrp and prep machines.

A newer quik.rpm for RS/6000 booting is available from
ftp://ftp.suse.com/pub/suse/ppc/update/6.3/a1/quik-2.0-7.ppc.rpm
It scans now every partition on sda for quik.conf, take the kernel from
that partition and mount it as the root device if there is no root=
argument.


Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
