Message-ID: <016601c43dc8$030d66e0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Brian Hawley" <bhawley@luminex.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <4.2.2.20040518092928.05070d90@bhawley.mailhost.luminex.com> <4.2.2.20040518092928.05070d90@bhawley.mailhost.luminex.com> <4.2.2.20040519091201.05090ce0@bhawley.mailhost.luminex.com>
Subject: Re: Ebony Board, PPC440GP and NFS panics
Date: Wed, 19 May 2004 13:37:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We think that is because linux is thinking the MAC address is
> ff:ff:ff:ff:ff:ff instead of what
> it really is.  u-boot doesn't seem to have a problem getting the MAC
> address out of the ebony board, but
> this linux kernel seems to.
>

A MAC address of  ff:ff:ff:ff:ff:ff  is the broadcast address, so that's a
problem.  I'm not familiar with 440, but the thing is, you've got to find
your ethernet specific code in the kernel and see where it's getting the MAC
from.  u-boot passes a bd_t pointer to the kernel (a struct with a bunch of
board data), but there's probably some kind of mis-match between u-boot and
the platform config of the kernel.

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
