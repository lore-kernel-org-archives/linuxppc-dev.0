Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A55462C0128
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:32:30 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 21:32:28 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 571F938C801C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 21:32:25 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O1WPVr290484
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 21:32:25 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O1WO7u012194
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 19:32:24 -0600
Date: Wed, 24 Apr 2013 09:32:21 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] powerpc/powernv: TCE invalidation for PHB3
Message-ID: <20130424013221.GC6527@shangw.(null)>
References: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366715034-24594-6-git-send-email-shangw@linux.vnet.ibm.com>
 <1366730708.12131.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366730708.12131.7.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 24, 2013 at 01:25:08AM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2013-04-23 at 19:03 +0800, Gavin Shan wrote:
>>          * of flags if that becomes the case
>>          */
>>         if (tbl->it_type & TCE_PCI_SWINV_CREATE)
>> -               pnv_tce_invalidate(tbl, tces, tcep - 1);
>> +               phb->dma_tce_invalidate(tbl, tces, tcep - 1);
>>  
>>         return 0;
>>  }
>
>TCE invalidate is very performance sensitive, we might be better off
>doing the if (ioda_type == PNV_PHB_IODA1) ... else ... here (which
>the CPU can generally predict) rather than a function pointer call
>which can be more tricky.
>

Ok. I'll change it in next version ;-)

Thanks,
Gavin
