Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1F6m54lWzDwNV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 21:50:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Hansen <dave.hansen@intel.com>, Ram Pai <linuxram@us.ibm.com>,
 mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH v9 29/51] mm/mprotect, powerpc/mm/pkeys,
 x86/mm/pkeys: Add sysfs interface
In-Reply-To: <bbc5593e-31ec-183a-01a5-1a253dc0c275@intel.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <1509958663-18737-30-git-send-email-linuxram@us.ibm.com>
 <bbc5593e-31ec-183a-01a5-1a253dc0c275@intel.com>
Date: Tue, 19 Dec 2017 21:50:24 +1100
Message-ID: <877etj9ekv.fsf@concordia.ellerman.id.au>
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

Dave Hansen <dave.hansen@intel.com> writes:

> On 11/06/2017 12:57 AM, Ram Pai wrote:
>> Expose useful information for programs using memory protection keys.
>> Provide implementation for powerpc and x86.
>> 
>> On a powerpc system with pkeys support, here is what is shown:
>> 
>> $ head /sys/kernel/mm/protection_keys/*
>> ==> /sys/kernel/mm/protection_keys/disable_access_supported <==
>> true
>
> This is cute, but I don't think it should be part of the ABI.  Put it in
> debugfs if you want it for cute tests.  The stuff that this tells you
> can and should come from pkey_alloc() for the ABI.

Yeah I agree this is not sysfs material.

In particular the total/usable numbers are completely useless vs other
threads allocating pkeys out from under you.

> http://man7.org/linux/man-pages/man7/pkeys.7.html
>
>>        Any application wanting to use protection keys needs to be able to
>>        function without them.  They might be unavailable because the
>>        hardware that the application runs on does not support them, the
>>        kernel code does not contain support, the kernel support has been
>>        disabled, or because the keys have all been allocated, perhaps by a
>>        library the application is using.  It is recommended that
>>        applications wanting to use protection keys should simply call
>>        pkey_alloc(2) and test whether the call succeeds, instead of
>>        attempting to detect support for the feature in any other way.
>
> Do you really not have standard way on ppc to say whether hardware
> features are supported by the kernel?  For instance, how do you know if
> a given set of registers are known to and are being context-switched by
> the kernel?

Yes we do, we emit feature bits in the AT_HWCAP entry of the aux vector,
same as some other architectures.

But I don't see the need to use a feature bit for pkeys. If they're not
supported then pkey_alloc() will just always fail. Apps have to handle
that anyway because keys are a finite resource.

cheers
