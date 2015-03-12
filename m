Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 960EE1A019A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 14:17:45 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4A58A14007D
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 14:17:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 12 Mar 2015 13:17:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9DBA82CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 14:17:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2C3HWse50397196
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 14:17:40 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2C3H6U1003085
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 14:17:07 +1100
Date: Thu, 12 Mar 2015 14:16:42 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] drivers/vfio: Support EEH error injection
Message-ID: <20150312031642.GA15888@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150312005721.GP11973@voom.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150312005721.GP11973@voom.redhat.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 agraf@suse.de, linuxppc-dev@ozlabs.org, alex.williamson@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2015 at 11:57:21AM +1100, David Gibson wrote:
>On Wed, Mar 11, 2015 at 05:34:11PM +1100, Gavin Shan wrote:
>> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
>> to inject the specified EEH error, which is represented by
>> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  Documentation/vfio.txt        | 47 ++++++++++++++++++++++++++++++-------------
>>  drivers/vfio/vfio_spapr_eeh.c | 14 +++++++++++++
>>  include/uapi/linux/vfio.h     | 34 ++++++++++++++++++++++++++++++-
>>  3 files changed, 80 insertions(+), 15 deletions(-)
>> 
>> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>> index 96978ec..2e7f736 100644
>> --- a/Documentation/vfio.txt
>> +++ b/Documentation/vfio.txt
>> @@ -328,7 +328,13 @@ So 4 additional ioctls have been added:
>>  
>>  The code flow from the example above should be slightly changed:
>>  
>> -	struct vfio_eeh_pe_op pe_op = { .argsz = sizeof(pe_op), .flags = 0 };
>> +	struct vfio_eeh_pe_op *pe_op;
>> +	struct vfio_eeh_pe_err *pe_err;
>> +
>> +	pe_op = malloc(sizeof(*pe_op) + sizeof(*pe_err));
>> +	pe_err = (void *)pe_op + sizeof(*pe_op);
>> +	pe_op->argsz = sizeof(*pe_op) + sizeof(*pe_err);
>
>Surely that argsz can't be correct for most of the operations.  The
>extended structure should only be there for the error inject ioctl,
>yes?
>

argsz isn't appropriate for most cases because kernel has the check
"expected_argsz < passed_argsz", not "expected_argsz == passed_argsz".
However, I'll fix it as follows to avoid confusion after collecting
more comments:

	struct vfio_eeh_pe_op *pe_op;
	struct vfio_eeh_pe_err *pe_err;

	/* For all cases except error injection */
	pe_op = malloc(sizeof(*pe_op));
	pe_op->argsz = sizeof(*pe_op);

	/* For error injection case here */
	pe_op = realloc(sizeof(*pe_op) + sizeof(*pe_err));
	pe_op->argsz = sizeof(*pe_op) + sizeof(*pe_err);
	pe_err = (void *)pe_op + sizeof(*pe_op);

Thanks,
Gavin

>-- 
>David Gibson			| I'll have my music baroque, and my code
>david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
>				| _way_ _around_!
>http://www.ozlabs.org/~dgibson
