Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CD361A013A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:57:14 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 25 Sep 2014 14:57:13 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6FF572BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:57:10 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P4cmgs131528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:38:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P4ua0S008890
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:56:37 +1000
Date: Thu, 25 Sep 2014 14:56:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/4] powerpc/powernv: Sync header with firmware
Message-ID: <20140925045612.GB11163@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1409039779-392-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140925042747.8E2AE14016A@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140925042747.8E2AE14016A@ozlabs.org>
Cc: qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2014 at 02:27:47PM +1000, Michael Ellerman wrote:
>On Tue, 2014-26-08 at 07:56:16 UTC, Gavin Shan wrote:
>> From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>> 
>> The patch synchronizes firmware header file (opal.h) for PCI error
>> injection.
>> 
>> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>> index 4593a93..9113653 100644
>> --- a/arch/powerpc/include/asm/opal.h
>> +++ b/arch/powerpc/include/asm/opal.h
>> @@ -200,6 +201,33 @@ enum OpalPciErrorSeverity {
>>  	OPAL_EEH_SEV_INF	= 5
>>  };
>>  
>> +enum OpalErrinjctType {
>> +	OpalErrinjctTypeIoaBusError	= 0,
>> +	OpalErrinjctTypeIoaBusError64	= 1,
>> +
>> +	/* IoaBusError & IoaBusError64 */
>> +	OpalEjtIoaLoadMemAddr		= 0,
>> +	OpalEjtIoaLoadMemData		= 1,
>> +	OpalEjtIoaLoadIoAddr		= 2,
>> +	OpalEjtIoaLoadIoData		= 3,
>> +	OpalEjtIoaLoadConfigAddr	= 4,
>> +	OpalEjtIoaLoadConfigData	= 5,
>> +	OpalEjtIoaStoreMemAddr		= 6,
>> +	OpalEjtIoaStoreMemData		= 7,
>> +	OpalEjtIoaStoreIoAddr		= 8,
>> +	OpalEjtIoaStoreIoData		= 9,
>> +	OpalEjtIoaStoreConfigAddr	= 10,
>> +	OpalEjtIoaStoreConfigData	= 11,
>> +	OpalEjtIoaDmaReadMemAddr	= 12,
>> +	OpalEjtIoaDmaReadMemData	= 13,
>> +	OpalEjtIoaDmaReadMemMaster	= 14,
>> +	OpalEjtIoaDmaReadMemTarget	= 15,
>> +	OpalEjtIoaDmaWriteMemAddr	= 16,
>> +	OpalEjtIoaDmaWriteMemData	= 17,
>> +	OpalEjtIoaDmaWriteMemMaster	= 18,
>> +	OpalEjtIoaDmaWriteMemTarget	= 19,
>> +};
>
>I realise these come from the skiboot source, but they're just too ugly.
>
>Please use kernel style naming, like most of the rest of the file, eg:
>
>	OPAL_ERR_INJECT_IOA_BUS_ERR
>
>Also this enum seems to contain two separate types, the first two values are
>the "type", and the rest are "functions".
>

Yes, two separate types: One is major error type, another one is
specific error type in that domain.

>The only usage I see is:
>
>	/* Sanity check on error type */
>	if (type < OpalErrinjctTypeIoaBusError   ||
>	    type > OpalErrinjctTypeIoaBusError64 ||
>	    function < OpalEjtIoaLoadMemAddr     ||
>	    function > OpalEjtIoaDmaWriteMemTarget) {
>		pr_warn("%s: Invalid error type %d-%d\n",
>			__func__, type, function);
>		return -ERANGE;
>	}
>
>So we could also just do:
>
># define OPAL_ERR_INJECT_TYPE_MIN	0
># define OPAL_ERR_INJECT_TYPE_MAX	1
>
># define OPAL_ERR_INJECT_FUNC_MIN	0
># define OPAL_ERR_INJECT_FUNC_MAX	19
>
>	if (type < OPAL_ERR_INJECT_TYPE_MIN ||
>	    type > OPAL_ERR_INJECT_TYPE_MAX ||
>	    function < OPAL_ERR_INJECT_FUNC_MIN ||
>	    function > OPAL_ERR_INJECT_FUNC_MIN)
>	{
>		pr_warn("%s: Invalid error type %d-%d\n", __func__, type, function);
>		return -ERANGE;
>	}
>

Ok. I'll take this and put it into next revision.

Thanks,
Gavin
