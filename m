Message-ID: <3BD44C6D.10209@metaparadigm.com>
Date: Tue, 23 Oct 2001 00:42:21 +0800
From: Michael Clark <michael@metaparadigm.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Late Broadcom link detection makes IP config (bootp) fail
References: <3BD39166.7020600@metaparadigm.com> <20011022131636.2681@smtp.adsl.oleane.com> <20011022084148.G4933@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> On Mon, Oct 22, 2001 at 03:16:36PM +0200, Benjamin Herrenschmidt wrote:
>
>>>Okay, changed to BMAC and it works okay - should BMAC detection come
>>>before GMAC?
>>>
>>There is no way bmac would replace gmac, those are different drivers
>>for different chips.
>>
>
> But would bmac ever try and init some gmac hw?  That's sort of what it
> sounded like Michael was saying.  But anyhow, gmac and bmac use the
> module_init bits and thus there's no way to enforce ordering of init.


My apologies. I had been using gmac all along but it appears to be an
intermittent problem. Sometimes the interface comes up in time for IP
autoconfig and sometimes not. I'll go have a look at the IP config code
to see if get it to wait a while for the interface to come up.

Here's a successful (garbled) log where the link came up just in time (i
can't capture the failed log as I don't have a serial port on my iMac).

eth0: PHY ID: 0x00406212
eth0: Found Broadcom BCM5201 PHY
Sending BOOTP requests .<6>eth0: Link state change, phy_status: 0x782d
eth0:    Link up ! BCM5201/5221 aux_stat: 0x003e
eth0:    Full Duplex: 0, Speed: 100
. OK
IP-Config: Got BOOTP answer from 10.1.0.4, my address is 10.1.0.42
IP-Config: Complete:
       device=eth0, addr=10.1.0.42, mask=255.255.0.0, gw=10.1.0.254,
      host=10.1.0.42, domain=, nis-domain=(none),
      bootserver=10.1.0.4, rootserver=10.1.0.7, rootpath=/nb/root

~mc


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
