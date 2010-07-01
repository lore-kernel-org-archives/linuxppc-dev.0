Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 006E61007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 18:18:12 +1000 (EST)
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C2C43C0.4000400@redhat.com>
Date: Thu, 1 Jul 2010 10:18:05 +0200
Message-Id: <7F9C2F52-3E95-4A22-B973-DACEBC95E5F4@suse.de>
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
	<4C2C43C0.4000400@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01.07.2010, at 09:29, Avi Kivity wrote:

> On 06/30/2010 04:18 PM, Alexander Graf wrote:
>> Book3s suffered from my really bad shadow MMU implementation so far. =
So
>> I finally got around to implement a combined hash and list mechanism =
that
>> allows for much faster lookup of mapped pages.
>>=20
>> To show that it really is faster, I tried to run simple process =
spawning
>> code inside the guest with and without these patches:
>>=20
>> [without]
>>=20
>> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello>  =
/dev/null; done
>>=20
>> real    0m20.235s
>> user    0m10.418s
>> sys     0m9.766s
>>=20
>> [with]
>>=20
>> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello>  =
/dev/null; done
>>=20
>> real    0m14.659s
>> user    0m8.967s
>> sys     0m5.688s
>>=20
>> So as you can see, performance improved significantly.
>>=20
>> v2 ->  v3:
>>=20
>>   - use hlist
>>   - use global slab cache
>>=20
>>  =20
>=20
> Looks good.

Great :).

How does dirty bitmap flushing work on x86 atm? I loop through all =
mapped pages and flush the ones that match the range of the region I =
need to flush. But wouldn't it be a lot more efficient to have an hlist =
in the memslot and loop through that when I need to flush that memslot?

Alex
