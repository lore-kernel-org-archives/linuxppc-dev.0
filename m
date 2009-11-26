Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8C491007DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 07:48:54 +1100 (EST)
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0E9A0F.9010203@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1259210722.16367.256.camel@pasglop>  <4B0E9A0F.9010203@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 07:48:48 +1100
Message-ID: <1259268528.18084.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-26 at 16:09 +0100, Albert Herranz wrote:

> > Are the above OHCI and EHCI "special" ? If not, there's an existing
> > binding for that sort of thing, which btw requires properties to
> > indicate the endianness of the registers and in-memory data structures
> > etc...
> > 
> 
> They are a bit special because registers are in reverse little endian format,
> must be written in 32-bit chunks, and (all things point to) they have hardware bugs.

Well.. first what is "reverse little endian" ? :-) Big endian ?

The OHCI driver today has separate flags to control register endianness
and memory based data structures endianness.

I think we also only use 32-bit reads and writes no ? So that should be
covered :-)

As for HW bugs, well, as long as we know them we can define a quirk bit
and add the necessary workarounds to the driver :-)

Do you have a patch somewhere that adds the OCHI and EHCI support btw ?
 
Cheers,
Ben.
