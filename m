Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C02EB679E6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 14:06:09 +1100 (EST)
Subject: Re: memory with __get_free_pages and disabling caching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
In-Reply-To: <478F19F21671F04298A2116393EEC3D50A9BE2@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
References: <478F19F21671F04298A2116393EEC3D50A9BE2@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 14:05:51 +1100
Message-Id: <1143169552.4257.68.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-03-23 at 18:15 -0800, Kallol Biswas wrote:
> Hello,
>        Is there an easy way to set page table attributes for the
> memory returned
> by __get_free_pages()?
>  
> I need to be able to turn off caching and turn on E bit for these
> pages.

The Evil bit ? heh ! what are you trying to do ? here ... you can always
create a virtual mapping to those pages with different attributes but
that's nor recommended as some processors will shoke pretty badly if you
end up with both cacheable and non-cacheable mappings for the same page.
However, it's not always possible to unmap the initial mapping since
it's common to use things like large pages, BATs, large TLB entries
etc... to map kernel memory..

> I tried to walk through the page tables data structures to get the
> pte, but it seems
> that the pmd is not present for the pages. If someone has done
> investigation
> on this before please send me a reply.
>  
Kernel linear memory isn't necessarily mapped by the page tables. What
are you trying to do and with what processor ?

Ben.
