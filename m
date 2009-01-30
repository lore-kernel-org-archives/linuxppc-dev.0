Return-Path: <brking@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 170B8DE147
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 01:10:22 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0UE97sW002578
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 07:09:07 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0UEAAqp185656
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 07:10:10 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0UEA9rw014486
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 07:10:10 -0700
Message-ID: <498309ED.4080807@linux.vnet.ibm.com>
Date: Fri, 30 Jan 2009 08:08:45 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/1] powerpc: Fix partition migration hang under load
References: <200901292324.n0TNOktd000814@d03av02.boulder.ibm.com>
	<20090130003829.GC6913@localdomain>
In-Reply-To: <20090130003829.GC6913@localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Brian King wrote:
>> While testing partition migration with heavy CPU load using
>> shared processors, it was observed that sometimes the migration
>> would never complete and would appear to hang. Currently, the
>> migration code assumes that if H_SUCCESS is returned from the H_JOIN
>> then the migration is complete and the processor is waking up on
>> the target system. If there was an outstanding PROD to the processor
>> when the H_JOIN is called, however, it will return H_SUCCESS on the source
>> system
> 
> Hmm, did you determine where that outstanding H_PROD is coming from?
> AFAICT this is the only code which uses that hcall, and all processors
> should have "consumed" their prods from one migration before another
> migration can commence.

Not for certain. After a successful migration we PROD all the processors,
including the one doing all the PRODs. Not sure if this is where the
PROD was coming from that was causing the migration hang or not. The failing
testcase involved keeping the CPUs extremely busy and migrating back and
forth between two systems. 

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
