Date: Tue, 2 Feb 1999 10:23:49 +1100
Message-Id: <199902012323.KAA24452@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: bryanc@ihug.co.nz
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <l03130300b2dbb10d21bc@[172.16.10.14]> (message from Bryan
	Christianson on Tue, 2 Feb 1999 08:42:28 +1300)
Subject: Re: I/O Port Conflicts with PCI devices?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <l03130300b2dbb10d21bc@[172.16.10.14]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bryan Christianson <bryanc@ihug.co.nz> wrote:

> The following listing of /proc/pci shows that I have 2 devices reporting an
> I/O port of 0x400. Is this possible or am I not seeing the whole truth
> here? When I try to access the port (with inl() or outl()), the machine
> panics. I published this panic on the list last week and had no response.

Most likely neither devices is responding to I/O-space accesses
because the PCI_COMMAND_IO bit (enable response to I/O space accesses)
in the PCI command register isn't set.  That would explain the machine
check when you try to access the device.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
