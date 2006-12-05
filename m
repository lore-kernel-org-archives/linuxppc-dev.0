Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 08AD467BB4
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 08:24:51 +1100 (EST)
Message-ID: <4575E3FE.7000906@ru.mvista.com>
Date: Wed, 06 Dec 2006 00:26:22 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
References: <20061130165202.GA23205@aepfle.de>	
	<20061204123854.GA28159@aepfle.de>	
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>	
	<4574197A.2020204@ru.mvista.com>	
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>	
	<45741DDE.4080509@ru.mvista.com>	
	<20061204132124.4f7c50a9@localhost.localdomain>	
	<45742253.1000807@ru.mvista.com>	
	<20061204142201.68d9621f@localhost.localdomain>	
	<1165293679.29784.39.camel@localhost.localdomain>	
	<20061205081557.GA8483@aepfle.de>
	<1165349941.5469.1.camel@localhost.localdomain>
In-Reply-To: <1165349941.5469.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org, greg@kroah.com,
	linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Alan <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>On Tue, Dec 05, Benjamin Herrenschmidt wrote:

>>>Olaf, can you give me a dump of /proc/ioports ? What is sitting at 0 on
>>>that PCI bus ?

>>with IDE=y

>>==> /proc/ioports <==
>>00000000-0000001f : dma1

> So it's indeed colliding with the cruft above.

> I reckon it's a bug in the firmware of this machine.

> Add to pseries/pci.c a quirk for that chipset (don't forget to test for
> machine_is(pseries) in the quirk as they get called for all platforms in
> a combo kernel. The quirk shall check if resource 6 has a 0 base and
> clear the size as Alan suggested (possibly setting the UNSET flag as
> well).

    Erm, I suspect it's either one or another -- you probably need to keep the 
size intact for resource marked IORESOURCE_UNSET. At least that's what the 
other code does...

> Ben.

WBR, Sergei
