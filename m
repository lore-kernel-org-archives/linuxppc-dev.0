From: Roland Riegel <roland.riegel.maillist@gmx.de>
Subject: Fwd: preparing yaboot/ofpath for linux 2.6
Date: Sat, 17 Jan 2004 10:02:10 +0100
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401171002.10772.roland.riegel.maillist@gmx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi list!

I posted this to yaboot-devel, but got no answer so far, so I am reposting it
here...

Roland

----------  Weitergeleitete Nachricht  ----------

Subject: preparing yaboot/ofpath for linux 2.6
Date: Mittwoch, 14. Januar 2004 16:28
From: Roland Riegel <roland.riegel.maillist@gmx.de>
To: yaboot-devel@lists.penguinppc.org

Hi all!

When upgrading my ibook to kernel 2.6 I noticed that yaboot (that means,
ofpath) does a very bad job in guessing the OF path of the hard disk,
resulting in a hang on next boot.

After having a discussion with Ethan Benson, I checked the current OF
integration in sysfs of linux-2.6.1-rc1-ben1. For some devices, sysfs
contains a file named devspec which describes the OF path. Funnily enough, on
my iBook G4 such a devspec file only exists for the cd/dvd drive, not for the
hard disk:
$ find /sys -name devspec
[...]
/sys/devices/pci0001:01/0001:01:17.0/0.80000000:mac-io/0.00020000:ata-3/devspec
[...]
I do not know why this is the case, probably because they are connected to
different ide interfaces (ata-3/ata-6)?

Ethan agreed that it seems as if OF support is not properly integrated into
sysfs yet. However, for ofpath it is needed that for every ide device (or at
least hard disk) an OF path can be queried. Is it correct that there is no
other way to retrieve this information than to use devspec?

Finally Ethan suggested to bring this issue on-list. So, does anybody have a
solution for this problem?

Greetings,
Roland

-------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
