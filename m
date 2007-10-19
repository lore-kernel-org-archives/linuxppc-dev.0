Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 24BDADDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 16:40:56 +1000 (EST)
Date: Fri, 19 Oct 2007 01:47:25 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] NULL terminate the pci_device_ids in pasemi_edac
Message-ID: <20071019064725.GA1806@lixom.net>
References: <20071019150722.8d48eb1d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071019150722.8d48eb1d.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 03:07:22PM +1000, Stephen Rothwell wrote:
> Fixes:
> drivers/edac/pasemi_edac: struct pci_device_id is 32 bytes.  The last of 1 is:
> 0x00 0x00 0x19 0x59 0x00 0x00 0xa0 0x0a 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> FATAL: drivers/edac/pasemi_edac: struct pci_device_id is not terminated with a NULL entry!
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Olof Johansson <olof@lixom.net>

Thanks for fixing this, Stephen. ID lists without termination can really
cause weird problems at the most random times since it depends on how
the kernel is built whether they do any (immediate) harm or not.


-Olof
