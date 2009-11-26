Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5362BB7BCA
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 23:46:58 +1100 (EST)
Message-ID: <4B0E78BC.5050901@suse.de>
Date: Thu, 26 Nov 2009 13:46:52 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] PPC: Sync guest visible MMU state
References: <1259234174-1104-1-git-send-email-agraf@suse.de>
	<4B0E7738.5030506@redhat.com>
In-Reply-To: <4B0E7738.5030506@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kvm-ppc <kvm-ppc@vger.kernel.org>, kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avi Kivity wrote:
> On 11/26/2009 01:16 PM, Alexander Graf wrote:
>> Currently userspace has no chance to find out which virtual address
>> space we're
>> in and resolve addresses. While that is a big problem for migration,
>> it's also
>> unpleasent when debugging, as gdb and the monitor don't work on virtual
>> addresses.
>>
>> This patch exports enough of the MMU segment state to userspace to make
>> debugging work and thus also includes the groundwork for migration.
>>
>>
>>   struct kvm_sregs {
>> -    __u32 pvr;
>> -    char pad[1020];
>> +    union {
>> +        struct {
>> +            __u32 pvr;
>> +            __u64 sdr1;
>> +            struct {
>> +                struct {
>> +                    __u64 slbe;
>> +                    __u64 slbv;
>> +                } slb[64];
>> +            } ppc64;
>> +            struct {
>> +                __u32 sr[16];
>> +                __u64 ibat[8];
>> +                __u64 dbat[8];
>> +            } ppc32;
>> +        };
>> +        __u8 pad[1024];
>> +    };
>>   };
>>    
>
> Please avoid unnamed unions in user-visible headers - they're a gcc
> extension.
>
> Yes, we have them elsewhere, but let's not add to the pile.

I'm open to scalable suggestions that don't break existing userspace code.
If I name the union now, existing qemu code will break. If I align the
pad array manually I'll definitely mess up something.

Alex
