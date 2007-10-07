Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AEAECDDEF8
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 07:05:57 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l97L5s1H008938
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 07:05:54 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l97L9SmH291400
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 07:09:28 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l97L5cGF031800
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 07:05:38 +1000
Subject: Re: TASK_SIZE default 0x80000000 ?
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <796C20BF-1592-4F07-B83B-5EA35CADBA01@kernel.crashing.org>
References: <C2771B73-A555-4119-AC21-1441D4CC2125@freescale.com>
	<18184.23379.478676.911097@cargo.ozlabs.ibm.com>
	<796C20BF-1592-4F07-B83B-5EA35CADBA01@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 08 Oct 2007 07:05:23 +1000
Message-Id: <1191791123.6392.0.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Can you explain (a) further -- I'm assuming the BAT mapping is 1:1  
> for that region?
> 
> For (b) it looks like:
> * 40x, 44x, fsl-booke compare against TASK_SIZE in their software  
> handlers.
> * 8xx still tests 0x80000000
> * 6xx (603) compares against KERNELBASE
> 
> It would seem like we should set the default on 8xx & PReP to  
> 0x80000000 and not allow it to be modified since that will break the  
> world and for everything else move it to match KERNELBASE.  Any  
> issues with that?

The proper value is neither :-)

It should be compared against PAGE_OFFSET.

Ben.
