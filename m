Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6387E2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 21:09:40 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 20 Nov 2013 03:09:37 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id F214D6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 05:09:31 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAKA9Ybo3473764
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 10:09:34 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAKA9Xjl032307
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 05:09:34 -0500
Date: Wed, 20 Nov 2013 18:09:27 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/eeh: Dump PHB3 diag-data on frozen PE
Message-ID: <20131120100927.GA2546@shangw.(null)>
References: <1384940196-32514-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1384940328.26969.88.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384940328.26969.88.camel@pasglop>
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

On Wed, Nov 20, 2013 at 08:38:48PM +1100, Benjamin Herrenschmidt wrote:
>On Wed, 2013-11-20 at 17:36 +0800, Gavin Shan wrote:
>> While we detect frozen PE on PHB3, it's always meaningful to have
>> the dumped diag-data for further diagnosis and analysis.
>
>Don't we trip that during PCI probing ? For example if we probe behind
>a PCI-X bridge (which can exist on an adapter) we'll trip EEH on every
>non-existing device won't we ?
>

Yes, we already had the dumped PHB diag-data when detecting frozen PE
during PCI probing. After PCI probing is completed, the EEH takes over
and we won't dump PHB diag-data during PCI config cycles.

Took a close look on what we have in the code. Those functions to dump
PHB (P7IOC & PHB3) needs a bit rework or refactoring since we're dumping
same PHB diag-data in pci.c and eeh-ioda.c at the same time.

Besides, I think the appropriate place to dump PHB diag-data (for EEH
core itself) would be ioda_eeh_get_log(), which is the indirect backend
of eeh_ops::get_log, instead of the function ioda_eeh_next_error().

Ben, please drop this one for now and I'll send the revised one :-)

Thanks,
Gavin

>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/eeh-ioda.c |    3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> index 02245ce..481528d 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> @@ -994,8 +994,11 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>>  			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe))
>>  				break;
>>  
>> +			/* It would be always indicative to have PHB diag-data */
>>  			pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
>>  				(*pe)->addr, (*pe)->phb->global_number);
>> +			ioda_eeh_phb_diag(hose);
>> +
>>  			ret = 1;
>>  			goto out;
>>  		}
>
>
