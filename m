Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjW0G4rZGzF1MK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 22:20:29 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1GBJoEK017319
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 06:20:27 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g5tn68pnm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 06:20:26 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 16 Feb 2018 11:20:25 -0000
Subject: Re: [PATCH V2] cxl: Fix timebase synchronization status on P9
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, andrew.donnellan@au1.ibm.com
References: <1518713524-1500-1-git-send-email-clombard@linux.vnet.ibm.com>
 <d2f3a000-267f-35cb-484d-7c65371b1ead@linux.vnet.ibm.com>
 <87mv09z1ys.fsf@vajain21.in.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 12:20:21 +0100
MIME-Version: 1.0
In-Reply-To: <87mv09z1ys.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ff50966e-acc2-1a1d-a03a-b45d32c87c63@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/02/2018 à 11:02, Vaibhav Jain a écrit :
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
> 
>> I'm also wondering if it wouldn't be simpler to always update the
>> timebase_synced flag dynamically, even on p8. That way we wouldn't need
>> to have the p8 specific code to check for synchronization in
>> cxl_setup_psl_timebase(). p8 and p9 code would be the same.
> 
> I am wondering if we can have an implementation like this:
> 
> static ssize_t psl_timebase_synced_show(struct device *device,
> {
>    	struct cxl *adapter = to_cxl_adapter(device);
>          
>          /* if not already synced than force a resync */
>          if (!adapter->psl_timebase_synced)
>                  /* Choose appropriate PSL implementation */
>                  adapter->native->sl_ops->psl_sync_timebase(adapter);
> 
>     	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->psl_timebase_synced);
> }
> 
> In case of PSL9 if timebase request from PSL->CAPP fails then PSL will
> send an error interrupt. This can be used to set the
> 'psl_timebase_synced' flag back to false if timebase ever fails.

I kind of like recomputing the status with every call. It takes care of 
outdated status and could be helpful after a reset for example.

As to relying on the PSL error interrupt, I wouldn't sweat too much 
about it. When we get one, the world stops spinning. So the timebase 
status is the least of our worries. Or did they add something so that we 
could find out that the PSL error interrupt is *only* due to a timebase 
sync pb? Note that recomputing it with every read also works in that 
case and is simpler.

   Fred
