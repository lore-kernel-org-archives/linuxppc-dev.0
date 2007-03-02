Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BB81FDDF18
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 09:16:28 +1100 (EST)
Date: Fri, 2 Mar 2007 16:27:48 -0600
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070302222748.GA1206@lixom.net>
References: <1172872183.5310.145.camel@goblue>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1172872183.5310.145.camel@goblue>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 02, 2007 at 03:49:43PM -0600, Jake Moilanen wrote:
> There are many adapters which can not handle DMAing acrosss any 4 GB
> boundary.  For instance the latest Emulex adapters.  
> 
> This normally is not an issue as firmware gives us dma-windows under
> 4gigs.  However, some of the new System-P boxes have dma-windows above
> 4gigs, and this present a problem.
> 
> I propose fixing it in the IOMMU allocation instead of making each
> driver protect against it as it is more efficient, and won't require
> changing every driver which has not considered this issue.

Sorry, but you need to fix the drivers. They might be used on a system
without an IOMMU, or with direct mapping. It's particularily likely in
the case of DAC-capable devices, and that's the only case for which you
can cross a 4GB boundary in the first place.


-Olof
