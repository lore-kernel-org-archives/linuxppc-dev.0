Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D67B22C009E
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Jun 2013 19:02:20 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 4 Jun 2013 14:25:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F31B4E0057
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Jun 2013 14:34:58 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r54924os6881738
 for <linuxppc-dev@ozlabs.org>; Tue, 4 Jun 2013 14:32:04 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5492AnN016204
 for <linuxppc-dev@ozlabs.org>; Tue, 4 Jun 2013 19:02:12 +1000
Message-ID: <51ADAD0E.4010001@linux.vnet.ibm.com>
Date: Tue, 04 Jun 2013 14:32:06 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 8/8] powerpc/pseries: Read common partition via pstore
References: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
 <20130425101908.21017.32553.stgit@aruna-ThinkPad-T420>
 <1370062367.3766.30.camel@pasglop>
In-Reply-To: <1370062367.3766.30.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 paulus@samba.org, anton@samba.org, ccross@android.com, keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 01 June 2013 10:22 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-04-25 at 15:49 +0530, Aruna Balakrishnaiah wrote:
>
>> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
>> index 8d4fb65..88cc050 100644
>> --- a/fs/pstore/inode.c
>> +++ b/fs/pstore/inode.c
>> @@ -330,6 +330,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
>>   	case PSTORE_TYPE_PPC_OF:
>>   		sprintf(name, "of-%s-%lld", psname, id);
>>   		break;
> Call this powerpc-ofw-... Does it even contain something we use in Linux
> at all ? Last I looked we only used the common one right ? Also it's
> format afaik is defined in the CHRP bindings so it's not generic OFW
> stuff, hence the powerpc prefix.
>
>> +	case PSTORE_TYPE_PPC_COMMON:
>> +		sprintf(name, "common-%s-%lld", psname, id);
>> +		break;
> Same deal, call that powerpc-common

Sure. Will change it to powerpc prefix.

>>   	case PSTORE_TYPE_UNKNOWN:
>>   		sprintf(name, "unknown-%s-%lld", psname, id);
>>   		break;
>> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
>> index 615dc18..656699f 100644
>> --- a/include/linux/pstore.h
>> +++ b/include/linux/pstore.h
>> @@ -38,6 +38,7 @@ enum pstore_type_id {
>>   	/* PPC64 partition types */
>>   	PSTORE_TYPE_PPC_RTAS	= 4,
>>   	PSTORE_TYPE_PPC_OF	= 5,
>> +	PSTORE_TYPE_PPC_COMMON	= 6,
>>   	PSTORE_TYPE_UNKNOWN	= 255
>>   };
> Do we expose anything else or keep it hidden ?

We are exposing oops, rtas, of-config and common partition of nvram.

> Cheers,
> Ben.
>
>
