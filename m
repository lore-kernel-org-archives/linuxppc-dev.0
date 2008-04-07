Return-Path: <bzolnier@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 40707DDF1F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 07:22:29 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so944224nfd.9
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Apr 2008 14:22:17 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] siimage: fix kernel oops on PPC 44x
Date: Mon, 7 Apr 2008 23:29:59 +0200
References: <200804080005.03683.sshtylyov@ru.mvista.com>
In-Reply-To: <200804080005.03683.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804072330.00610.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 April 2008, Sergei Shtylyov wrote:
> Fix kernel oops due to machine check occuring in init_chipset_siimage() on PPC
> 44x platforms.  These 32-bit CPUs have 36-bit physical address and PCI I/O and
> memory spaces are mapped beyond 4 GB; arch/ppc/ code has a fixup in ioremap()
> that creates an illusion of the PCI I/O and memory resources being mapped below
> 4 GB, while arch/powerpc/ code got rid of this fixup with PPC 44x having instead
> CONFIG_RESOURCES_64BIT=y -- this causes the resources to be truncated to 32-bit
> 'unsigned long' type in this driver, and so non-existant memory being ioremap'ed
> and then accessed...
> 
> Thanks to Valentine Barshak for providing an initial patch and explanations.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied and pushed to Linus, thanks!

I guess that it would be worth to audit the rest of IDE code for
pci_resource_{start,end}() vs 'unsigned long' occurences and fix them.

[ Even if they work at the moment they are just bugs waiting to happened
  when we add support for some new platforms or rewrite the code... ]
