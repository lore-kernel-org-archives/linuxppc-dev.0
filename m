Return-Path: <Phil.Nitschke@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B58D8679F0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 17:44:24 +1100 (EST)
Subject: Re: Memory mapping PCI memory region to user space
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: David Hawkins <dwh@ovro.caltech.edu>
In-Reply-To: <4428C1B9.4080200@ovro.caltech.edu>
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
	<204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
	<1143446542.24304.8.camel@lamorak.int.avalon.com.au>
	<44280D45.7090103@ovro.caltech.edu>
	<1143519660.24304.18.camel@lamorak.int.avalon.com.au>
	<4428C1B9.4080200@ovro.caltech.edu>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 17:14:05 +1030
Message-Id: <1143528245.24304.28.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-03-27 at 20:55 -0800, David Hawkins wrote:

> I don't see any probe calls in the driver log, so I'm not sure
> that the driver has been told to register for that device ID.
> You can either add your device ID to the pci IDs list in the
> driver, 

OK, I added the device ID(s).

> or echo to a sysfs node ... let me see ... yeah
> 
> echo "129a:dd11" > /sys/bus/pci/drivers/pci_io/new_id
> 
> should do the trick.

That didn't work for me.  (Permission denied, IIRC)

> Then you'll see probe callbacks and comments about
> what major and start minor is assigned to each device.
> 
> Then create your dev nodes, eg major=254, minor=0, count=3
> 
> mknod /dev/pci_00:02.0_0 c 254 0
> mknod /dev/pci_00:02.0_1 c 254 1
> mknod /dev/pci_00:02.0_2 c 254 2
> 
> which is what you were trying already.

Much better, thanks.  I might be able to use your program/driver as a
comparison to my own driver, at least as far as the mmap() goes, because
mine is broken and yours isn't!

-- 
Phil Nitschke <Phil.Nitschke@avalon.com.au>
Avalon Systems Pty Ltd
