Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-3.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4412FDDF1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 13:24:26 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: vb <vb@vsbe.com>
Subject: Re: mmap and ppc460gt
References: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
Date: Tue, 26 Aug 2008 20:24:18 -0700
In-Reply-To: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
	(vb@vsbe.com's message of "Tue, 26 Aug 2008 19:26:58 -0700")
Message-ID: <ada3akri1i5.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > I don't seem to be able to port this to ppc460gt: on this architecture
 > the PCI register space can be mapped only to 36 bit address ranges
 > with nonzero top nibbles. But mmap()  (at least the one I have in
 > 2.6.25)  accepts only 32 bit values for addresses, hence there is no
 > way to map PCI space into user space.

In the past I've been able to use mmap64() on ppc440 to get at 36-bit
addresses.  As far as I know this should still work.

Also you should be able to get at the BAR of a PCI device by using
mmap() on a resource file under /sys/devices, eg something like
/sys/devices/pci0000:00/0000:00:04.0/0000:0b:00.0/resource0
(where the bus numbers obviously depend on your system and the resource
number depends on what BAR your device has registers in)

 - R.
