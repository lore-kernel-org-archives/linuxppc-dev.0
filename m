Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 96E4FB6EF3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:59:23 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.52])
	by hrndva-qmta03.mail.rr.com with ESMTP
	id <20100805045147125.IFTY24222@hrndva-qmta03.mail.rr.com>
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Aug 2010 04:51:47 +0000
Received: from [192.168.1.20] (millhouse.elkhashab.com [192.168.1.20])
	(authenticated bits=0)
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	o754oLKv009367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 23:50:22 -0500
Message-ID: <4C5A4307.2020400@elkhashab.com>
Date: Wed, 04 Aug 2010 23:50:15 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Help with an odd problem sharing memory on the ppc460ex
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  I've got custom boards that have been running for a while on rev A 
460ex parts but when the rev B parts became available some problems 
surfaced.  We are trying to work around the issues in software.  To make 
this simple, I've got 2 460exs connected together via PCI and PCIe so i 
can switch the transport.  For now, I am using PCI.  I've setup the PIMs 
and POMs to map one CPUs DRAM across the bus to the other CPU.  So they 
have a sort of shared memory scheme.  This works fine in many cases.

I think I have a caching problem though even though I think the cache is 
disabled via u-boot.  What happens is that CPU0 will write into CPU1's 
memory.  CPU1 will still see a stale value though ... I can't figure out 
how this happens.  If CPU0 comes back and reads from CPU1's memory 
though, it gets the correct value.   Now if I reduce the frequency of 
the reads/writes to something low (maybe 1 or 2 per second), then very 
often CPU1 will see the change.  I continue to think it is a cache 
issue, but I am not sure.  Also not sure how to work around that.  Is 
that something I need to do via the TLBs?  Is the cache really disabled 
or does Linux mess with the TLB/cache settings?  When I boot Linux I 
reserve the upper 16Mb of memory (from 112-128Mb space) and then mmap 
that entire region into CPU1's space.  Not sure if when it is reserved 
if it is treated differently by Linux or not.

Any help is greatly appreciated.

Thanks
Ayman
