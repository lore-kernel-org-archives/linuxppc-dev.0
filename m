Date: Fri, 18 Oct 2002 23:15:51 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: install with Debian CD ok, but can't boot any kernel
Message-ID: <20021019071551.GW27982@plato.local.lan>
References: <200210181610.SAA19888@ipnmail.in2p3.fr> <20021018183506.17444@192.168.4.1> <3DB0D2E7.57F51578@koffie.nl>
Mime-Version: 1.0
In-Reply-To: <3DB0D2E7.57F51578@koffie.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Oct 19, 2002 at 05:35:02AM +0200, Segher Boessenkool wrote:
>
> > You may have to type the whole path to the ATA/66 disk in
> > OF instead of "hd", which is something like
> > "/pci@f2000000/mac-io/ata-4" or maybe with an additional
> > pci-bridge in between. To see the actual nodes in OF, type
> > "dev /" then "ls". To see the "shortcuts" (aliases), do
> > "dev /aliases" then ".properties"
>
> The alias for the ata-4 disks are ultra2 and ultra3; the aliases
> for the ata-6 disks are ultra0 and ultra1 (hd is the same as ultra0).
>
> So you want ultra2.

so if yaboot doesn't get booted (it should, apples boot-command goes
looking for bootable partitions if boot-device is bogus, so yaboot
should be found anyway) boot ultra2:2,\yaboot

once in yaboot enter:

ultra2:3,/vmlinux root=/dev/hda3 ro

that assumes the bootstrap partition is 2 and root 3.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
