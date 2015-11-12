Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E9AC1A08F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 04:22:23 +1100 (AEDT)
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 98EEB1402A9
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 04:22:22 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 12 Nov 2015 12:22:18 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A89B1C9003C
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 12:10:24 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tACHMDIS57540828
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 17:22:14 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tACHMBSW019568
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 12:22:13 -0500
Message-ID: <5644CABE.3010905@linux.vnet.ibm.com>
Date: Thu, 12 Nov 2015 22:52:06 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: David Gibson <david@gibson.dropbear.id.au>, kvm@vger.kernel.org,
 michaele@au1.ibm.com, mahesh@linux.vnet.ibm.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com> <20151112033816.GJ5852@voom.redhat.com>
 <87bnazizkp.fsf@gamma.ozlabs.ibm.com>
In-Reply-To: <87bnazizkp.fsf@gamma.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 12 November 2015 10:28 AM, Daniel Axtens wrote:
> 
>> So, IIUC.  Once the qemu pieces are in place as well it shouldn't
>> change this behaviour: KVM will exit to qemu, qemu will log the error
>> information (new), then reinject the MC to the guest which can still
>> handle it as you describe above.
> 
> Ah, that makes *much* more sense now! Thanks for the explanation: I
> don't really follow qemu development.
> 
>>
>> But, there could be a problem if you have a new kernel with an old
>> qemu, in that case qemu might not understand the new exit type and
>> treat it as a fatal error, even though the guest could actually cope
>> with it.
>>
>> Aravinda, do we need to change this so that qemu has to explicitly
>> enable the new NMI behaviour?  Or have I missed something that will
>> make that case work already.
> 
> <puts on CAPI hat>Yeah, it would be good not to break this.</hat>

I am not familiar with CAPI. Does this affect CAPI?

Regards,
Aravinda

> 
> Regards,
> Daniel
> 
> 
>> -- 
>> David Gibson			| I'll have my music baroque, and my code
>> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
>> 				| _way_ _around_!
>> http://www.ozlabs.org/~dgibson
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

-- 
Regards,
Aravinda
