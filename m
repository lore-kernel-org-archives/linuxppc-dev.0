Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4A78DDE23
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 07:01:23 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m04K11JN013753
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2008 15:01:01 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m04K0xPk127006
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2008 13:01:00 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m04K0dG1019571
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jan 2008 13:00:40 -0700
Message-ID: <477E9073.1050900@linux.vnet.ibm.com>
Date: Fri, 04 Jan 2008 14:00:51 -0600
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCh v3] powerpc: add hugepagesz boot-time parameter
References: <477D68E6.2070108@linux.vnet.ibm.com>
	<200801040034.25329.arnd@arndb.de>
In-Reply-To: <200801040034.25329.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adam Litke <agl@linux.vnet.ibm.com>, mel@csn.ul.ie,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, csnook@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> We started discussing this in v1, but the discussion got sidetracked:
> Is there a technical reason why you don't also allow 1M pages, which
> may be useful in certain scenarios?
>   
No, it was mostly a matter of the time I have had and machines easily
available to me for testing.  I don't know of a technical reason that
would prevent supporting 1M huge pages, but would want the tests in the
libhugetlbfs suite to pass, etc.
> On the Cell/B.E. platforms (IBM/Mercury blades, Toshiba Celleb, PS3), the
> second large page size is an option that can be set in a HID SPR
> to either 64KB or 1MB. Unfortunately, we can't do these two simultaneously,
> but the firmware can change the default and put it into the device tree,
> or you could have the kernel override the firmware settings.
>
> Going a lot further, do you have plans for a fully dynamic hugepage size,
> e.g. using a mount option for hugetlbfs? I can see that as rather useful,
> but at the same time it's probably much more complicated than the boot time
> option.
>   
Eventually we will want to support dynamic huge page sizes.  This is
already being looked into.  In the meantime we can have some flexibility
with a boot-time parameter though.

> 	Arnd <><
>   
Jon
