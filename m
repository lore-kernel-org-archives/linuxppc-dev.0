Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A797B6F86
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 12:41:01 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 20:40:59 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 27FC119D804A
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:40:54 +0000 (WET)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5S2evib217852
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 20:40:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5S2eu9C017440
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 20:40:57 -0600
Date: Thu, 28 Jun 2012 10:40:53 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 03/21] ppc/eeh: more logs for EEH initialization
Message-ID: <20120628024052.GA18670@shangw>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1340812911-6793-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1340840734.23635.8.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340840734.23635.8.camel@concordia>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>On Thu, 2012-06-28 at 00:01 +0800, Gavin Shan wrote:
>> The patch adds more logs to EEH initialization functions for
>> debugging purpose. Also, the machine type ("pSeries") is checked
>> in the platform initialization to assure it's the correct platform
>> to invoke it.
>
>Hi Gavin,
>
>Our boot logs are full enough. pr_info() is not right for this sort of
>stuff.
>
>For debug use:
>      * pr_debug() - which can be enabled dynamically.
>      * pr_devel() - which needs to be built with #define DEBUG
>      * printk(KERN_DEBUG) - for things you always want printed, but
>        needn't go to the console by default.
>

Yes, Michael. I'll replace "pr_info" with "pr_debug" in next revision :-)

>> diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
>> index 8e3443b..a0cee3a 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_dev.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_dev.c
>> @@ -100,6 +100,8 @@ static int __init eeh_dev_phb_init(void)
>>  	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
>>  		eeh_dev_phb_init_dynamic(phb);
>>  
>> +	pr_info("EEH: devices created\n");
>
>That's not actually very informative.
>

Yep. Let me make it more informative in next revision.

>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> index bcf0bb8..bb2bd90 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -561,7 +561,18 @@ static struct eeh_ops pseries_eeh_ops = {
>>   */
>>  static int __init eeh_pseries_init(void)
>>  {
>> -	return eeh_ops_register(&pseries_eeh_ops);
>> +	int ret = -EINVAL;
>> +
>> +	if (!machine_is(pseries))
>> +		return ret;
>> +
>> +	ret = eeh_ops_register(&pseries_eeh_ops);
>> +	if (!ret)
>> +		pr_info("EEH: pSeries platform initialized\n");
>> +	else
>> +		pr_info("EEH: pSeries platform initialization failure\n");
>> +
>> +	return ret;
>>  }
>>  
>>  early_initcall(eeh_pseries_init);
>
>You can achieve the same with initcall_debug.
>
>But if you want to keep it at least print the return code, that's the
>first thing you will want to know if it fails.
>

Thanks, Michael. Let me print "ret" for the failure case in next revision.
Also, I will replace "pr_info" with "pr_debug" as you suggested :-)

Thanks,
Gavin

>cheers
>
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
>
