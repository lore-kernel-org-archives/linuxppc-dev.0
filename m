Date: Wed, 2 Feb 2000 00:23:06 +0100
From: Olaf Hering <olh@suse.de>
To: BenH <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-users@lists.linuxppc.org
Subject: Re: find the OF boot-device
Message-ID: <20000202002306.A32257@suse.de>
Reply-To: Olaf Hering <olh@suse.de>
References: <20000201225122.B7845@suse.de> <20000201235557.015906@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000201235557.015906@192.168.1.10>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 01, BenH wrote:

> On Tue, Feb 1, 2000, Olaf Hering <olh@suse.de> wrote:
> How do you plan to match the device to the OF node ? I've looked into
> this issue for some time now, but I don't really see a valid way to know
> that a given Linux device (/dev/xxx) corresponds to a given OF node.
> Especially when using PCI SCSI cards. Is there a way from userland to
> retreive PCI infos of a controller from it's /dev/sdXX node ?

It is a little harder. There is no way to see which drive is connected
to a controller. If you have an Adaptec you can parse something in
/proc/scsi/aic78xxx and scsi. The symbios logic driver gives you no
hint. The same problem with the IDE drives.

But what do we really need?

OF can only boot from known devices, I can't boot from an old adaptec
2940 or any symbios logic adapter.
And if you have an PCI IDE controller then the OF won't boot from
that unknown device.
This reduces the possible boot-devices:

We can boot from some Adaptec controllers, we can boot from every IDE
drive. Maybe there are some other controllers, I don't know.

And we are talking about "colored" Macs.

The drive /dev/hda and /dev/hdb is usualy connected to
/pci/*/ata-4/disk{0,1}, so you can search for that.
/dev/hdc and /dev/hdd is connected to ata-3.

If you have a supported Adaptec then you can parse /proc/scsi/aic78xxx
and /proc/scsi/scsi.

I will implement this in my script, the preview on the ftp server works
only with one card right now. I will add the IDE stuff in the next days.

It would be nice to know what I can expect under /proc.
There is a little hardware "detection" script
ftp://ftp.suse.com/pub/suse/ppc/update/BETA/suse_hw_info.sh

Please start it with . ./suse_hw_info.sh and mail us the tar.gz file.
It would be nice to have this for every possible machine, I will make
the infos available to the public.


Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
