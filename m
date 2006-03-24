Return-Path: <Kallol_Biswas@pmc-sierra.com>
Received: from mother.pmc-sierra.bc.ca (mother.pmc-sierra.com [216.241.224.12])
	by ozlabs.org (Postfix) with SMTP id 851FD67A62
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 06:13:49 +1100 (EST)
Message-ID: <478F19F21671F04298A2116393EEC3D50A9C21@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: memory with __get_free_pages and disabling caching
Date: Fri, 24 Mar 2006 11:13:19 -0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We have a little endian device on a PPC 440GX based system.
The descriptors need to be swapped. With E bit turned on we can save swapping time.

May be all the pages with _get_free_page already are mapped with large tlb entry.

How about making a window (ptes) like consistent memory?

-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
Sent: Thursday, March 23, 2006 7:06 PM
To: Kallol Biswas
Cc: linuxppc-dev@ozlabs.org
Subject: Re: memory with __get_free_pages and disabling caching

On Thu, 2006-03-23 at 18:15 -0800, Kallol Biswas wrote:
> Hello,
>        Is there an easy way to set page table attributes for the 
> memory returned by __get_free_pages()?
>  
> I need to be able to turn off caching and turn on E bit for these 
> pages.

The Evil bit ? heh ! what are you trying to do ? here ... you can always create a virtual mapping to those pages with different attributes but that's nor recommended as some processors will shoke pretty badly if you end up with both cacheable and non-cacheable mappings for the same page.
However, it's not always possible to unmap the initial mapping since it's common to use things like large pages, BATs, large TLB entries etc... to map kernel memory..

> I tried to walk through the page tables data structures to get the 
> pte, but it seems that the pmd is not present for the pages. If 
> someone has done investigation on this before please send me a reply.
>  
Kernel linear memory isn't necessarily mapped by the page tables. What are you trying to do and with what processor ?



Ben.
