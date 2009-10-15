Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2EDEB7B83
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 05:55:09 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9FIt5An018954
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 11:55:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n9FIw9PX025818
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 13:58:10 -0500 (CDT)
Message-ID: <4AD77007.2070706@freescale.com>
Date: Thu, 15 Oct 2009 13:55:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
References: <1255557226-4403-1-git-send-email-timur@freescale.com>
	<200910151305.47100.borntraeger@de.ibm.com>
	<20091015160906.GA3730@loki.buserror.net>
	<200910152041.26646.borntraeger@de.ibm.com>
In-Reply-To: <200910152041.26646.borntraeger@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	brueckner@linux.vnet.ibm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Borntraeger wrote:
> Hmmm, if we are ok with having both options, we should let the hvc backend 
> decide if it wants to drain or to discard.
> 
> If we just busy loop, it actually does not matter how we let hvc_console react 
> on 0, as long as we adopt all backends to use that interface consistent.
> 
> On the other hand, backends might want to do special magic on congestion so I 
> personally tend to let the backend loop instead of hvc_console. But I am really  
> not sure.

The reason that we're asking for this change is that I have an hvc client driver that drops characters during heavy printk() output.  hvc calls my driver, but the output buffer is still full, so the driver just returns 0.

If I add a spin-loop in the driver, then we don't need to change hvc, but now the driver is blocking during user-space print operations (via hvc_write and hvc_push).  

-- 
Timur Tabi
Linux kernel developer at Freescale
