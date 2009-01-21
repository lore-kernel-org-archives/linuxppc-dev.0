Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 15756DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 04:28:11 +1100 (EST)
Message-Id: <3725D962-7F25-4A77-8D87-9BBA0A78D406@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Aaron Pace <kodiakuppercut@gmail.com>
In-Reply-To: <bc81dc640901210718l18edbc6ehffbb6709c0daac3f@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Non-contiguous physical memory
Date: Wed, 21 Jan 2009 11:28:02 -0600
References: <bc81dc640901210718l18edbc6ehffbb6709c0daac3f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 21, 2009, at 9:18 AM, Aaron Pace wrote:

> Hello,
>
> I'm working on a design using a Freescale MPC8572 processor.
> We are using 4 gigs of memory, and also need a window of 512 megs for
> PCI-E devices.
> What I have done is set up the first 2G of memory from 0x0 - 0x7f, the
> PCI windows from 0x8 - 0x9f, localbus devices + CCSRBAR from 0xf -
> 0xffffffff, and the second 2G of ram from 0x1.0000.0000 -
> 0x1.8000.0000.
> I've got this set up in U-boot (although it only uses the low mem),
> but Linux will only use the first contiguous physical area (the
> message is "Only using first contiguous memory region").
> Is it possible to have multiple non-contiguous physical memory chunks
> used for memory allocation?
> If not, is there a better way to set this up without losing large
> chunks of memory?

Its possible in that Linux supports this.  However the PPC32 code does  
not exist and would need to be added to support non-contiguous memory  
ranges.

What exact PCI-E needs do you have?  Is PCI-E performance critical?   
Is (are) your pci device(s) 64-bit address capable?

I ask because depending on the answers doing straight 4G and PCI above  
that range might be sufficient for your needs.

- k
