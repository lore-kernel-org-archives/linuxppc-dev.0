Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88A6468888
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 17:22:52 +1100 (EST)
In-Reply-To: <C82A9B11BE247C4E952DC733EA98DAA1C55006@ZMY16EXM66.ds.mot.com>
References: <C82A9B11BE247C4E952DC733EA98DAA1C55006@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B86DFBCF-6090-4830-859F-E76E72CC106B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 15 Dec 2005 00:22:59 -0600
To: "KS Soumya-ask067" <soumya.k.s@motorola.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux dependency for PCI Window on U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>
>
> Hi,
> 	Is there anything more specific that I need to do to enable my PCI  
> window to 512MB? I'm using Linux kernel 2.4.20 / KO2.6.10 with  
> MPC8540 ADS defconfig and U-Boot for the same. By default, the U- 
> Boot is specifying a window of 256MB (0x80000000 - 0x8fffffff).  
> Even if the Linux specifies 512MB (0x80000000 - 0x9fffffff), I am  
> not able to access my device registers on 9f4f0000 (BAR of my device).
> But if I specify in U-Boot to make the PCI window as 512MB, (or if  
> I make the Linux to hold 256MB) then Im able to access my device.  
> What should I do for my kernel not to be dependent on U-Boot for  
> the same?
> Any pointers would be of great help. Thank you.

This is most likely due to setting up of the ECM Local access window  
registers.  We dont do this in the kernel and expect that the boot  
loader has setup the physical address map.  If you dont want to be  
dependent on u-boot you should add code to your kernel for setting up  
the LAWs to the kernel for PCI.

- kumar
