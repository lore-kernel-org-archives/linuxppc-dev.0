Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 343FFDDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 04:30:47 +1100 (EST)
Message-ID: <473C8249.8090206@freescale.com>
Date: Thu, 15 Nov 2007 11:30:49 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Bennett <embedded@akb.net>
Subject: Re: kernel update on mpc8248 muram definition?
References: <bfa0697f0711150743t440298cfsbce6f10b6fa39d73@mail.gmail.com>
In-Reply-To: <bfa0697f0711150743t440298cfsbce6f10b6fa39d73@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Bennett wrote:
>   While working on i2c support, I've decided to update to a new kernel.  
> In the process of doing this, I'm not sure I've properly configured the 
> MURAM node to my device tree (i.e. serial is broken again).

You haven't -- you copied muram/data/reg from some other tree, rather 
than from resource 2 of cpm/reg in your old tree.

>  Also, does 
> this, in any way, change the way I offset the early debug transmit 
> descriptor address?

No.

>             muram@0 {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges = <0 0 10000>;
> 
>                 data@0 {
>                     compatible = "fsl,cpm-muram-data";
>                     reg = <0 2000 9800 800>;
>                 };
>             };

muram/data/reg should be <80 1f80 9800 800> for your board.

-Scott
