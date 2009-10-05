Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D751B7BAA
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 08:04:32 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n95L4HQj007790
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 14:04:18 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n95L6pAv001364
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 16:06:51 -0500 (CDT)
Message-ID: <4ACA5F6B.6050400@freescale.com>
Date: Mon, 05 Oct 2009 16:04:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
References: <OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>	
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>	
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>	
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>	
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>	
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>	
	<OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>	
	<1254350159.5699.21.camel@pasglop>	
	<20091002214949.GA20514@b07421-ec1.am.freescale.net>	
	<1254521073.7122.5.camel@pasglop>
	<20091005192806.GC3576@loki.buserror.net>
	<1254774555.7122.38.camel@pasglop>
In-Reply-To: <1254774555.7122.38.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2009-10-05 at 14:28 -0500, Scott Wood wrote:
>> Yes, it hits ptep_set_access_flags() and adding _tlbil_va there helps (I
>> didn't put it in the filter function, because that doesn't take address as a
>> parameter).  I'd misread your suggestion as referring to the various changes
>> to set_pte_filter() that were posted.
>>
>> As for unconditionally invalidating in set_pte_filter(), that doesn't boot
>> for me unless I check for kernel addresses -- I guess we populate page
>> tables that overlap the pinned large page region? 
> 
> Good point. I think we do on 8xx. Does doing it in set_pte_filter()
> (with the kernel check) makes any difference ? faster ? slower ? no
> visible change ?

ptep_set_access_flags() is enough to make the worst of it go away.  I'm 
having another intermittent problem that seems to happen more often 
without the change in set_pte_filter(), but I've yet to narrow down 
what's actually going on there.

-Scott
