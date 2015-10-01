Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f182.google.com (mail-yk0-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EC911A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 19:32:06 +1000 (AEST)
Received: by ykdz138 with SMTP id z138so73194705ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2015 02:32:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443688770.8361.318.camel@linux.intel.com>
References: <20150814115200.0F4E1140293@ozlabs.org>
 <1443629978.8361.316.camel@linux.intel.com>
 <1443668200.17980.1.camel@ellerman.id.au>
 <CAOJe8K1qga-K0Nf=W1h7uP_Rr+w2akH4ES+PGmkSJTLTbL8oPg@mail.gmail.com>
 <1443688770.8361.318.camel@linux.intel.com>
Date: Thu, 1 Oct 2015 12:32:04 +0300
Message-ID: <CAOJe8K0HQE+4EuxdXTpGw=f8MRKNXyfmBi6-5MSvzmP9E6A+SQ@mail.gmail.com>
Subject: Re: [v2,5/5] powerpc/pseries: re-use code from of_helpers module
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/1/15, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Thu, 2015-10-01 at 10:02 +0300, Denis Kirjanov wrote:
>> On 10/1/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > On Wed, 2015-09-30 at 19:19 +0300, Andy Shevchenko wrote:
>> > > On Fri, 2015-08-14 at 21:51 +1000, Michael Ellerman wrote:
>> > > > On Tue, 2015-11-08 at 11:23:09 UTC, Andy Shevchenko wrote:
>> > > > >  int dlpar_attach_node(struct device_node *dn)
>> > > > >  {
>> > > > >  	int rc;
>> > > > >
>> > > > > -	dn->parent = derive_parent(dn->full_name);
>> > > > > -	if (!dn->parent)
>> > > > > -		return -ENOMEM;
>> > > > > +	dn->parent = pseries_of_derive_parent(dn
>> > > > > ->full_name);
>> > > > > +	if (IS_ERR(dn->parent))
>> > > > > +		return PTR_ERR(dn_parent);
>> > > >                                  ^
>> > > > 				 ?
>> > > >
>> > > > There are cross compilers on kernel.org, or on Ubuntu you can
>> > > > just:
>> > > >
>> > > > $ apt-get install gcc-powerpc-linux-gnu
>> > > > $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-gcc
>> > >
>> > > Thanks! I tried today and the above the only problem with the
>> > > series.
>> > > Would you like me to resend whole series?
>> >
>> > I'd like someone to test it. I gather that you haven't because it
>> > didn't
>> > compile.
>>
>> Oh yeah, totally untested:
>>
>>   CC      arch/powerpc/platforms/pseries/dlpar.o
>> arch/powerpc/platforms/pseries/dlpar.c: In function
>> 'dlpar_attach_node':
>> arch/powerpc/platforms/pseries/dlpar.c:255:18: error: 'dn_parent'
>> undeclared (first use in this function)
>>    return PTR_ERR(dn_parent);
>>                   ^
>> arch/powerpc/platforms/pseries/dlpar.c:255:18: note: each undeclared
>> identifier is reported only once for each function it appears in
>> scripts/Makefile.build:258: recipe for target
>> 'arch/powerpc/platforms/pseries/dlpar.o' failed
>> make[2]: *** [arch/powerpc/platforms/pseries/dlpar.o] Error 1
>> scripts/Makefile.build:403: recipe for target
>> 'arch/powerpc/platforms/pseries' failed
>> make[1]: *** [arch/powerpc/platforms/pseries] Error 2
>> Makefile:941: recipe for target 'arch/powerpc/platforms' failed
>> make: *** [arch/powerpc/platforms] Error 2
>
> Like I mentioned earlier this is the only one issue to compile the
> series. Can you fix it and try on real HW?

Please resend the updates series and then I'll test it.
Thanks!

>
>>
>> >
>> > I assume you don't have access to hardware to test it on?
>> >
>> > cheers
>> >
>> >
>> >
>> > _______________________________________________
>> > Linuxppc-dev mailing list
>> > Linuxppc-dev@lists.ozlabs.org
>> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
>
