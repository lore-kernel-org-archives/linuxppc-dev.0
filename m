Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8CFF6B6F7A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 01:45:54 +1000 (EST)
Message-ID: <4E1B1AAB.8010301@freescale.com>
Date: Mon, 11 Jul 2011 10:45:47 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: RFC: top level compatibles for virtual platforms
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>,
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

Yoder Stuart-B08248 wrote:

> We're talking about what would be meaningful to Linux as a guest on
> this platform here--  Corenet-based SoCs are similar 
> in various ways, like using msgsnd for IPIs, having external proxy
> support, etc.
> 
> A corenet platform created by a QEMU/KVM looks similar
> to other corenet SoCs.   So, I'm trying to find some generic
> compatible string that describes this platform.

Is there a list of these features that are 100% guaranteed to belong to a
corenet platform?

I'm just not comfortable using "corenet" as a basis for a feature set that has
nothing to do with coherency.

>> Also, if these are KVM creations, shouldn't there be a "kvm" in the compatible string
>> somewhere?
> 
> There is nothing KVM specific about these platforms.  Any hypervisor
> could create a similar virtual machine.

True, but I think we're on a slippery slope, here.  Virtualization allows us to
create "virtual platforms" that are not well defined.  Linux requires a unique
compatible string for each platform.  That's easy when we ship a reference board
that has a unique name and a fixed, well-defined set of features.  But with
these virtual platforms, what does the name mean?

I guess my point is back to the name "corenet".  That just doesn't mean anything
to me, and I don't think it means much to anyone else, either.  That's why I
think that maybe "kvm" should be in the string, to at least indicate that it's a
virtualized environment.

> A guest OS can determine specific info about the hypervisor it is
> running on by looking at the /hypervisor node on the device
> tree.
> 
> We could put a generic -hv extension to indicate that this is
> a virtual platform.
> 
>  "mpc85xx-hv"
>  "corenet-32-hv"
>  "corenet-64-hv"

That's an improvement, but I wonder if we should just keep doing what we do with
Topaz: take the actual hardware platform and add -hv to it.  Of course, that
conflicts with Topaz at the moment.

-- 
Timur Tabi
Linux kernel developer at Freescale

-- 
Timur Tabi
Linux kernel developer at Freescale
