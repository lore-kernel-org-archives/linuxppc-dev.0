Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 099DCDDE32
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 05:25:15 +1100 (EST)
Message-ID: <47A75823.5050001@freescale.com>
Date: Mon, 04 Feb 2008 12:23:31 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: Kernel oops while dumping user core.
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>	
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>	
	<20080131201601.GA10501@loki.buserror.net>	
	<20080131204158.GV14201@localdomain>
	<47A235AD.9050107@freescale.com>	 <47A24480.8060103@freescale.com>	
	<DCEAAC0833DD314AB0B58112AD99B93B03EE4A90@ismail.innsys.innovsys.com>
	<1202024064.7208.6.camel@pasglop>
In-Reply-To: <1202024064.7208.6.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-01-31 at 16:10 -0600, Rune Torgersen wrote:
>> Scott Wood wrote:
>>> Changing update_mmu_cache() to always call flush_dcache_icache_page()
>>> fixes it, though a better performing fix would probably be to add an
>>> exception table entry for the dcbst.
>> I can confirm that this seems to fix it.
> 
> Might be better to avoid the flush when the page isn't readable ?

Sure, that'd work.  I was trying to avoid a tablewalk to determine that, 
not noticing the pte argument staring me in the face. :-P

-Scott
