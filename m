Return-Path: <evilninja@gmx.net>
Received: from mail.g-house.de (ns1.g-housing.de [62.75.136.201])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 751C42BF12
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2005 08:01:45 +1100 (EST)
Message-ID: <21643.195.126.66.126.1105043230.squirrel@housecafe.dyndns.org>
In-Reply-To: <20050106162711.GA32598@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501041504.57588.marvin24@gmx.de>
	<1104850036.6164.25.camel@weizen.left.earth>
	<200501051233.25622.marvin24@gmx.de> <20050105154753.GA26760@pegasos>
	<41DC1F7E.5030003@gmx.net> <20050105173908.GC29131@pegasos>
	<41DD60A3.3020203@gmx.net> <20050106162711.GA32598@pegasos>
Date: Thu, 6 Jan 2005 21:27:10 +0100 (CET)
From: "Christian" <evilninja@gmx.net>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, January 6, 2005 17:27, Sven Luther said:
>> ok. but 2.6.8 +2.6.9 won't boot for me, as it does not include the
>> prep_pci.c fix, which was introduced in 2.6.10-rc3. i assume
>
> Sure, and backported to the debian kernel.

now i'm confused: i've extracted kernel-source-2.6.9.tar.bz2 from
kernel-source-2.6.9_2.6.9-4_all.deb but the prep_pci [1] fix still
applied!
how was it backported then?

>> http://people.debian.org/~luther/prep/d-i-2005.01.03-prep
>>
>> is made from a current kernel, thus containing the fix (because it's
>> booting, upon "configure network" the network actually works too ;))
>
> Nope, same kernel-source-2.6.8 based one as will ship with sarge. It is
> not uploaded yet, will probably be uploaded this WE.

hm, very strange. so d-i-2005.01.03-prep is made from 2.6.8+backported
prep_pci fix (but see my notes above), and it boots fine (network is ok,
but no disks are found as none are attached and thus "Partition the
Harddisk" fails)

>> i've fetched kernel-source-2.6.9 now, applied the prep_pci fix and
>> compiled the kernel. i *had* to make changes to the debian-config
>> (config-2.6.9-powerpc) because i am still not able to boot via disk. so
>> i enabled CONFIG_ROOT_NFS and CONFIG_TULIP, details here:
>
> These should be enabled by default in the debian config though :/

erm, yes, they were, but as modules only. i needed them statically
(CONFIG_ROOT_NFS!)

> Mmm, it works well here, so maybe your scsi hardware has some problems ?

no disks attached, but i will do some more tests on this tonight...

thanks for your concern,
Christian.

[1]
http://www.nerdbynature.de/bits/hal/2.6.10-rc3/prep_pci_renumbered-2.6.10-rc3.patch
-- 
make bzImage, not war
