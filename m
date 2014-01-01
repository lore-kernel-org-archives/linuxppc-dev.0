Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 64C292C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jan 2014 14:29:49 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 31 Dec 2013 22:29:44 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9E1F7C90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Dec 2013 22:29:39 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s013Tf3U7471590
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jan 2014 03:29:41 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s013TfJF028881
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Dec 2013 22:29:41 -0500
Date: Wed, 1 Jan 2014 11:29:37 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc/eeh: Add restore_bars operation
Message-ID: <20140101032937.GB22907@shangw.(null)>
References: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1388182804.4373.17.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388182804.4373.17.camel@pasglop>
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

On Sat, Dec 28, 2013 at 09:20:04AM +1100, Benjamin Herrenschmidt wrote:
>On Wed, 2013-12-25 at 16:58 +0800, Gavin Shan wrote:
>> After reset on the specific PE or PHB, we never configure AER
>> correctly on PowerNV platform. We needn't care it on pSeries
>> platform. The patch introduces additional EEH operation eeh_ops::
>> restore_bars() so that we have chance to configure AER correctly
>> for PowerNV platform.
>
>Why call it "restore_bars" if it restores something else (in this case
>AER) ?
>
>I would call it "restore_config" instead... Also rather than adding
>the knowledge of what AER bit works or not for the device, would it
>make sense to instead have a FW call to re-init the device ?
>
>Otherwise, you introduce duplication between Linux and Firmware with
>the risk of getting out of sync...
>

Thanks for your comments, Ben. It's reasonable to have name "restore_config"
and I'll introduce a FW call in next revision as you suggested :-)

Thanks,
Gavin

>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/eeh.h               |    1 +
>>  arch/powerpc/kernel/eeh_pe.c                 |    3 +++
>>  arch/powerpc/platforms/pseries/eeh_pseries.c |    4 +++-
>>  3 files changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>> index d3e5e9b..4b709bf 100644
>> --- a/arch/powerpc/include/asm/eeh.h
>> +++ b/arch/powerpc/include/asm/eeh.h
>> @@ -157,6 +157,7 @@ struct eeh_ops {
>>  	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
>>  	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
>>  	int (*next_error)(struct eeh_pe **pe);
>> +	void (*restore_bars)(struct device_node *dn);
>>  };
>>  
>>  extern struct eeh_ops *eeh_ops;
>> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>> index f945053..19eb95a 100644
>> --- a/arch/powerpc/kernel/eeh_pe.c
>> +++ b/arch/powerpc/kernel/eeh_pe.c
>> @@ -737,6 +737,9 @@ static void *eeh_restore_one_device_bars(void *data, void *flag)
>>  	else
>>  		eeh_restore_device_bars(edev, dn);
>>  
>> +	if (eeh_ops->restore_bars)
>> +		eeh_ops->restore_bars(dn);
>> +
>>  	return NULL;
>>  }
>>  
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> index ccb633e..623adaf 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -689,7 +689,9 @@ static struct eeh_ops pseries_eeh_ops = {
>>  	.get_log		= pseries_eeh_get_log,
>>  	.configure_bridge       = pseries_eeh_configure_bridge,
>>  	.read_config		= pseries_eeh_read_config,
>> -	.write_config		= pseries_eeh_write_config
>> +	.write_config		= pseries_eeh_write_config,
>> +	.next_error		= NULL,
>> +	.restore_bars		= NULL
>>  };
>>  
>>  /**
>
>
