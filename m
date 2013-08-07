Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9EE302C0139
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 15:25:58 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 6 Aug 2013 23:25:56 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CE5BB1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 23:20:29 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r775Psut210534
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Aug 2013 23:25:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r775PqmZ014103
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Aug 2013 23:25:53 -0600
Date: Wed, 7 Aug 2013 13:25:48 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/eeh: Fix undefined variable
Message-ID: <20130807052548.GA6070@shangw.(null)>
References: <1375842286-26521-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20130807051124.GA19998@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130807051124.GA19998@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 shangw@linux.vnet.ibm.com
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 07, 2013 at 03:11:24PM +1000, Michael Ellerman wrote:
>On Tue, Aug 06, 2013 at 10:24:46PM -0400, Mike Qiu wrote:
>> 'pe_no' hasn't been defined, it should be an typo error,
>> it should be 'frozen_pe_no'.
>> 
>> Also '__func__' should be added to IODA_EEH_DBG(),
>> 
>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> index 0cd1c4a..a49bee7 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> @@ -843,7 +843,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>>  		 * specific PHB.
>>  		 */
>>  		IODA_EEH_DBG("%s: Error (%d, %d, %d) on PHB#%x\n",
>> -			err_type, severity, pe_no, hose->global_number);
>> +			__func__, err_type, severity,
>> +			frozen_pe_no, hose->global_number);
>
>Why is it using a custom macro? If you use pr_devel() or similar you
>avoid these bugs, because the argument list is always expanded.
>

The custom macro at least can save some CPU cycles, but that's not
safe as you mentioned. It's resonable to use pr_devel() here.

Mike, could you help to replace IODA_EEH_DBG() with pr_devel() as
Michael suggested?

Thanks,
Gavin
