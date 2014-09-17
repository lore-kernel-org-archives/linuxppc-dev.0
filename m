Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D702E1A219C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 02:49:13 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 17 Sep 2014 12:49:10 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A63A86E8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 12:48:54 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8HGn6px3735886
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 16:49:06 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8HGn6f2025371
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 12:49:06 -0400
Received: from localhost.localdomain (dhcp-9-41-149-95.austin.ibm.com
 [9.41.149.95])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8HGn6Xn025340
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 12:49:06 -0400
Message-ID: <5419BB81.5040105@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 11:49:05 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/5] pseries: Define rtas hotplug event sections
References: <54174C20.1000009@linux.vnet.ibm.com>
 <1410937582.27681.9.camel@concordia>
In-Reply-To: <1410937582.27681.9.camel@concordia>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/17/2014 02:06 AM, Michael Ellerman wrote:
> 
> On Mon, 2014-09-15 at 15:29 -0500, Nathan Fontenot wrote:
>> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
>> index b390f55..a01879e 100644
>> --- a/arch/powerpc/include/asm/rtas.h
>> +++ b/arch/powerpc/include/asm/rtas.h
>> @@ -273,6 +273,7 @@ inline uint32_t rtas_ext_event_company_id(struct rtas_ext_event_log_v6 *ext_log)
>>  #define PSERIES_ELOG_SECT_ID_MANUFACT_INFO	(('M' << 8) | 'I')
>>  #define PSERIES_ELOG_SECT_ID_CALL_HOME		(('C' << 8) | 'H')
>>  #define PSERIES_ELOG_SECT_ID_USER_DEF		(('U' << 8) | 'D')
>> +#define PSERIES_ELOG_SECT_ID_HOTPLUG		(('H' << 8) | 'P')
>>  
>>  /* Vendor specific Platform Event Log Format, Version 6, section header */
>>  struct pseries_errorlog {
>> @@ -296,6 +297,31 @@ inline uint16_t pseries_errorlog_length(struct pseries_errorlog *sect)
>>  	return be16_to_cpu(sect->length);
>>  }
>>  
>> +/* RTAS pseries hotplug errorlog section */
>> +struct pseries_hp_errorlog {
>> +	uint8_t	resource;
>> +	uint8_t	action;
>> +	uint8_t	id_type;
>> +	uint8_t	reserved;
> 
> These should be u8.

ok.

> 
>> +	union {
>> +		__be32	drc_index;
>> +		__be32	drc_count;
>> +		char	drc_name[1];
> 
> I don't see drc_name used?

I don't use drc_name in this patch set but the drc_name piece is
part of the rtas hotplug section definition and I wanted to provide
a complete definition of the section.

-Nathan

> 
>> +	} _drc_u;
>> +};
> 
> cheers
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
