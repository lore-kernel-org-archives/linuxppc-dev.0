Return-Path: <v.selvamuthukumar@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 771DADDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Oct 2008 01:51:16 +1100 (EST)
Received: by gxk14 with SMTP id 14so9076865gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 07 Oct 2008 07:51:14 -0700 (PDT)
Message-ID: <790896390810070751u71d34ad4t82921a9bb2aaa698@mail.gmail.com>
Date: Tue, 7 Oct 2008 20:21:13 +0530
From: "selvamuthukumar v" <v.selvamuthukumar@gmail.com>
To: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
Subject: Re: Trying to vfree() nonexistent vm area
In-Reply-To: <BLU119-DAV245BF96B99DC961FFF9EFBB380@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <mailman.1.1223341202.18311.linuxppc-embedded@ozlabs.org>
	<BLU119-DAV245BF96B99DC961FFF9EFBB380@phx.gbl>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> ///////////////////////
> Below is outline of the driver
>
> init:
>    ppc_base = (unsigned long) ioremap_nocache(PPC_BASE, PPC_SIZE);
>
> //     ppc_base = (unsigned long) ioremap(PPC_BASE, PPC_SIZE);    // failure
> with this way too
>
>
> close:
>   iounmap((void __iomem *)ppc_base);
> //    iounmap(PPC_BASE);        // failure with this way too !
>
>
init and close seems to be wrong combinations. You can try,

open - ioremap
close - iounmap

or

init - ioremap
exit - iounmap

-- 
Selva
