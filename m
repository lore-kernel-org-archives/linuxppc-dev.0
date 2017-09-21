Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xylnl4K37zDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 04:41:46 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8LIf0Gn014697
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 14:41:44 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d4fnuj8nx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 14:41:43 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 21 Sep 2017 12:41:43 -0600
Subject: Re: [PATCH 1/2] powerpc/pseries: fix "OF: ERROR: Bad of_node_put() on
 /cpus" during DLPAR
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 abdhalee@linux.vnet.ibm.com, paulus@samba.org,
 sachinp@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
References: <1505473476.9665.13.camel@abdul.in.ibm.com>
 <1505941372-9147-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <87h8vwcr6c.fsf@concordia.ellerman.id.au>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 11:41:37 -0700
MIME-Version: 1.0
In-Reply-To: <87h8vwcr6c.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <550d2a57-ccf8-1dd2-f91b-d05606de766f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/21/2017 02:54 AM, Michael Ellerman wrote:
> Hi Tyrel,
> 
> Thanks for jumping on this.
> 
> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>> Commit 215ee763f8cb ("powerpc: pseries: remove dlpar_attach_node dependency on
>> full path") reworked dlpar_attach_node() to no longer look up the parent
>> node "/cpus", but instead to have the parent node passed by the caller in the
>> function parameter list. As a result dlpar_attach_node() is no longer
>> responsible for freeing the reference to the parent node. However,
>> commit 215ee763f8cb failed to remove the of_node_put(parent) call in
>> dlpar_attach_node(), or to take into account that the reference to the
>> parent in the caller dlpar_cpu_add() needs to be held until after
>> dlpar_attach_node() returns. As a result doing repeated cpu add/remove dlpar
>> operations will eventually result in the following error:
>>
>> OF: ERROR: Bad of_node_put() on /cpus
>> CPU: 0 PID: 10896 Comm: drmgr Not tainted 4.13.0-autotest #1
>> Call Trace:
>> [c00000026ecdf810] [c00000000278a2a4] dump_stack+0x15c/0x1f8
>> (unreliable)
>> [c00000026ecdf850] [c0000000025371a4] of_node_release+0x1a4/0x1c0
>> [c00000026ecdf8e0] [c0000000027948c8] kobject_put+0x1a8/0x310
>> [c00000026ecdf960] [c000000002794bdc] kobject_del+0xbc/0xf0
>> [c00000026ecdf990] [c000000002535ff4] __of_detach_node_sysfs+0x144/0x210
>> [c00000026ecdf9d0] [c000000002536f70] of_detach_node+0xf0/0x180
>> [c00000026ecdfa40] [c0000000016ed494] dlpar_detach_node+0xc4/0x120
>> [c00000026ecdfa80] [c0000000016f47d0] dlpar_cpu_remove+0x280/0x560
>> [c00000026ecdfb60] [c0000000016f4d9c] dlpar_cpu_release+0xbc/0x1b0
>> [c00000026ecdfbb0] [c00000000161279c] arch_cpu_release+0x6c/0xb0
>> [c00000026ecdfbe0] [c00000000218ebf0] cpu_release_store+0xa0/0x100
>> [c00000026ecdfc20] [c000000002178388] dev_attr_store+0x68/0xa0
>> [c00000026ecdfc50] [c000000001bfaae8] sysfs_kf_write+0xa8/0xf0
>> [c00000026ecdfc80] [c000000001bf8a3c] kernfs_fop_write+0x2cc/0x400
>> [c00000026ecdfce0] [c000000001ad33fc] __vfs_write+0x5c/0x340
>> [c00000026ecdfd80] [c000000001ad89e8] vfs_write+0x1a8/0x3d0
>> [c00000026ecdfdd0] [c000000001ad9178] SyS_write+0xa8/0x1a0
>> [c00000026ecdfe30] [c0000000015eb8e0] system_call+0x58/0x6c
> 
> I usually omit all the addresses in the change log, they don't add much
> for future readers. I fixed it up myself.

Ok, good point. I'll be sure to try and remember for future patches.

> 
>> Fix the issue by removing the of_node_put(parent) call from
>> dlpar_attach_node(), and ensuring that the reference to the parent node
>> is properly held and released by the caller dlpar_cpu_add().
>>
>> Fixes: 215ee763f8cb ("powerpc: pseries: remove dlpar_attach_node dependency on full path")
>> Cc: stable@vger.kernel.org # v4.13+
> 
> It doesn't need to go to stable, v4.13 doesn't have that commit, it's
> only in v4.14-rc1.

My bad, Abdul mentioned 4.13.0 in his email, but sure enough you are correct.

[root@ltcalpine2-lp2 linux]# git tag --contains 215ee763f8cb
v4.14-rc1

Thanks for catching that.

> 
> I dropped the stable tag.
> 
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index fc0d8f9..473d817 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -462,15 +462,17 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>>  	}
>>  
>>  	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
>> -	of_node_put(parent);
>>  	if (!dn) {
>>  		pr_warn("Failed call to configure-connector, drc index: %x\n",
>>  			drc_index);
>>  		dlpar_release_drc(drc_index);
>> +		of_node_put(parent);
>>  		return -EINVAL;
>>  	}
>>  
>>  	rc = dlpar_attach_node(dn, parent);
> 
> I added a comment here that I had in my version:
Sure np.

-Tyrel

> 
> +       /* Regardless we are done with parent now */
> 
>> +	of_node_put(parent);
>> +
>>  	if (rc) {
>>  		saved_rc = rc;
>>  		pr_warn("Failed to attach node %s, rc: %d, drc index: %x\n",
> 
> cheers
> 
