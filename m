Return-Path: <Michele.Pallaro@alcatel-lucent.it>
Received: from smail6.alcatel.fr (colt-na5.alcatel.fr [62.23.212.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smail.alcatel.fr", Issuer "smail.alcatel.fr" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6C974DE010
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 05:00:21 +1100 (EST)
Subject: Re: Non-contiguous physical memory
From: Michele Pallaro <michele.pallaro@alcatel-lucent.it>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <3725D962-7F25-4A77-8D87-9BBA0A78D406@kernel.crashing.org>
References: <bc81dc640901210718l18edbc6ehffbb6709c0daac3f@mail.gmail.com>
	<3725D962-7F25-4A77-8D87-9BBA0A78D406@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 23 Jan 2009 18:52:08 +0100
Message-Id: <1232733128.6271.19.camel@ITVIMNXI34497>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Aaron Pace <kodiakuppercut@gmail.com>
Reply-To: michele.pallaro@alcatel-lucent.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
	I have a similar problem with my custom board CPU mpc8548 (E500V2) with
4Gbytes of RAM

	  0x0000_0000 --    0x7FFF_FFFF  2Gbytes
	0x1_0000_0000 -- 0x1_7FFF_FFFF   2Gbytes

I Enable the option PHYS_64BIT, and set in dts

memory {
                #address-cells = <2>;
                #size-cells = <1>;   
                device_type = "memory";
                reg = <00000000 00000000 00000000 7FFFFFFF
                       00000001 00000000 00000000 7FFFFFFF>;
        };  

But the kernel can see just 2Gbytes of memory.
How the kernel can see the other 2Gbytes ?

	Michele
	

On Wed, 2009-01-21 at 11:28 -0600, Kumar Gala wrote:
> On Jan 21, 2009, at 9:18 AM, Aaron Pace wrote:
> 
> > Hello,
> >
> > I'm working on a design using a Freescale MPC8572 processor.
> > We are using 4 gigs of memory, and also need a window of 512 megs for
> > PCI-E devices.
> > What I have done is set up the first 2G of memory from 0x0 - 0x7f, the
> > PCI windows from 0x8 - 0x9f, localbus devices + CCSRBAR from 0xf -
> > 0xffffffff, and the second 2G of ram from 0x1.0000.0000 -
> > 0x1.8000.0000.
> > I've got this set up in U-boot (although it only uses the low mem),
> > but Linux will only use the first contiguous physical area (the
> > message is "Only using first contiguous memory region").
> > Is it possible to have multiple non-contiguous physical memory chunks
> > used for memory allocation?
> > If not, is there a better way to set this up without losing large
> > chunks of memory?
> 
> Its possible in that Linux supports this.  However the PPC32 code does  
> not exist and would need to be added to support non-contiguous memory  
> ranges.
> 
> What exact PCI-E needs do you have?  Is PCI-E performance critical?   
> Is (are) your pci device(s) 64-bit address capable?
> 
> I ask because depending on the answers doing straight 4G and PCI above  
> that range might be sufficient for your needs.
> 
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
