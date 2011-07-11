Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C2B6B6F7B
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 05:59:56 +1000 (EST)
Received: by gyb13 with SMTP id 13so2342280gyb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2011 12:59:53 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 12 Jul 2011 04:59:33 +0900
Message-ID: <CACxGe6sRjGzk2iVDXCMZS=AZk8mc_CtGp7CSqnO2WY-yih1Q8A@mail.gmail.com>
Subject: Re: RFC: top level compatibles for virtual platforms
To: Yoder Stuart-B08248 <B08248@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>, Alexander Graf <agraf@suse.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 11, 2011 at 11:34 PM, Yoder Stuart-B08248
<B08248@freescale.com> wrote:
>
>
>> -----Original Message-----
>> From: Tabi Timur-B04825
>> Sent: Friday, July 08, 2011 8:39 PM
>> To: Yoder Stuart-B08248
>> Cc: Grant Likely; Benjamin Herrenschmidt; Gala Kumar-B11780; Wood Scott-=
B07421; Alexander
>> Graf; linuxppc-dev@ozlabs.org
>> Subject: Re: RFC: top level compatibles for virtual platforms
>>
>> On Fri, Jul 8, 2011 at 1:43 PM, Yoder Stuart-B08248 <B08248@freescale.co=
m> wrote:
>>
>> > =A0 "MPC85xxDS" - for a virtual machine for the e500v2 type platforms
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and would support 85xx targets, plus P=
2020, P1022,etc
>> >
>> > =A0 "corenet-32-ds" - for a virtual machine similar to the 32-bit P408=
0
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platforms
>> >
>> > =A0 "corenet-64-ds" - for a virtual machine based on a 64-bit corenet
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform
>>
>> I think we should drop the "DS" because that's a name applied to certain=
 Freescale reference
>> boards.
>>
>> Is being a CoreNet board really something meaningful with respect to KVM=
? =A0I don't see the
>> connection.
>
> We're talking about what would be meaningful to Linux as a guest on
> this platform here-- =A0Corenet-based SoCs are similar
> in various ways, like using msgsnd for IPIs, having external proxy
> support, etc.
>
> A corenet platform created by a QEMU/KVM looks similar
> to other corenet SoCs. =A0 So, I'm trying to find some generic
> compatible string that describes this platform.
>
>> Also, if these are KVM creations, shouldn't there be a "kvm" in the comp=
atible string
>> somewhere?
>
> There is nothing KVM specific about these platforms. =A0Any hypervisor
> could create a similar virtual machine.
>
> A guest OS can determine specific info about the hypervisor it is
> running on by looking at the /hypervisor node on the device
> tree.
>
> We could put a generic -hv extension to indicate that this is
> a virtual platform.
>
> =A0"mpc85xx-hv"
> =A0"corenet-32-hv"
> =A0"corenet-64-hv"

However, compatible values are cheap and while theoretically any
hypervisor could create a similar machine, the reality is probably
subtle difference between the implementations.  I'd rather see the
compatible reflect the specific implementation.

g.
