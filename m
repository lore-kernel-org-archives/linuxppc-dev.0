Return-Path: <msafradin@gmx.de>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE8A5474C1
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 20:52:40 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id mBA9qZcr533336
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 09:52:35 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id mBA9qZ8s2543704
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 09:52:35 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id mBA9qZCs032061
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 09:52:35 GMT
Message-ID: <493F915D.9090909@gmx.de>
Date: Wed, 10 Dec 2008 10:52:29 +0100
From: Mijo Safradin <msafradin@gmx.de>
MIME-Version: 1.0
To: Cliff Wickman <cpw@sgi.com>
Subject: Re: [Re: PATCH] numactl: fix libnuma on big-endian 64-bit systems
References: <E1L8ejM-0003Ln-VN@eag09.americas.sgi.com>
In-Reply-To: <E1L8ejM-0003Ln-VN@eag09.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Cc: Lee.Schermerhorn@hp.com, safradin@de.ibm.com, arnd@arndb.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cliff Wickman wrote:
> linux-numa@vger.kernel.org
> 
> Arnd Bergmann and Mijo Safradin called my attention to problems with
> libnuma's read_mask() on a big-endian 64-bit machine.
> 
> In testing that function I found it to be buggy on little-endian and 32-bit
> systems as well.
> 
> I propose a function that looks like the below.  The patch is farther below.
> (Arnd, I did not switch to longs, as that proved problematic.  The ascii hex
>  strings being scanned are 32-bit values.)
> 
> I tested on a 64-bit MIPS system.  Could you test on your platform?
> 

Hi Cliff,

using the current numactl-2.0.3-rc1.tar.gz, which contains your patch.
numademo breaks with "mbind: Invalid argument". 

Mijo
