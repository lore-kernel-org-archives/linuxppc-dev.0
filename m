Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19690B7B84
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 05:57:23 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9FIvKMJ019403
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 11:57:21 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n9FJ0OpL025876
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 14:00:25 -0500 (CDT)
Message-ID: <4AD770A9.6070509@freescale.com>
Date: Thu, 15 Oct 2009 13:57:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
References: <1255557226-4403-1-git-send-email-timur@freescale.com>
	<200910151305.47100.borntraeger@de.ibm.com>
	<20091015160906.GA3730@loki.buserror.net>
	<200910152041.26646.borntraeger@de.ibm.com>
In-Reply-To: <200910152041.26646.borntraeger@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, brueckner@linux.vnet.ibm.com,
	Timur Tabi <timur@freescale.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Borntraeger wrote:
> Right. Looking at more drivers it seems that both ways (waiting and dropping) 
> are used.
> 
> Hmmm, if we are ok with having both options, we should let the hvc backend 
> decide if it wants to drain or to discard.

I'd say the dropping approach is quite undesirable (significant 
potential for output loss unless the buffer is huge), unless there's 
simply no way to safely spin.  Hopefully there are no such backends, but 
if there are perhaps we can have them return some special code to 
indicate that.

> If we just busy loop, it actually does not matter how we let hvc_console react 
> on 0, as long as we adopt all backends to use that interface consistent.
> 
> On the other hand, backends might want to do special magic on congestion so I 
> personally tend to let the backend loop instead of hvc_console. But I am really  
> not sure.

Doing it in the backend requires the backend to know whether it's being 
called for printk or for user I/O.  In the latter case, we don't want to 
spin, but rather wait for an IRQ (or poll with a timer if there's no IRQ).

-Scott
