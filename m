Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 0E2BD67A5F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 15:53:42 +1100 (EST)
Message-ID: <4428C1B9.4080200@ovro.caltech.edu>
Date: Mon, 27 Mar 2006 20:55:21 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Phil.Nitschke@avalon.com.au
Subject: Re: Memory mapping PCI memory region to user space
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>	
	<204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>	
	<1143446542.24304.8.camel@lamorak.int.avalon.com.au>	
	<44280D45.7090103@ovro.caltech.edu>
	<1143519660.24304.18.camel@lamorak.int.avalon.com.au>
In-Reply-To: <1143519660.24304.18.camel@lamorak.int.avalon.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Phil Nitschke wrote:
> On Mon, 2006-03-27 at 08:05 -0800, David Hawkins wrote:
> 
>>Try building an insmodding the pci_io driver I posted, it'll pick
>>up the two BAR regions and allow you to access them, and you can
>>add more debugging comments to that code fairly easily.
> 
> 
>>http://www.ovro.caltech.edu/~dwh/pci_io.tar.gz
> 
> 
> Hi Dave,
> 
> I tried your program briefly, but (I guess) since I'm not using udev,
> the program failed rather early, and I didn't persist for too long.
> I've attached a log of the session below.  
> 
> (I used it on a commercial VME carrier board with a PmPPC7448 PMC module
> and a PMC FPDP module, and a recent 2.6.16 kernel.org kernel built for
> PPC. I used the ELDK4 NFS filesystem.)
> 

Sorry, I should have metioned. If udev is not installed then
the scripts that create the /dev nodes do not exist, so
you need to create them manually.

I don't see any probe calls in the driver log, so I'm not sure
that the driver has been told to register for that device ID.
You can either add your device ID to the pci IDs list in the
driver, or echo to a sysfs node ... let me see ... yeah

echo "129a:dd11" > /sys/bus/pci/drivers/pci_io/new_id

should do the trick.

Then you'll see probe callbacks and comments about
what major and start minor is assigned to each device.

Then create your dev nodes, eg major=254, minor=0, count=3

mknod /dev/pci_00:02.0_0 c 254 0
mknod /dev/pci_00:02.0_1 c 254 1
mknod /dev/pci_00:02.0_2 c 254 2

which is what you were trying already.

Give that a shot.

Dave
