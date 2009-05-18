Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4977FDE276
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:11:35 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4IGBYE6010601
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:11:34 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IGBYZ7164326
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:11:34 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IGBYKI001308
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:11:34 +1000
Date: Mon, 18 May 2009 21:41:28 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC Patch 6/6] Adapt kexec and samples code to recognise
	PPC64hardware breakpoint usage
Message-ID: <20090518161128.GB27641@in.ibm.com>
References: <20090514134614.GG14229@in.ibm.com>
	<Pine.LNX.4.44L0.0905141621040.4344-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.0905141621040.4344-100000@iolanthe.rowland.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 14, 2009 at 04:21:48PM -0400, Alan Stern wrote:
> On Thu, 14 May 2009, K.Prasad wrote:
> 
> > Index: linux-2.6-tip.hbkpt/samples/hw_breakpoint/data_breakpoint.c
> > ===================================================================
> > --- linux-2.6-tip.hbkpt.orig/samples/hw_breakpoint/data_breakpoint.c	2009-05-14 00:17:24.000000000 +0530
> > +++ linux-2.6-tip.hbkpt/samples/hw_breakpoint/data_breakpoint.c	2009-05-14 00:58:06.000000000 +0530
> > @@ -54,6 +54,10 @@
> >  	sample_hbp.info.type = HW_BREAKPOINT_WRITE;
> >  	sample_hbp.info.len = HW_BREAKPOINT_LEN_4;
> >  #endif /* CONFIG_X86 */
> > +#ifdef CONFIG_PPC64
> > +	sample_hbp.info.name = ksym_name;
> > +	sample_hbp.info.type = DABR_DATA_WRITE;
> 
> This should be HW_BREAKPOINT_WRITE, not DABR_DATA_WRITE.
> 
> Alan Stern
>

Done. Thanks.

-- K.Prasad
 
