Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C5D3474C3
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 05:46:45 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBBIjxrG031056
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 13:45:59 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBBIkfoU197830
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 13:46:41 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBBIkeqB004577
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 13:46:40 -0500
Date: Thu, 11 Dec 2008 13:46:35 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matteo Fortini <m.fortini@selcomgroup.com>
Subject: Re: [RESEND] [PATCH] ADS5121 Fix: put dummy byte to enable fixing
	EOF bug to first place in order not to break some drivers\nUse ALARM
	interrupt to avoid waiting for data to come in
Message-ID: <20081211134635.1badd234@zod.rchland.ibm.com>
In-Reply-To: <49415E59.7000301@selcomgroup.com>
References: <49400F56.2040008@selcomgroup.com>
	<20081211093517.31741578@zod.rchland.ibm.com>
	<49415E59.7000301@selcomgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 11 Dec 2008 19:39:21 +0100
Matteo Fortini <m.fortini@selcomgroup.com> wrote:

> 
> This patch is to avoid breaking some drivers, in my case the ADS7846 
> touchscreen one, which use 1 char messages.
> If you put the dummy byte after the 1 char message, you get part of the 
> answer to the message in the rxbuf of the message, which is thrown away.
> 
> The solution is to put the dummy byte before the message, so that the 
> slave doesn't respond.
> 
> It also optimizes the interrupt handling, by using the alarm function of 
> the FIFO, to wait until the rx FIFO has received enough bytes, instead 
> of waiting until the tx FIFO is empty.
> 
> 
> 
> Signed-off-by: Matteo Fortini <m.fortini@selcomgroup.com>
> ---
>  drivers/spi/mpc512x_psc_spi.c |   50 
> +++++++++++++++++++++++-----------------
>  1 files changed, 29 insertions(+), 21 deletions(-)

This still seems to be whitespace corrupted.  Also, that file doesn't
even exist in any upstream kernel I can find.  What tree did you diff
this from?

josh
