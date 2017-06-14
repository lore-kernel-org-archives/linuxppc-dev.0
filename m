Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnlD05nPwzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 21:44:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Davide Caratti <dcaratti@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/configs: fix default values for NF_CT_PROTO_*
In-Reply-To: <1497356469.2604.18.camel@redhat.com>
References: <eb1df478772aec9e4caa43f575df5579c1f4170a.1496668107.git.dcaratti@redhat.com>
 <87lgowgo2f.fsf@concordia.ellerman.id.au>
 <1497356469.2604.18.camel@redhat.com>
Date: Wed, 14 Jun 2017 21:44:31 +1000
Message-ID: <87bmpq3iao.fsf@concordia.ellerman.id.au>
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

Davide Caratti <dcaratti@redhat.com> writes:

> On Tue, 2017-06-13 at 20:49 +1000, Michael Ellerman wrote:
>> Davide Caratti <dcaratti@redhat.com> writes:
>> 
>> > NF_CT_PROTO_{SCTP,UDPLITE,DCCP} can't be set to 'm' anymore, since they
>> > have been redefined as 'bool': fix defconfig for linkstation, mvme5100 and
>> > ppc6xx platforms accordingly.
>> 
>> Since when? ie. which commit changed the symbols to bool from tristate?
>
> hello Michael,
>
> the commits are:
>
> a85406afeb3e ("netfilter: conntrack: built-in support for SCTP")
> c51d39010a1b ("netfilter: conntrack: built-in support for DCCP")
> 9b91c96c5d1f ("netfilter: conntrack: built-in support for UDPlite")
>
> they were causing a "warning symbol value 'm' invalid" in kconfig: sorry
> for not noticing this before.

No worries. Thanks for sending the fix.

My auto builder did hit the warning, but it doesn't fail for those
warnings, eg:

http://kisskb.ellerman.id.au/kisskb/buildresult/13060278/


I'm actually going through our configs at the moment so I'll add this to
that series and merge it for 4.13.

cheers
