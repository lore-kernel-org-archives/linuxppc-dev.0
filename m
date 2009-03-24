Return-Path: <markn@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C540DE0F0
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:49:31 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id n2OMligG014209
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:47:44 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2OMnlEp381426
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:49:47 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2OMnTrr019271
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:49:29 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: Adrian Reber <adrian@lisas.de>
Subject: Re: [PATCH] powerpc/wdrtas: Update wdrtas_get_interval to use
	rtas_data_buf
Date: Wed, 25 Mar 2009 09:51:07 +1100
References: <200903241730.41711.markn@au1.ibm.com>
	<20090324123131.GC24724@lisas.de>
In-Reply-To: <20090324123131.GC24724@lisas.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903250951.07643.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Utz Bacher <utz.bacher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 24 Mar 2009 11:31:31 pm Adrian Reber wrote:
> On Tue, Mar 24, 2009 at 05:30:41PM +1100, Mark Nelson wrote:
> > The buffer passed to the ibm,get-system-parameter RTAS call must be
> > in the RMA. To ensure we pass an address in the RMA use rtas_data_buf
> > for the actual RTAS call and then copy the result to value. We can't
> > just make it static because this can be compiled in as a module.
> > 
> > Also add the WDRTAS_SP_SPI_LEN so we don't litter '4' throughout the
> > function.
> > 
> > Signed-off-by: Mark Nelson <markn@au1.ibm.com>
> > ---
> > 
> > Adrian, does this patch cause any problems for your pxcabs?
> 
> No, it even helps. I have no tried the watchdog until now, but without the
> patch I get: 
> 
>    wdrtas: could not get sp_spi watchdog timeout (0). Continuing
> 
> and with the patch it reads the correct value. So only with your patch
> it works like it is supposed to. Thanks!
> 
> Tested-by: Adrian Reber <adrian@lisas.de>

Good to hear

Thanks for testing!
Mark
