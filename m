Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8C4FDE08E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 16:23:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18917.31205.828267.202889@drongo.ozlabs.ibm.com>
Date: Wed, 15 Apr 2009 16:08:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mike Mason <mmlnx@us.ibm.com>
Subject: Re: [PATCH] Set error_state to pci_channel_io_normal in
	eeh_report_reset()
In-Reply-To: <49DF967F.4000205@us.ibm.com>
References: <49DF967F.4000205@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Mason writes:

> diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c 
> b/arch/powerpc/platforms/pseries/eeh_driver.c
> index 380420f..9a2a6e3 100644
> --- a/arch/powerpc/platforms/pseries/eeh_driver.c
> +++ b/arch/powerpc/platforms/pseries/eeh_driver.c
> @@ -182,6 +182,8 @@ static void eeh_report_reset(struct pci_dev *dev, 
> void *userdata)
> if (!driver)
> return;
> 
> + dev->error_state = pci_channel_io_normal;
> +
> eeh_enable_irq(dev);
> 
> if (!driver->err_handler ||

Your mail client totally mangled the whitespace.  I fixed it up and
applied it, since the patch was small, but in future please fix your
mail client so it doesn't do that.

It sounds like this patch needs to be applied to earlier kernel
versions -- do you agree?

Paul.
