Return-Path: <lacombar@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C94FB6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 02:09:25 +1000 (EST)
Received: by ewy6 with SMTP id 6so1075678ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 09:09:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110826015111.49af16f792d5554fd931d230@canb.auug.org.au>
References: <20110825161843.daf46b6b4023926fcfeec387@canb.auug.org.au>
	<20110825140820.GA9126@kroah.com> <4E56689D.3080202@freescale.com>
	<20110826015111.49af16f792d5554fd931d230@canb.auug.org.au>
Date: Thu, 25 Aug 2011 12:09:20 -0400
Message-ID: <CACqU3MUs_97=MuuKAjr-LeUT7kSRxtzSntwUeKeeH4n8s7SSGg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the final tree (tty tree
	related)
From: Arnaud Lacombe <lacombar@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <greg@kroah.com>, linux-next@vger.kernel.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Timur Tabi <timur@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, Aug 25, 2011 at 11:51 AM, Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> Hi Timur,
>
> On Thu, 25 Aug 2011 10:22:05 -0500 Timur Tabi <timur@freescale.com> wrote=
:
>>
>> Is there some trick to building allyesconfig on PowerPC? =A0When I do tr=
y that, I
>> get all sorts of weird build errors, and it dies long before it gets to =
my
>> driver. =A0I get stuff like:
>>
>> =A0 LD =A0 =A0 =A0arch/powerpc/sysdev/xics/built-in.o
>> WARNING: arch/powerpc/sysdev/xics/built-in.o(.text+0x1310): Section mism=
atch in
>> reference from the function .icp_native_init() to the function
>> .init.text:.icp_native_init_one_node()
>> The function .icp_native_init() references
>> the function __init .icp_native_init_one_node().
>> This is often because .icp_native_init lacks a __init
>> annotation or the annotation of .icp_native_init_one_node is wrong.
>
> We get lots of those in many builds. :-( =A0Just a warning.
>
If you could provide an exhaustive list of them, I'd be interested. Do
you account/reference them in the report you make on each new -next
tree ?

 - Arnaud

>> and
>>
>> =A0 AS =A0 =A0 =A0arch/powerpc/kernel/head_64.o
>> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
>> arch/powerpc/kernel/exceptions-64s.S:1151: Error: attempt to move .org b=
ackwards
>> arch/powerpc/kernel/exceptions-64s.S:1160: Error: attempt to move .org b=
ackwards
>
> There is a patch for that pending with either the kvm guys or the powerpc=
 guys.
>
>> I guess I don't have the right compiler.
>
> Yours seems to be OK. =A0If you pass -k to make it will get further. =A0O=
r
> you could configure it and then just try building your driver rather than
> the whole tree.
>
>> Anyway, I think I know how to fix the break that Stephen is seeing. =A0I=
 will post
>> a v4 patch in a few minutes.
>
> Thanks.
> --
> Cheers,
> Stephen Rothwell =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sfr@canb.auug.org=
.au
> http://www.canb.auug.org.au/~sfr/
>
