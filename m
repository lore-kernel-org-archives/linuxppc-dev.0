Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91ECCB6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 07:45:57 +1000 (EST)
Received: by vxi32 with SMTP id 32so2070230vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 14:45:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110722152911.364d75dd@schlenkerla.am.freescale.net>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-14-git-send-email-dbaryshkov@gmail.com>
	<20110719125447.19c964d1@schlenkerla.am.freescale.net>
	<CALT56yMxttzC+WZMhja3-PqneMMba5rs9j25RiSAUrwEA_jyaw@mail.gmail.com>
	<20110722152911.364d75dd@schlenkerla.am.freescale.net>
Date: Sat, 23 Jul 2011 01:45:53 +0400
Message-ID: <CALT56yOZkLW=AmkyX77g5agxfBb0h7Fz8Q_enth-CJycJ3SkFA@mail.gmail.com>
Subject: Re: [PATCH 13/14] 85xx: consolidate of_platform_bus_probe calls
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>,
	Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/23/11, Scott Wood <scottwood@freescale.com> wrote:
> On Fri, 22 Jul 2011 23:44:01 +0400
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>
>> On 7/19/11, Scott Wood <scottwood@freescale.com> wrote:
>> > On Tue, 19 Jul 2011 12:53:50 +0400
>> > Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>> >
>> >> +static struct of_device_id __initdata mpc85xx_common_ids[] = {
>> >> +	{ .type = "soc", },
>> >> +	{ .compatible = "soc", },
>> >> +	{ .compatible = "simple-bus", },
>> >> +	{ .compatible = "gianfar", },
>> >> +	{ .compatible = "fsl,qe", },
>> >> +	{ .compatible = "fsl,cpm2", },
>> >> +	{},
>> >> +};
>> >
>> > Same comment as for 83xx regarding localbus and compatibility with old
>> > device trees.
>>
>> I checked for in-kernel device trees. Unless I miss something, there are
>> no
>> leftovers from this list. (83xx provided no simple-bus property for
>> localbus,
>> so your argument is valid there). If we should care about strange cases,
>> not even blessed by kernel trees, I can add some of the old probes back.
>
> I see simple-bus missing in sbc8560 and ksi8560 -- were these included in
> the consolidation?  Plus some of the others may have had simple-bus added
> after their initial version.

Patches for those are included in the patch serie. Kumar has applied them
to next-3.2.

> As for out-of-tree trees (which could include trees dynamically
> generated/augmented by firmware, as well as device trees for custom boards
> that forked off of an old reference board tree), it's still nice to not
> break them as long as they stick to the binding.

I see your point. I just wasn't thinking too much about ot-of-tree trees.
My thought was that if someone updates the kernel, he can also update the dtb.

> While the localbus binding is deficient regarding the compatible property,
> IIRC localbus preceded the introduction of simple-bus, which appears to be
> defined only in ePAPR (not in Linux or on devicetree.org).  The ePAPR
> language does not suggest that it's mandatory for all buses that don't need
> special handling -- in fact, the language could be read as suggesting that
> it's only applicable to the "internal I/O bus" on an SoC (whereas this
> is an external bus), though that wasn't the intent behind it.

Could you please update the lbc.txt suggesting the compatibility
with simple-bus for lbc? Or you thing that it would be wrong?

I think we should define compatibility list as "fsl,mpcXXXX-localbus",
"fsl,pqXXXXX-localbus", "simple-bus", noting that by default new
platforms/boards should only use "simple-bus" internally. Does this
look reasonable for you? I can then try to provide a patch.

> The notion of probing buses isn't really a part of the device tree specs;
> they're more concerned with binding the devices themselves.  In theory
> Linux should probably be probing everything that a driver will match,
> regardless of where in the tree it is, except where an ancestor node is
> diasbled, has matched a driver that wants to do things differently, or is
> on a blacklist.  Of course, that's somewhat of a philosophical question on
> whether it's better to risk probing someting that shouldn't be, or not
> probing something that should be.  The former is often nastier but more
> obvious, the latter is more likely until simple-bus is more widely used,
> and either one results in something not working.

> Leaving the localbus in may help someone, and it shouldn't hurt anything.

What do you suggest/prefer? To add .name="localbus" to generic code
or to have board-specific hooks (like one for mpc834xemitx)?

So,

>
> -Scott
>
>


-- 
With best wishes
Dmitry
