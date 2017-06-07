Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjRXM6WP0zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 21:43:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, andrew.donnellan@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 clombard@linux.vnet.ibm.com, philippe.bergheaud@fr.ibm.com
Subject: Re: [PATCH] cxl: Fix error path on bad ioctl
In-Reply-To: <cd5831d7-9f74-928a-b5c8-a6e5622c8099@linux.vnet.ibm.com>
References: <20170602161523.14052-1-fbarrat@linux.vnet.ibm.com>
 <878tl5qxpw.fsf@concordia.ellerman.id.au>
 <cd5831d7-9f74-928a-b5c8-a6e5622c8099@linux.vnet.ibm.com>
Date: Wed, 07 Jun 2017 21:43:44 +1000
Message-ID: <874lvsf2fj.fsf@concordia.ellerman.id.au>
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

> Le 06/06/2017 =C3=A0 11:20, Michael Ellerman a =C3=A9crit :
>> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>>=20
>>> Fix error path if we can't copy user structure on
>>> CXL_IOCTL_START_WORK ioctl.
>>=20
>> To be clear the error is that returning via the out label will unlock
>> cxl->status_mutex, which has not been locked.
>>=20
>> Please spell it out for me :)
>>=20
>> This should be:
>>=20
>>    Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")
>>=20
>> Am I right?
>
> That's correct. I'm about to send a v2 to address Vaibhav's comment and=20
> I'll fix the above as well.

Thanks.

cheers
