Message-ID: <3A5E21E6.DE26A121@wanadoo.fr>
Date: Thu, 11 Jan 2001 22:13:10 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: pdisk weirdness
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Having observed for a while that pdisk (linux) doesn't work on my iBook,
I tried to understand what is going on. It's weird.

Doesn't work means that 'pdisk /dev/hda' (or 'pdisk -l' likewise) gives
me the output:

pdisk: Can't read block 0 from '/dev/hda'
Edit /dev/hda -
Command (? for help): p
No partition map exists
Command (? for help): q
Segmentation fault

This is pdisk version 0.8a2 (16 May 2000) from the pdisk-0.8-1.ppc.rpm
as it is contained in LinuxPPC 2000 and LinuxPPC 2000 Q4 aka Halloween.
When I downgrade to the pdisk-0.7-2 RPM from LinuxPPC 1999, it works as
it is supposed to. Also I think I remember that the new pdisk works when
run with a 2.2 kernel. Only the combination of new pdisk and 2.4 kernel
doesn't work.

What is weirder is that there is (almost) no source to be found for this
pdisk-0.8-1! On the LPPC 2000 source CD, there is no pdisk at all, and
in the LPPC 2000 Q4 source directory, there is the SRPM for the old
pdisk-0.7-2. I finally found the sources at the defunct dev-rel CVS
repository at gate.crashing.org.

There is a llseek-patch (by Tom Rini, IIUC) which seems to be the origin
of the problem. If I back it out, pdisk works again.

Is anyone successfully running pdisk-0.8-1 with kernel 2.4?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
