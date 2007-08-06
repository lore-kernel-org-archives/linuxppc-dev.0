Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57B4ADDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:04:31 +1000 (EST)
In-Reply-To: <20070801165140.3e176cd1@the-village.bc.nu>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
	<46B0972C.3020000@ru.mvista.com>
	<20070801165140.3e176cd1@the-village.bc.nu>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <04ce93c63dfaa543b4068d448c8115d8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 6 Aug 2007 20:04:17 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> But 0 _is_ a valid PCI I/O address.  Do we now have to start
>>
>>     I wasn't in PCI 2.1 (later the corresponding passage have 
>> disppeared).
>
> SFF controllers often use 0 to indicate a channel isn't configured and
> present. Libata and old IDE both assume these semantics for an SFF
> IDE device reporting address zero. It matches the hardware behaviour.
>
> I would suggest you don't map one at I/O zero on your PCI.

That's of course the smarter choice, _if_ we have a choice at
all -- on PowerPC, the PCI setup on certain platforms is done
by the firmware (and we don't want to mess with it for various
reasons), and some _do_ map PCI legacy I/O at 0.

Not in this case though, so let's just ignore that possibility
until it hits us in the face :-)


Segher
