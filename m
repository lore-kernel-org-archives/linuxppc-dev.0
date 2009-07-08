Return-Path: <amodra@bigpond.net.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 54630B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 09:39:55 +1000 (EST)
Received: from nschwmtas06p.mx.bigpond.com (nschwmtas06p.mx.bigpond.com
	[61.9.189.152]) by ozlabs.org (Postfix) with ESMTP id 3B030DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 09:39:55 +1000 (EST)
Date: Thu, 9 Jul 2009 09:09:54 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: binutils 2.19 issue with kernel link
Message-ID: <20090708233954.GA3181@bubble.grove.modra.org>
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	bug-binutils@gnu.org, Edmar Wienskoski-RA8797 <Edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 08, 2009 at 05:41:39PM -0500, Kumar Gala wrote:
> If we modify the linker script:
>
>       _end2 = .;
>       _end3 = ALIGN(4096);
>       _end4 = ALIGN(PAGE_SIZE);
>       . = ALIGN(PAGE_SIZE);
>       _end = . ;
>       PROVIDE32 (end = .);
>
> and the result is:
>
> 00001000 A _end
> c067f678 A _end2
> c0680000 A _end3
> c0680000 A _end4

Possibly some section with a zero vma is being placed before _end.
Generate a link map to see if this is so.

-- 
Alan Modra
Australia Development Lab, IBM
