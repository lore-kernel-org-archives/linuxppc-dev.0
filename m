Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A84F1A01DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 14:12:07 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 20:12:05 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CCB541FF003D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 20:00:46 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAQ3C2gB53739538
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 20:12:02 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAQ3C1lN019877
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 20:12:02 -0700
Message-ID: <547544FE.5020706@linux.vnet.ibm.com>
Date: Tue, 25 Nov 2014 21:11:58 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 07/14] of/reconfig: Always use the same structure for
 notifiers
References: <1416868422-22103-1-git-send-email-grant.likely@linaro.org>
 <1416868422-22103-8-git-send-email-grant.likely@linaro.org>
 <1416956874.5089.13.camel@kernel.crashing.org>
In-Reply-To: <1416956874.5089.13.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/2014 05:07 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2014-11-24 at 22:33 +0000, Grant Likely wrote:
>> The OF_RECONFIG notifier callback uses a different structure depending
>> on whether it is a node change or a property change. This is silly, and
>> not very safe. Rework the code to use the same data structure regardless
>> of the type of notifier.
> 
> I fell pretty good about this one except...
> 
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index b9d1dfdbe5bb..9fe6002c1d5a 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -1711,12 +1711,11 @@ static void stage_topology_update(int core_id)
>>  static int dt_update_callback(struct notifier_block *nb,
>>  				unsigned long action, void *data)
>>  {
>> -	struct of_prop_reconfig *update;
>> +	struct of_reconfig_data *update = data;
>>  	int rc = NOTIFY_DONE;
>>  
>>  	switch (action) {
>>  	case OF_RECONFIG_UPDATE_PROPERTY:
>> -		update = (struct of_prop_reconfig *)data;
> 
> Should we assert/bug on !update->dn / update->prop ?
> 
> (Same for the rest of the patch)
> 
> Or do you reckon it's pointless ?
> 

I'm not sure it's worth it, if those are NULL pointers the drivers/of
code would have tried to use them before invoking the notifier chain.
We won't make it this far if they're NULL.

Otherwise the patch looks good to me,

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

-Nathan
