Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7Zlw2JwCzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 10:24:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 ukrishn@linux.vnet.ibm.com, imunsie@au1.ibm.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH v2] cxl: Use fixed width predefined types in data
 structure.
In-Reply-To: <faa68f54-d826-02dd-9265-aeae0d8dc118@linux.vnet.ibm.com>
References: <1470398520-20463-1-git-send-email-felix@linux.vnet.ibm.com>
 <faa68f54-d826-02dd-9265-aeae0d8dc118@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 10:24:25 +1000
Message-ID: <87eg5yssau.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Le 05/08/2016 =C3=A0 14:02, Philippe Bergheaud a =C3=A9crit :
>> This patch fixes a regression introduced by commit b810253.
>>
>> It substitutes the type __u8 to u8 in the uapi header cxl.h,
>> because the latter is not always defined in userland build
>> environments, in particular when cross-compiling libcxl on
>> x86_64 linux machines (RHEL6.7 and Ubuntu 16.04).
>>
>> This patch also changes the size of the field data_size, and
>> makes it constant, to support 32-bit userland applications
>> running on big-endian ppc64 kernels transparently.
>>
>> This breaks the (young) API that has been merged in v4.8.
>>
>> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
>> ---
>> Changes since v1:
>>   Added an explanation for the proposed API change in the log.
>>
>> Note:
>> As far as I know, cxlflash is the only known user of the API.
>
>
> Yes, ideally, we'd like to change the type of 'data_size' to something=20
> smaller/constant and were expecting it's still doable since the API was=20
> merged to 4.8 and the expected user (cxlflash) hasn't started using the=20
> API yet.

Yep that's fine, it just needed to be mentioned in the change log.

We don't guarantee that an ABI merged in -rc1 doesn't change in -rc2.
But we do (in general) guarantee that an ABI in a released kernel (ie.
4.8 final), never changes.

cheers
