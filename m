Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2939ADDF5E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 08:58:47 +1100 (EST)
Message-ID: <47A24480.8060103@freescale.com>
Date: Thu, 31 Jan 2008 15:58:24 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: Kernel oops while duming user core.
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
	<20080131201601.GA10501@loki.buserror.net>
	<20080131204158.GV14201@localdomain>
	<47A235AD.9050107@freescale.com>
In-Reply-To: <47A235AD.9050107@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Nathan Lynch wrote:
>> Is the crashing program multithreaded?  The first report had firefox
>> triggering the oops.
> 
> OK, I've got a test program that triggers it now.  I'll see if I can 
> figure out what's going on.

The problem seems to be that update_mmu_cache() is called on a guard 
page with no access rights.

Changing update_mmu_cache() to always call flush_dcache_icache_page() 
fixes it, though a better performing fix would probably be to add an 
exception table entry for the dcbst.

-Scott
