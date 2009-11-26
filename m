Return-Path: <albert_herranz@yahoo.es>
Received: from smtp132.mail.ukl.yahoo.com (smtp132.mail.ukl.yahoo.com
	[77.238.184.63]) by ozlabs.org (Postfix) with SMTP id 940231007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:20:43 +1100 (EST)
Message-ID: <4B0EF124.9030406@yahoo.es>
Date: Thu, 26 Nov 2009 22:20:36 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>	
	<1259210722.16367.256.camel@pasglop>
	<4B0E9A0F.9010203@yahoo.es> <1259268528.18084.2.camel@pasglop>
In-Reply-To: <1259268528.18084.2.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2009-11-26 at 16:09 +0100, Albert Herranz wrote:
> 
>>> Are the above OHCI and EHCI "special" ? If not, there's an existing
>>> binding for that sort of thing, which btw requires properties to
>>> indicate the endianness of the registers and in-memory data structures
>>> etc...
>>>
>> They are a bit special because registers are in reverse little endian format,
>> must be written in 32-bit chunks, and (all things point to) they have hardware bugs.
> 
> Well.. first what is "reverse little endian" ? :-) Big endian ?
> 

It's the same case as the register access for the Freescale eSDHC controller, which is already in the existing sdhci-of driver.

> The OHCI driver today has separate flags to control register endianness
> and memory based data structures endianness.
> 
> I think we also only use 32-bit reads and writes no ? So that should be
> covered :-)
> 

There are 8, 16 and 32 bit accesses. We need the same workarounds as present for the Freescale eSDHC controller.

> As for HW bugs, well, as long as we know them we can define a quirk bit
> and add the necessary workarounds to the driver :-)
> 

Yes, that's how it was done.
Although it it currently not integrated into sdhci-of. I think that the specific eSDHC code should be moved to another file, and leave the sdhci-of with the generic code and the sdhci_of_match table. Then adding a similar driver would simply consist in adding another file with the sdhci_data (containing ops and quirks) and adding an entry to the sdhci_of_match table in sdhci-of. 

> Do you have a patch somewhere that adds the OCHI and EHCI support btw ?
>  

Yes, too. Although it needs review and cleanup too.

I have a git tree with all the stuff, but it contains only the existing code previous to the effort of mainlining it:
 http://git.infradead.org/users/herraa1/gc-linux-2.6.git/shortlog/refs/heads/mini/gc-linux-2.6.31

> Cheers,
> Ben.
> 

Thanks,
Albert
