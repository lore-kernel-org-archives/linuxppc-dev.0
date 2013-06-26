Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 030D32C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 20:08:28 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 04:08:24 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 608D23E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 04:08:00 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5QA8JZP092884
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 04:08:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5QA8I17028449
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 04:08:19 -0600
Date: Wed, 26 Jun 2013 18:08:14 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 3/6] powerpc/powernv: Replace variables with flags
Message-ID: <20130626100814.GA22174@shangw.(null)>
References: <1372210688-12214-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372210688-12214-4-git-send-email-shangw@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72A6@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72A6@saturn3.aculab.com>
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

On Wed, Jun 26, 2013 at 10:12:16AM +0100, David Laight wrote:
>> We have 2 fields in "struct pnv_phb" to trace the states. The patch
>> replace the fields with one and introduces flags for that. The patch
>> doesn't impact the logic.
>
>What is the benefit of this change?
>

There might have more flags coming in. Putting all flags together
could be maintained more easily. It doesn't save much memory as
you pointed.

>> +
>> +#define PNV_EEH_STATE_ENABLED	(1 << 0)	/* EEH enabled	*/
>> +#define PNV_EEH_STATE_REMOVED	(1 << 1)	/* PHB removed	*/
>> +
>>  #endif /* CONFIG_EEH */
>> 
>>  struct pnv_phb {
>> @@ -92,8 +96,7 @@ struct pnv_phb {
>> 
>>  #ifdef CONFIG_EEH
>>  	struct pnv_eeh_ops	*eeh_ops;
>> -	int			eeh_enabled;
>> -	int			removed;
>> +	int			eeh_state;
>>  #endif
>> 
>>  #ifdef CONFIG_DEBUG_FS
>
>All I can see is that it possibly reduces a structure by 4 bytes
>while adding extra code.
>(On 64 bit systems there might be a 4 byte pad added.)
>

Thanks,
Gavin
