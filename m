Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtT8n0flPzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 14:28:08 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5M4NfjB060217
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 00:28:06 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7qcmv0yq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 00:28:06 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 14:28:04 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5M4S0TN63242290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 14:28:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5M4RxTc016398
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 14:27:59 +1000
Subject: Re: [PATCH V4 2/2] powerpc/powernv : Add support for OPAL-OCC
 command/response interface
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1498032387-26010-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1498032387-26010-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1498093120.1181.5.camel@gmail.com>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 09:57:53 +0530
MIME-Version: 1.0
In-Reply-To: <1498093120.1181.5.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <6548f1df-9d0e-a5db-677b-48d3d418b1d6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

On 06/22/2017 06:28 AM, Cyril Bur wrote:
> On Wed, 2017-06-21 at 13:36 +0530, Shilpasri G Bhat wrote:
>> In P9, OCC (On-Chip-Controller) supports shared memory based
>> commad-response interface. Within the shared memory there is an OPAL
>> command buffer and OCC response buffer that can be used to send
>> inband commands to OCC. This patch adds a platform driver to support
>> the command/response interface between OCC and the host.
>>
> 
> Sorry I probably should have pointed out earlier that I don't really
> understand the first patch or exactly what problem you're trying to
> solve. I've left it ignored, feel free to explain what the idea is
> there or hopefully someone who can see what you're trying to do can
> step in.

Thanks for reviewing this patch.

For the first patch however, OCC expects a different request_id in the command
interface every time OPAL is requesting a new command .
'opal_async_get_token_interruptible()' returns a free token from the
'opal_async_complete_map' which does not work for the above OCC requirement as
we may end up getting the same token. Thus the first patch tries to get a new
token excluding a token that was used for the last command.


> 
> As for this patch, just one thing.
> 
> 
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>> - Hold occ->cmd_in_progress in read()
>> - Reset occ->rsp_consumed if copy_to_user() fails
>>
>>  arch/powerpc/include/asm/opal-api.h            |  41 +++-
>>  arch/powerpc/include/asm/opal.h                |   3 +
>>  arch/powerpc/platforms/powernv/Makefile        |   2 +-
>>  arch/powerpc/platforms/powernv/opal-occ.c      | 313 +++++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>>  arch/powerpc/platforms/powernv/opal.c          |   8 +
>>  6 files changed, 366 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c
>>
> 
> [snip]
> 
>> +
>> +static ssize_t opal_occ_read(struct file *file, char __user *buf,
>> +			     size_t count, loff_t *ppos)
>> +{
>> +	struct miscdevice *dev = file->private_data;
>> +	struct occ *occ = container_of(dev, struct occ, dev);
>> +	int rc;
>> +
>> +	if (count < sizeof(*occ->rsp) + occ->rsp->size)
>> +		return -EINVAL;
>> +
>> +	if (!atomic_cmpxchg(&occ->rsp_consumed, 1, 0))
>> +		return -EBUSY;
>> +
>> +	if (atomic_cmpxchg(&occ->cmd_in_progress, 0, 1))
>> +		return -EBUSY;
>> +
> 
> Personally I would have done these two checks the other way around, it
> doesn't really matter which one you do first but what does matter is
> that you undo the change you did in the first cmpxchg if the second
> cmpxchg causes you do return.
> 
> In this case if cmd_in_progress then you'll have marked the response as
> consumed...

Here, if cmd_in_progress is set by some other thread doing a write() then it
will set the 'rsp_consumed' to valid on successful command completion. If
write() fails then we are doing a good thing here by not setting 'rsp_consumed'
so the user will not be able to read previous command's response.

Thanks and Regards,
Shilpa

> 
>> +	rc = copy_to_user((void __user *)buf, occ->rsp,
>> +			  sizeof(occ->rsp) + occ->rsp->size);
>> +	if (rc) {
>> +		atomic_set(&occ->rsp_consumed, 1);
>> +		atomic_set(&occ->cmd_in_progress, 0);
>> +		pr_err("Failed to copy OCC response data to user\n");
>> +		return rc;
>> +	}
>> +
>> +	atomic_set(&occ->cmd_in_progress, 0);
>> +	return sizeof(*occ->rsp) + occ->rsp->size;
>> +}
>> +
> 
> [snip]
> 
