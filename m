From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14803.60860.762026.661989@argo.linuxcare.com.au>
Date: Fri, 29 Sep 2000 12:17:48 +1100 (EST)
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Linux/PPC Development
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <19340823181237.25887@192.168.1.10>
References: <14803.57550.118150.759977@argo.linuxcare.com.au>
	<19340823181237.25887@192.168.1.10>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:

> Well, the ISA space would be on a fixed bus, but not necessarily bus 0
> (please  ;)
>
> On uninorth, with the new bus remap code, the PCI slots will be bus 2 or
> something like that. Ideally, the arch would tell you which bus to map
> first, possibly overriden by a kernel arg.

The ISA space would be on the "primary" host bridge, whatever that
means. :-)

I don't see why it matters on powermacs which is the primary bridge
though, since we fortunately don't have any legacy ISA devices.
Hum... except for cards in the PC-card slot...  So we need to make
sure that the bus with the cardbus controller is behind the "primary"
bridge.

The issue here is that the pcmcia/cardbus stuff will assign a range
of I/O addresses to a pcmcia card (starting at say I/O port n) and
then expect that inb(n) will access the card.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
