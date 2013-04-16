Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B87E2C00FA
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 16:21:49 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 11:47:46 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5068D125804E
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 11:53:13 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3G6LbME63504568
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 11:51:37 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3G6LgLG028810
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 16:21:43 +1000
Message-ID: <516CEDF6.5040403@linux.vnet.ibm.com>
Date: Tue, 16 Apr 2013 11:51:42 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 5/8] Read rtas partition via pstore
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
 <20130410072327.20150.42189.stgit@aruna-ThinkPad-T420>
 <20130415080101.GF30156@concordia>
In-Reply-To: <20130415080101.GF30156@concordia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 15 April 2013 01:31 PM, Michael Ellerman wrote:
> On Wed, Apr 10, 2013 at 12:53:27PM +0530, Aruna Balakrishnaiah wrote:
>> This patch exploits pstore infrastructure to read the details
>> from NVRAM's rtas partition.
> Does that mean it's exposed in the pstore filesystem?

Yeah thats right.

>> Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
>> Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/nvram.c |   33 +++++++++++++++++++++++++-------
>>   fs/pstore/inode.c                      |    3 +++
>>   include/linux/pstore.h                 |    2 ++
>>   3 files changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
>> index 82d32a2..d420b1d 100644
>> --- a/arch/powerpc/platforms/pseries/nvram.c
>> +++ b/arch/powerpc/platforms/pseries/nvram.c
>> @@ -144,9 +144,11 @@ static size_t oops_data_sz;
>>   #ifdef CONFIG_PSTORE
>>   static enum pstore_type_id nvram_type_ids[] = {
>>   	PSTORE_TYPE_DMESG,
>> +	PSTORE_TYPE_RTAS,
>>   	-1
>>   };
>>   static int read_type;
>> +static unsigned long last_rtas_event;
>>   #endif
>>   /* Compression parameters */
>>   #define COMPR_LEVEL 6
>> @@ -315,8 +317,13 @@ int nvram_write_error_log(char * buff, int length,
>>   {
>>   	int rc = nvram_write_os_partition(&rtas_log_partition, buff, length,
>>   						err_type, error_log_cnt);
>> -	if (!rc)
>> +	if (!rc) {
>>   		last_unread_rtas_event = get_seconds();
>> +#ifdef CONFIG_PSTORE
>> +		last_rtas_event = get_seconds();
>> +#endif
>> +	}
>> +
>>   	return rc;
>>   }
>>   
>> @@ -745,7 +752,7 @@ static int nvram_pstore_write(enum pstore_type_id type,
>>   }
>>   
>>   /*
>> - * Reads the oops/panic report.
>> + * Reads the oops/panic report and ibm,rtas-log partition.
>>    * Returns the length of the data we read from each partition.
>>    * Returns 0 if we've been called before.
>>    */
>> @@ -765,6 +772,12 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
>>   		part = &oops_log_partition;
>>   		*type = PSTORE_TYPE_DMESG;
>>   		break;
>> +	case PSTORE_TYPE_RTAS:
>> +		part = &rtas_log_partition;
>> +		*type = PSTORE_TYPE_RTAS;
>> +		time->tv_sec = last_rtas_event;
>> +		time->tv_nsec = 0;
>> +		break;
>>   	default:
>>   		return 0;
>>   	}
>> @@ -781,11 +794,17 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
>>   
>>   	*count = 0;
>>   	*id = id_no;
>> -	oops_hdr = (struct oops_log_info *)buff;
>> -	*buf = buff + sizeof(*oops_hdr);
>> -	time->tv_sec = oops_hdr->timestamp;
>> -	time->tv_nsec = 0;
>> -	return oops_hdr->report_length;
>> +
>> +	if (nvram_type_ids[read_type] == PSTORE_TYPE_DMESG) {
>> +		oops_hdr = (struct oops_log_info *)buff;
>> +		*buf = buff + sizeof(*oops_hdr);
>> +		time->tv_sec = oops_hdr->timestamp;
>> +		time->tv_nsec = 0;
>> +		return oops_hdr->report_length;
>> +	}
>> +
>> +	*buf = buff;
>> +	return part->size;
>>   }
>>   #else
>>   static int nvram_pstore_open(struct pstore_info *psi)
>> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
>> index e4bcb2c..59b1454 100644
>> --- a/fs/pstore/inode.c
>> +++ b/fs/pstore/inode.c
>> @@ -324,6 +324,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
>>   	case PSTORE_TYPE_MCE:
>>   		sprintf(name, "mce-%s-%lld", psname, id);
>>   		break;
>> +	case PSTORE_TYPE_RTAS:
>> +		sprintf(name, "rtas-%s-%lld", psname, id);
>> +		break;
>>   	case PSTORE_TYPE_UNKNOWN:
>>   		sprintf(name, "unknown-%s-%lld", psname, id);
>>   		break;
>> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
>> index 75d0176..4eb94c9 100644
>> --- a/include/linux/pstore.h
>> +++ b/include/linux/pstore.h
>> @@ -35,6 +35,8 @@ enum pstore_type_id {
>>   	PSTORE_TYPE_MCE		= 1,
>>   	PSTORE_TYPE_CONSOLE	= 2,
>>   	PSTORE_TYPE_FTRACE	= 3,
>> +	/* PPC64 partition types */
>> +	PSTORE_TYPE_RTAS	= 10,
>>   	PSTORE_TYPE_UNKNOWN	= 255
> I think you should probably just continue at 4, and call it
> PSTORE_TYPE_PPC_RTAS. But you must get an ACK from the pstore
> maintainers for this and the previous hunk, and I don't see them on CC.

Sure, will add them on cc in my next version of the patches.

>
> cheers
>
