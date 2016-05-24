Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDdTg5KcMzDqJd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 00:44:23 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 24 May 2016 10:44:18 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [v5,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <87mvngx7oq.fsf@vajain21.in.ibm.com>
Date: Tue, 24 May 2016 09:44:12 -0500
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 manoj@linux.vnet.ibm.com, imunsie@au1.ibm.com
Message-Id: <324850BE-6213-41ED-87B1-33A726D56AD8@linux.vnet.ibm.com>
References: <1464007742-1941-1-git-send-email-felix@linux.vnet.ibm.com>
 <87mvngx7oq.fsf@vajain21.in.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On May 24, 2016, at 1:59 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> =
wrote:
>=20
> Hi Philippe,
>=20
> Few comments,
>=20
> Philippe Bergheaud <felix@linux.vnet.ibm.com> writes:
>=20
>> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
>> index 4fe5078..b0027e6 100644
>> --- a/drivers/misc/cxl/cxl.h
>> +++ b/drivers/misc/cxl/cxl.h
>> @@ -24,6 +24,7 @@
>> #include <asm/reg.h>
>> #include <misc/cxl-base.h>
>>=20
>> +#include <misc/cxl.h>
>> #include <uapi/misc/cxl.h>
>>=20
>> extern uint cxl_verbose;
>> @@ -34,7 +35,7 @@ extern uint cxl_verbose;
>>  * Bump version each time a user API change is made, whether it is
>>  * backwards compatible ot not.
>>  */
>> -#define CXL_API_VERSION 2
>> +#define CXL_API_VERSION 3
>> #define CXL_API_VERSION_COMPATIBLE 1
>>=20
>> /*
>> @@ -522,6 +523,10 @@ struct cxl_context {
>> 	bool pending_fault;
>> 	bool pending_afu_err;
>>=20
>> +	/* Used by AFU drivers for driver specific event delivery */
>> +	struct cxl_afu_driver_ops *afu_driver_ops;
>> +	atomic_t afu_driver_events;
> If the afu_driver_ops.deliver_event is idempotent then instead of =
using
> a refcount we can simply call afu_driver_ops.deliver_event to see if
> there are any driver events queued. Since callback deliver_event is
> called in context of a spinlock and cannot sleep hence requirement of
> idempotency seems reasonable.

The purpose for the count is so the AFU driver is only called when it
has something to send. Otherwise we don't want to be called.
