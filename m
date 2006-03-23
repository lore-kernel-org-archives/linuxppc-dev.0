Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 629F667B16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 04:52:56 +1100 (EST)
Message-ID: <4422E0CB.8080701@ovro.caltech.edu>
Date: Thu, 23 Mar 2006 09:54:19 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>
Subject: Re: Memory mapping PCI memory region to user space
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com><204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org><4422D6E3.1010407@ovro.caltech.edu>	<CCA437BF-E204-4652-9E6D-25388225EFE8@kernel.crashing.org>
	<00be01c64ea1$4c6e0e20$6401a8c0@CHUCK2>
In-Reply-To: <00be01c64ea1$4c6e0e20$6401a8c0@CHUCK2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Linuxppc-Embedded \(\(E-Mail\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> 
> PCI is actually endian-agnostic, so we're really 'fixing' the 
> Freescale PCI implementation with endian swapping.
> 

Hi Mark,

Its not agnostic, its little-endian.

The configuration space layout of parameters larger than a
byte are defined in little endian format.

The wiring on the PCI bus is little-endian, and 32-bit
quantities on the bus are represented by a logic analyzer
in little endian format.

But once you start talking about BAR regions, then yeah,
they're your bytes, do with them what you will. My hardware
uses a little-endian TI DSP, and an x86 host, so I
had been using compatible machines.

But the PLX PCI-9054 PCI chipset exposes BAR[0] and BAR[1]
as control registers that are little-endian format.

Conversely, we also use some Janz CAN cards, and their
messaging protocol over PCI uses big-endian format
structures in their protocol.

Dave
