Message-ID: <4096A47B.8030704@gcctech.com>
Date: Mon, 03 May 2004 15:58:51 -0400
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: netatalk with appletalk on ppc
References: <40963D85.6090805@gcctech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Update - only happens with half-duplex connections.  Apparently the
"reflected" packets are passed along to the receive driver, even tho its
source address matches the local interface.

Christopher R. Johnson wrote:

>
> Ok, perhaps this should be posted elsewhere, but I figure someone here
> might have tried this:
>
> I'm using netatalk - trying to get the atalkd component up.  I've done
> this in the past with older kernels, but this time I'm on 2.4.23rc1.
> I'm using the on-chip ethernet support on the 405, and its working
> great with IP based stuff.  I've tried two different versions of
> netatalk with identical results.
>
> When atalkd starts up it does aarp probing to see if it can come up with
> an Appletalk network address.  The probe is sent out on the wire, but
> something wierd happens.  the aarp_rcv code gets invoked right away, and
> when I look at the packet its examing, its the exact packet that was
> just sent out.  This code sees this as an aarp probe being done by some
> other network entity (why?  the mac address is mine) and fails the
> probe.  The aarp code then moves on to another address to try, and the
> whole thing happens again, forever.  Its definitely going to eth0, and
> as I mentioned I see the aarp probe go out on the wire.  Running similar
> code on my intel desktop works fine, the probes happen 10 times, .1
> seconds apart, no one answers, and the code adopts that Appletalk
> address (the expected behavior).  I'm trying to wind my way through the
> net_tx_action and net_rx_action code to see why this is happening, but
> its slow going.
>
> Suggestions?
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
