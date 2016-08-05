Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Hws6DqszDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 17:09:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>,
 'Philippe Bergheaud' <felix@linux.vnet.ibm.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "mikey\@neuling.org" <mikey@neuling.org>,
 "mrochs\@linux.vnet.ibm.com" <mrochs@linux.vnet.ibm.com>,
 "fbarrat\@linux.vnet.ibm.com" <fbarrat@linux.vnet.ibm.com>,
 "manoj\@linux.vnet.ibm.com" <manoj@linux.vnet.ibm.com>,
 "ukrishn\@linux.vnet.ibm.com" <ukrishn@linux.vnet.ibm.com>,
 "imunsie\@au1.ibm.com" <imunsie@au1.ibm.com>
Subject: RE: [PATCH] cxl: Use fixed width predefined types in data structure.
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F509628@AcuExch.aculab.com>
References: <1470318964-19995-1-git-send-email-felix@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F509628@AcuExch.aculab.com>
Date: Fri, 05 Aug 2016 17:09:17 +1000
Message-ID: <87k2fviteq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight <David.Laight@ACULAB.COM> writes:

> From: Philippe Bergheaud
>> Sent: 04 August 2016 14:56
>> This patch fixes a regression introduced by commit b810253.
>> It substitutes the type __u8 to u8 in the uapi header cxl.h,
>> because the latter is not always defined in userland build
>> environments, in particular when cross-compiling libcxl on
>> x86_64 linux machines (RHEL6.7 and Ubuntu 16.04).
>> 
>> It also makes the definition of cxl_event_afu_driver_reserved
>> more consistent with the other definitions in the header file.
> ...
>> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
>> index cbae529..180d526 100644
>> --- a/include/uapi/misc/cxl.h
>> +++ b/include/uapi/misc/cxl.h
>> @@ -136,8 +136,8 @@ struct cxl_event_afu_driver_reserved {
>>  	 *
>>  	 * Of course the contents will be ABI, but that's up the AFU driver.
>>  	 */
>> -	size_t data_size;
>> -	u8 data[];
>> +	__u32 data_size;
>> +	__u8 data[];
>>  };
>
> You've just changed 'data_size' from 64bit to 32bit (on 64bit systems).
> This isn't mentioned in the commit message and changes the API.

Yeah that's pretty fishy.

In practice I suspect there aren't thousands of users of that API, the
commit is only a month old, so we can probably still change it. But
please call it out in the change log.

cheers
