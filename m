Subject: Re: io write not working
To: darin_smith@adc.com (Darin Smith)
Date: Fri, 8 Sep 2000 10:52:50 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <39B7F7A7.1B36ACBD@adc.com> from "Darin Smith" at Sep 07, 2000 03:16:39 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000907235251.14EC412C@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Darin Smith writes:
> Maybe somebody out there sees something obvious that I'm doing / not
> doing?

Did you remember to invalidate the D-cache before trying to access the data
via the CPU?  It sounds like your CPU isn't cache snooping (8xx don't, for
example) the PCI master writes from your device.  I assume your PCI device is
writing directly to a pre-allocated skbuff, which you then pass up to
netif_rx.  The fill pattern may just be is sitting around in the cache, which
explains the symptoms you're seeing.

The other possibility is that your hardware isn't asserting the byte lane
enables on the PCI bus, but my first guess would be a missing call to
invalidate_dcache_range.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
