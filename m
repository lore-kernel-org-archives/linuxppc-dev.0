Date: Mon, 7 Dec 1998 13:31:45 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: USB, PCI and registers
Message-Id: <19981207133145.029787@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jul 29, 1939,  <> wrote:

>I'm a bit confused as to why pci.c would have base_address[6] as a 
>member to start with - and just as confused as to why there would
>be a difference between architectures.  
>
>Anyone have any comments that might help clarify this confusion?

Those base addresses correspond to the base-addresses registers of the
board's configuration space. If a given PCI chip uses the 5th register,
then the driver must look for base_addresses[4], that's logical. They are
not assigned in any special order: which register to use depends on the
hw implementation and can make HW that uses the 2nd and 3rd registers and
not the fist, for example.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
