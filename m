Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011706b356b4a1e327@[192.168.1.2]>
Date: Wed, 5 May 1999 22:55:07 -0400
To: linuxppc-dev@lists.linuxppc.org
From: "sean o'malley" <somalley@ed.mde.state.mi.us>
Subject: Firewire drivers..
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Im looking more for a little bit of input, ideas, and constructive
criticism than anything (if I am WAY off base psuh me in a better direction
=) ). Im not much of a programmer but I thought I would try to put together
device driver design for Firewire and hopefully by the time I am done I
will have progressed enough in my programming so I can hack this together
(or have it be organized enough that I can get help hacking it together).

What happens if you make the Firewire driver a general device driver and
add loadable module support for it? sort of a kernel inside the kernel.

basically.. it boils down to you need a driver to support your Firewire
card's(') chipset(s) and a driver(s) to run the device(s) it found.

The General Firewire driver would be the medium that communicates (compiled
into) with the kernel and directs the Firewire traffic between devices and
the system. It would be essentially the gatekeeper of the Bus. Polling it
for additional devices and loading the proper drivers. Assigning the device
ID's, current, types of transfer,etc.

The Device Driver would be file describing your particular chipset/card.

The Firewire Driver would be a file describing that particular Firewire
device and its functions. (voltage, device type, whatever)

Ideally(do we live in an ideal world?), both the Device Driver and the
Firewire Driver would not have to be compiled into the kernel and depending
they might not have to be compiled at all which would lead to easier
x-platform deployment/implementation.

The General Firewire Driver should load the Firewire drivers on the
fly(like the kernel modules load automatically in the kernel), this is
because the of the hotpluggable nature of Firewire.

You could also add another section of extendable modules to the General
Firewire Driver for easily adding additional support like a general sound
module or a  scanner module, networking(?), etc. This might actually be
loaded with actual device file or possbly as another loadable kernel
module.

The Kernel would use the General Firewire driver as its only pseudo-device
and the General Firewire driver would assign each device /dev/firewire a
specific name. (I'm really kind of boggled how you would assign devices
since there isnt any particular order they would load. I suppose for drives
you could put a file containing some sort of identifying number in the root
directory of the drive that matches a specific device so firewire_drive_1
with /home would always be /home and Firewire_drive_2 with /root would
always load as root..)

-----
or alternatively..

the other way to do this is to make the General Firewire Driver hand over
responsibility to the loaded Firewire Driver so the General Firewire Driver
would just be a skeleton of code to load the proper Firewire Driver which
would than load the proper Firewire Device Driver. I guess this doesnt make
much sense to me in the case of multiple identical cards...


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
