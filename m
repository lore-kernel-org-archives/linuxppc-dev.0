Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45BAF67B22
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Dec 2006 05:42:29 +1100 (EST)
Message-Id: <200612051842.kB5IgKXC005522@penguin.ncube.com>
To: Thomas Denzinger <t.denzinger@lesametric.de>
Subject: Re: Speed of plb_temac 3.00 on ML403 
In-reply-to: <13134516.38521165335487229.JavaMail.servlet@kundenserver> 
References: <13134516.38521165335487229.JavaMail.servlet@kundenserver>
Date: Tue, 05 Dec 2006 10:42:20 -0800
From: Michael Galassi <mgalassi@c-cor.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>My question is now: Has anybody deeper knowledge how ethernet and sgDMA
>works? How deep is the PPC involved in the data transfer? Or does the
>Temac-core handle the datatransfer to DDR-memory autonomous?

Thomas,

If you cut & pasted directly from my design you may be running without
DMA, which in turn implies running without checksum offload and DRE.
The plb_temac shrinks to about half it's size this way, but if you're
performance bound you probably want to turn DMA back on in your mhs
file:

 PARAMETER C_DMA_TYPE = 3
 PARAMETER C_INCLUDE_RX_CSUM = 1
 PARAMETER C_INCLUDE_TX_CSUM = 1
 PARAMETER C_RX_DRE_TYPE = 1
 PARAMETER C_TX_DRE_TYPE = 1
 PARAMETER C_RXFIFO_DEPTH = 32768

You'll have to regenerate the xparameters file too if you make these
changes (in xps: Software -> Generate Libraries and BSPs).

There may also be issues with the IP stack in the 2.4 linux kernels.
If you have the option, an experiment with at 2.6 stack would be
ammusing.

-michael
