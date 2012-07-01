Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A03502C01D9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jul 2012 17:53:27 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 1 Jul 2012 13:23:18 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q617rDtd9437622
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Jul 2012 13:23:14 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q61DN1KF012272
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Jul 2012 23:23:01 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V1 4/9] arch/powerpc: Use vsid and segment offset to
 represent virtual address
In-Reply-To: <1341006336.2563.35.camel@pasglop>
References: <1340979457-26018-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1340979457-26018-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341006336.2563.35.camel@pasglop>
Date: Sun, 01 Jul 2012 13:23:07 +0530
Message-ID: <87txxror30.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2012-06-29 at 19:47 +0530, Aneesh Kumar K.V wrote:
>>  
>> +/* 78 bit power virtual address */
>>  struct virt_addr {
>> -       unsigned long addr;
>> +       unsigned long vsid;
>> +       unsigned long seg_off;
>>  };
>
> Do we really need to do that ? It's really nasty...
>
> We are trying to add only a few bits, we get 12 for free by just using a
> page number (4k based always, not PAGE_SHIFT based btw) no ? That should
> get us going for a while....
>

Ok, will update to vpn in the next iteration.

Thanks
-aneesh
