Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x233.google.com (mail-yw0-x233.google.com
 [IPv6:2607:f8b0:4002:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8hdH2bWMzDvQy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 21:52:50 +1100 (AEDT)
Received: by mail-yw0-x233.google.com with SMTP id l124so38423500ywb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 03:52:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161103103019.GJ6949@naverao1-tp.localdomain>
References: <20161103065317.8537-1-naveen.n.rao@linux.vnet.ibm.com>
 <87zilgnb6x.fsf@concordia.ellerman.id.au>
 <20161103103019.GJ6949@naverao1-tp.localdomain>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Thu, 3 Nov 2016 13:52:47 +0300
Message-ID: <CAOJe8K02ZGT3mRTjBvMczV-2wkJmCj+UBiJfMOTr3Apnmjczaw@mail.gmail.com>
Subject: Re: compiling master.
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/3/16, Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com> wrote:
> On 2016/11/03 08:51PM, Michael Ellerman wrote:
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> > diff --git a/arch/powerpc/include/asm/exception-64s.h
>> > b/arch/powerpc/include/asm/exception-64s.h
>> > index 2e4e7d8..9b7b302 100644
>> > --- a/arch/powerpc/include/asm/exception-64s.h
>> > +++ b/arch/powerpc/include/asm/exception-64s.h
>> > @@ -91,7 +91,7 @@
>> >   */
>> >  #define LOAD_HANDLER(reg, label)					\
>> >  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
>> > -	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
>> > +	ori	reg,reg,((FIXED_SYMBOL_ABS_ADDR(label)) & 0xffff);
>>
>> That's weird. We explicitly added the @l there to make it work with
>> binutils 2.22. Is the Redhat "2.23" not really 2.23 ?

I have the same version: Version     : 2.23.52.0.1

>
> Not sure why @l isn't working. It does seem to be 2.23. Also, it is a
> bit weird that this only shows up on BE and not on LE...
>
> [root@rhel71be linux]# rpm -qf /usr/bin/as
> binutils-2.23.52.0.1-30.el7.ppc64
> [root@rhel71be linux]# rpm -qi binutils
> Name        : binutils
> Version     : 2.23.52.0.1
> Release     : 30.el7
> Architecture: ppc64
> Install Date: Thursday 03 November 2016 03:58:24 PM IST
> Group       : Development/Tools
> Size        : 14200512
> License     : GPLv3+
> Signature   : RSA/SHA256, Monday 19 January 2015 10:14:51 PM IST, Key ID
> 199e2f91fd431d51
> Source RPM  : binutils-2.23.52.0.1-30.el7.src.rpm
> Build Date  : Thursday 15 January 2015 10:55:42 PM IST
> Build Host  : ppc-020.build.eng.bos.redhat.com
> Relocations : (not relocatable)
> Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>
> Vendor      : Red Hat, Inc.
> URL         : http://sources.redhat.com/binutils
> Summary     : A GNU collection of binary utilities
>
>
> - Naveen
>
>
