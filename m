Subject: Re: PCI Memory mapping
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc Leeman <marc.leeman@barco.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040323111736.GJ1446@smtp.barco.com>
References: <20040316114030.GB7133@smtp.barco.com>
	 <1079455175.4184.25.camel@localhost.localdomain>
	 <20040322074833.GY7133@smtp.barco.com>
	 <20040323111736.GJ1446@smtp.barco.com>
Content-Type: text/plain
Message-Id: <1080086640.23208.164.camel@gaston>
Mime-Version: 1.0
Date: Wed, 24 Mar 2004 11:04:00 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-03-23 at 22:17, Marc Leeman wrote:

> When data is passed to the DSP and every buffer is confirmed with an
> [Enter] (i.e. __very__ slow_), data is passed correctly. When we try to
> pass the same data without user intervention (comment out
> waitforenter()),
> parts of the transferred data are copied from other locations: most of
> the time, part of the buffer (e.g. 2048 bytes) is not update yet (old
> data).

One thing is: after having written your data to the consistent buffer,
you should make sure you have proper ordering with the MMIO write you
do to kick the DSP. On most CPUs, eieio appear to be enough and I
wouldn't suppose the 8245 to heavily reorder, but just in case, try
adding a sync.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
