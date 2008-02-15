Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BEE8DDF25
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 18:17:22 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1F7HJVx032468
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 02:17:19 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1F7HJ2h232198
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 02:17:19 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1F7HIIV031861
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 02:17:19 -0500
Message-ID: <47B53C7C.2060403@austin.ibm.com>
Date: Fri, 15 Feb 2008 01:17:16 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
References: <47B13D2E.1070001@austin.ibm.com> <47B146BE.5010807@austin.ibm.com>
	<20080215010528.GI6887@bakeyournoodle.com>
In-Reply-To: <20080215010528.GI6887@bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> On Tue, Feb 12, 2008 at 01:11:58AM -0600, Manish Ahuja wrote:
> 
> <snip>
> 
>> +static ssize_t
>> +show_release_region(struct kset * kset, char *buf)
>> +{
>> +	return sprintf(buf, "ola\n");
>> +}
>> +
>> +static struct subsys_attribute rr = __ATTR(release_region, 0600,
>> +					 show_release_region,
>> +					 store_release_region);
> 
> Any reason this sysfs attribute can't be write only? The show method
> doesn't seem needed.

yes, its used later in the code.

> 
>> +static int __init phyp_dump_setup(void)
>> +{
> 
> <snip>
> 
>> +	/* Is there dump data waiting for us? */
>> +	rtas = of_find_node_by_path("/rtas");
>> +	dump_header = of_get_property(rtas, "ibm,kernel-dump", &header_len);
> 
> Hmm this isn't good.  You need to check rtas != NULL.


yes, will fix this as well.



> 
>> +	if (dump_header == NULL) {
>> +		release_all();
>> +		return 0;
>> +	}
>> +
>> +	/* Should we create a dump_subsys, analogous to s390/ipl.c ? */
>> +	rc = subsys_create_file(&kernel_subsys, &rr);
>> +	if (rc) {
>> +		printk (KERN_ERR "phyp-dump: unable to create sysfs file (%d)\n", rc);
>> +		release_all();
>> +		return 0;
>> +	}
>>  
>>  	return 0;
>>  }
>> -
>>  subsys_initcall(phyp_dump_setup);
> 
> Hmm I think this really should be a:
> 	machine_subsys_initcall(pseries, phyp_dump_setup)
> 
> Yours Tony
> 
>   linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
>   Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
> 
