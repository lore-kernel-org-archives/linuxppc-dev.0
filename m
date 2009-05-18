Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB9DADE04C
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 13:35:34 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4I3XaxO009468
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 13:33:36 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4I3ZXmB454878
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 13:35:33 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4I3ZXef023985
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 13:35:33 +1000
Subject: Re: [RFC Patch 1/6] Prepare the PowerPC platform for HW Breakpoint
	infrastructure
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
In-Reply-To: <20090514134335.GB14229@in.ibm.com>
References: <20090514133312.360702378@prasadkr_t60p.in.ibm.com>
	<20090514134335.GB14229@in.ibm.com>
Content-Type: text/plain
Date: Mon, 18 May 2009 13:35:32 +1000
Message-Id: <1242617732.18075.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Roland McGrath <roland@redhat.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-05-14 at 19:13 +0530, K.Prasad wrote:
> plain text document attachment (ppc64_prepare_code_01)
> Prepare the PowerPC code for HW Breakpoint infrastructure patches by including
> relevant constant definitions and function declarations.

Hi !

Some comments below...

> +#define   HBP_NUM	1	/* Number of physical HW breakpoint registers */

Can you use a more verbose constant ? reg.h is included everywhere so
the risk of collision is high.

>  #define   DABR_TRANSLATION	(1UL << 2)
>  #define   DABR_DATA_WRITE	(1UL << 1)
>  #define   DABR_DATA_READ	(1UL << 0)
> +#define   DABR_DATA_RW		(3UL << 0)

Do you really need that ? It's just DABR_DATA_WRITE | DABR_DATA_READ :-)

Cheers,
Ben.
