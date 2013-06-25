Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D3A62C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 17:13:09 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 01:13:06 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5C8851FF001B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:07:48 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P7D3an151842
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:13:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P7D3RK024754
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:13:03 -0600
Date: Tue, 25 Jun 2013 15:12:59 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 04/10] powerpc/eeh: Backends to get/set settings
Message-ID: <20130625071259.GA6784@shangw.(null)>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372139717-14885-5-git-send-email-shangw@linux.vnet.ibm.com>
 <1372140444.3944.190.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372140444.3944.190.camel@pasglop>
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

On Tue, Jun 25, 2013 at 04:07:24PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2013-06-25 at 13:55 +0800, Gavin Shan wrote:
>> When the PHB gets fenced, 0xFF's returns from PCI config space and
>> MMIO space in the hardware. The operations writting to them should
>> be dropped. The patch introduce backends allow to set/get flags that
>> indicate the access to PCI-CFG and MMIO should be blocked.
>
>We can't block MMIO without massive overhead. Config space can be
>blocked inside the firmware, can't it ?
>

Yep. The config space has been blocked on fenced PHB by firmware. I
almostly forgot that (struct p7ioc_phb::use_asb) :-)

Thanks,
Gavin

>
>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/eeh.h               |    6 +++
>>  arch/powerpc/platforms/pseries/eeh_pseries.c |   44 ++++++++++++++++++++++++++
>>  2 files changed, 50 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>> index dd65e31..de821c1 100644
>> --- a/arch/powerpc/include/asm/eeh.h
>> +++ b/arch/powerpc/include/asm/eeh.h
>> @@ -131,6 +131,10 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
>>  #define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
>>  #define EEH_LOG_PERM		2	/* EEH permanent error log	*/
>>  
>> +/* Settings for platforms */
>> +#define EEH_SETTING_BLOCK_CFG	1	/* Blocked PCI config access	*/
>> +#define EEH_SETTING_BLOCK_IO	2	/* Blocked MMIO access		*/
>> +
>>  struct eeh_ops {
>>  	char *name;
>>  	int (*init)(void);
>> @@ -146,6 +150,8 @@ struct eeh_ops {
>>  	int (*configure_bridge)(struct eeh_pe *pe);
>>  	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
>>  	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
>> +	int (*get_setting)(int option, int *value, void *data);
>> +	int (*set_setting)(int option, int value, void *data);
>>  	int (*next_error)(struct eeh_pe **pe);
>>  };
>>  
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> index 62415f2..8c9509b 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -612,6 +612,48 @@ static int pseries_eeh_write_config(struct device_node *dn, int where, int size,
>>  	return rtas_write_config(pdn, where, size, val);
>>  }
>>  
>> +/**
>> + * pseries_eeh_get_setting - Retrieve settings that affect EEH core
>> + * @option: option
>> + * @value: value
>> + * @data: dependent data
>> + *
>> + * Retrieve the settings from the platform in order to affect the
>> + * behaviour of EEH core. We don't block PCI config or MMIO access
>> + * on pSeries platform.
>> + */
>> +static int pseries_eeh_get_setting(int option, int *value, void *data)
>> +{
>> +	int ret = 0;
>> +
>> +	switch (option) {
>> +	case EEH_SETTING_BLOCK_CFG:
>> +	case EEH_SETTING_BLOCK_IO:
>> +		*value = 0;
>> +		break;
>> +	default:
>> +		pr_warning("%s: Unrecognized option (%d)\n",
>> +			   __func__, option);
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * pseries_eeh_set_setting - Configure settings to affect EEH core
>> + * @option: option
>> + * @value: value
>> + * @data: dependent data
>> + *
>> + * Configure the settings for the platform in order to affect the
>> + * behaviour of EEH core.
>> + */
>> +static int pseries_eeh_set_setting(int option, int value, void *data)
>> +{
>> +	return 0;
>> +}
>> +
>>  static struct eeh_ops pseries_eeh_ops = {
>>  	.name			= "pseries",
>>  	.init			= pseries_eeh_init,
>> @@ -626,6 +668,8 @@ static struct eeh_ops pseries_eeh_ops = {
>>  	.configure_bridge       = pseries_eeh_configure_bridge,
>>  	.read_config		= pseries_eeh_read_config,
>>  	.write_config		= pseries_eeh_write_config,
>> +	.get_setting		= pseries_eeh_get_setting,
>> +	.set_setting		= pseries_eeh_set_setting,
>>  	.next_error		= NULL
>>  };
>>  
>
>
