Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 196B7DEE34
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 02:28:29 +1000 (EST)
Message-ID: <4804D7C4.8060805@windriver.com>
Date: Tue, 15 Apr 2008 12:28:52 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
	<4804D39C.9000309@freescale.com>
In-Reply-To: <4804D39C.9000309@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Paul Gortmaker wrote:
>
>   
>> -void
>> +static void
>>  mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
>>  {
>>  	struct device_node *root;
>> @@ -190,13 +190,13 @@ static int __init mpc86xx_hpcn_probe(void)
>>  {
>>  	unsigned long root = of_get_flat_dt_root();
>>  
>> -	if (of_flat_dt_is_compatible(root, "mpc86xx"))
>> +	if (of_flat_dt_is_compatible(root, "fsl,mpc86xx"))
>>  		return 1;	/* Looks good */
>>     
>
> This breaks compatibility with older device trees.  You still need to look for
> "mpc86xx".
>
> A lot of people have been doing this recently, and it needs to stop.  You need
> to wait at least one whole kernel version before you can remove support for an
> older device tree.
>   

Valid point.  Is there a precedent here -- like a printk indicating
that the old ID matched, to let the user know?

>   
>> -void
>> +static void
>>  sbc8641_show_cpuinfo(struct seq_file *m)
>>  {
>>  	struct device_node *root;
>> @@ -118,13 +111,13 @@ static int __init sbc8641_probe(void)
>>  {
>>  	unsigned long root = of_get_flat_dt_root();
>>  
>> -	if (of_flat_dt_is_compatible(root, "mpc86xx"))
>> +	if (of_flat_dt_is_compatible(root, "wrs,sbc8641"))
>>  		return 1;	/* Looks good */
>>     
>
> Same here.
>   

Actually on this one, we are OK, since the board support didn't exist
in the default kernel until I'd just sent it last week.

Thanks,
Paul.
