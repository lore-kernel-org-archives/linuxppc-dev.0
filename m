Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37AD6DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 10:58:17 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1SNwCLb020942
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 18:58:12 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1SNwCxS255110
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 18:58:12 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1SNwCGi019462
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 18:58:12 -0500
Message-ID: <47C74A66.1060105@austin.ibm.com>
Date: Thu, 28 Feb 2008 17:57:26 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 0/8] pseries: phyp dump: hypervisor-assisted dump
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Linas Vepstas <linasvepstas@gmail.com>,
	paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Changes from previous version:

The only changes are in patch 2.
moved early_init_dt_scan_phyp_dump from rtas.c to phyp_dump.c
Added dummy function in phyp_dump.h

Patch 3 required repatching due to changes to patch 2.
Resubmitting all patches to avoid confusion.

Thanks,
Manish


Michael Ellerman wrote:
> On Sun, 2008-02-17 at 22:53 -0600, Manish Ahuja wrote:
>> The following series of patches implement a basic framework
>> for hypervisor-assisted dump. The very first patch provides 
>> documentation explaining what this is  :-) . Yes, its supposed
>> to be an improvement over kdump.
>>
>> A list of open issues / todo list is included in the documentation.
>> It also appears that the not-yet-released firmware versions this was tested 
>> on are still, ahem, incomplete; this work is also pending.
>>
>> I have included most of the changes requested. Although, I did find
>> one or two, fixed in a later patch file rather than the first location
>> they appeared at.
> 
> This series still doesn't build on !CONFIG_RTAS configs:
> http://kisskb.ellerman.id.au/kisskb/head/629/
> 
> This solution is to move early_init_dt_scan_phyp_dump() into
> arch/powerpc/platforms/pseries/phyp_dump.c and provide a dummy
> implementation in asm-powerpc/phyp_dump.c for the !CONFIG_PHYP_DUMP
> case.
> 
> cheers
> 
