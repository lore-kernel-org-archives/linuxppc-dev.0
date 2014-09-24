Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B115E1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 06:57:27 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Sep 2014 16:57:24 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1298C38C8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 16:57:22 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8OKvLrI1507696
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 20:57:22 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8OKvLFx005874
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 16:57:21 -0400
Message-ID: <54233031.60700@linux.vnet.ibm.com>
Date: Wed, 24 Sep 2014 15:57:21 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [4/5] pseries: Implement memory hotplug add in the kernel
References: <54174CF3.1010802@linux.vnet.ibm.com>
 <1410937639.27681.12.camel@concordia>
In-Reply-To: <1410937639.27681.12.camel@concordia>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/17/2014 02:07 AM, Michael Ellerman wrote:
> 
> On Mon, 2014-09-15 at 15:32 -0500, Nathan Fontenot wrote:
>> This patch adds the ability to do memory hotplug adding in the kernel.
>>
>> Currently the hotplug add/remove of memory is handled by the drmgr
>> command. The drmgr command performs the add/remove by performing
>> some work in user-space and making requests to the kernel to handle 
>> other pieces. By moving all of the work to the kernel we can do the
>> add and remove faster, and provide a common place to do memory hotplug
>> for both the PowerVM and PowerKVM environments.
>>
>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>> ---

>> +	for (i = 0; i < entries; i++, lmb++) {
>> +		u32 drc_index = be32_to_cpu(lmb->drc_index);
>> +
>> +		if (lmbs_to_add == lmbs_added)
>> +			break;
>> +
>> +		if (be32_to_cpu(lmb->flags) & DRCONF_MEM_ASSIGNED)
>> +			continue;
>> +
>> +		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX
>> +		    && lmb->drc_index != hp_elog->_drc_u.drc_index)
>> +			continue;
>> +
>> +		rc = dlpar_acquire_drc(drc_index);
>> +		if (rc)
>> +			continue;
>> +
>> +		rc = dlpar_add_one_lmb(lmb);
>> +		if (rc) {
>> +			dlpar_release_drc(drc_index);
>> +			continue;
>> +		}
> 
> In both the above error cases you just move along. That means we potentially
> hotplugged some memory but not everything that we were asked to. That seems
> like a bad idea, we should either do everything or nothing.
> 

Michael, how set are you on the all or nothing approach?

Note that I think the all or nothing approach is best but I think it will
present some problems. We do memory add (and remove) on a LMB basis, so it
is possible to hit a scenario in which we cannot revert back to the original
state. For example, a request to add 5 LMBs only succeeds in adding 4 LMBs.
There is no guarantee that we then remove the 4 MLBs that were added. That
memory could be in use somewhere that it cannot be moved.

I would suggest we continue with the current approach in that we try to
satisfy the request but not try to roll-back the changes if the entire
request cannot be satisfied.

-Nathan   
