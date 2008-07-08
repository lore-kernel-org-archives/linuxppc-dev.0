Return-Path: <chandru@in.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 284DEDDE22
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 21:06:57 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id m68B8xKv130970
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 21:08:59 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m68AvhP52998436
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 20:57:43 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m68AwAwM003053
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 20:58:10 +1000
From: Chandru <chandru@in.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Date: Tue, 8 Jul 2008 16:28:07 +0530
References: <200807080014.24910.chandru@in.ibm.com>
	<20080708113646.13836635.sfr@canb.auug.org.au>
In-Reply-To: <20080708113646.13836635.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807081628.07843.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the review comments. I will change to 'snprintf' at all the places  
and remove the unnecessary casts.

On Tuesday 08 July 2008 07:06:46 Stephen Rothwell wrote:
> Hi Chandru,
>
> On Tue, 8 Jul 2008 00:14:24 +0530 Chandru <chandru@in.ibm.com> wrote:
> > +		if (usm != NULL) {
> > +			ranges = (len >> 2) / (n_mem_addr_cells +
>
>                                  ^^^^^^^^^^
> len / sizeof(u32) ?

ranges is made to count the number of linux,usable-memory properties in the 
device tree.  It's acting as a counter here.  So the expression in the patch 
is fine. 

Thanks,
Chandru
