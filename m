Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6CE7DDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 23:08:35 +1100 (EST)
Date: Thu, 18 Jan 2007 21:08:28 +0900 (JST)
Message-Id: <200701181208.l0IC8TF3017043@toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 11/19] powerpc: setup usb host controller in SCC for Celleb
In-Reply-To: <1169080166.4965.17.camel@localhost.localdomain>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

Thank you for your suggestion.

> On Fri, 2007-01-12 at 10:11 +0900, Ishizaki Kou wrote:
> > USB host controller in SCC requires enable sequence. It should be done
> > before USB host drivers start.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> 
> Just a small nit here: Either you want that code to kick on any platform
> that has a Toshiba SCC with that controller, in which case, put it in a
> more generic place, like arch/powerpc/kernel/pci_64.c or
> drivers/usb/host/pci_quirk.c, or you want that to run only on celleb (at
> least for now) in which case, add a
> 
>	if (!machine_is(celleb))
>	   return;
> 
> At the beginning, since if one builds a kernel with more than one
> platform in, your quirk will be run regardless of the platform selected
> at boot.
> 
> Ben.

Because it depends on platform, we will add platform check code.

Best regards,
Kou Ishizaki
