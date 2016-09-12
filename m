Return-Path: <scott.wood@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10052.outbound.protection.outlook.com [40.107.1.52])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY2xs5DNhzDsNS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 08:47:28 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Andy Fleming <afleming@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "aperez@alexperez.com" <aperez@alexperez.com>
Subject: Re: [PATCH 2/3] corenet: Support gpio power/reset for corenet
Date: Mon, 12 Sep 2016 22:47:21 +0000
Message-ID: <DB5PR0401MB192850140BF39D4BA322BD6991FF0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-3-git-send-email-afleming@gmail.com>
 <DB5PR0401MB192878019FFA33204D6A3EBD91F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <CAKWjMd4PLus4rDr+SXTPewYRy6E8HBKowyqhiv5rqK+JpayMog@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/10/2016 05:05 PM, Andy Fleming wrote:=0A=
> =0A=
> =0A=
> On Tuesday, September 6, 2016, Scott Wood <scott.wood@nxp.com=0A=
> <mailto:scott.wood@nxp.com>> wrote:=0A=
> =0A=
>     On 09/06/2016 02:12 PM, Andy Fleming wrote:=0A=
>     > Boards can implement power and reset functionality over gpio using=
=0A=
>     > these drivers:=0A=
>     >   drivers/power/reset/gpio-poweroff.c=0A=
>     >   drivers/power/reset/gpio-restart.c=0A=
>     >=0A=
>     > While not all corenet boards use gpio for power/reset, this=0A=
>     > support can be added without interfering with boards that do not=0A=
>     > use this functionality.=0A=
>     >=0A=
>     > If a board's device tree has the related nodes, they are now probed=
.=0A=
>     > Also, gpio-poweroff uses the global pm_power_off callback to implem=
ent=0A=
>     > the shutdown. However, pm_power_off was not invoked when the kernel=
=0A=
>     > halted, although that is usually the desired behavior. If the board=
=0A=
>     > provides gpio power and reset support, it is reasonable to assume t=
hat=0A=
>     > halting should also power down the system, unless it has chosen to=
=0A=
>     > pass those calls on to hypervisor.=0A=
> =0A=
>     Halt and poweroff are not the same thing.  If userspace requests a=0A=
>     poweroff, then kernel_power_off() will call machine_power_off() which=
=0A=
>     will call pm_power_off().=0A=
> =0A=
>     Why do we need anything corenet-specific here?=0A=
> =0A=
> =0A=
> =0A=
>     We don't, but then the board will halt instead of power off when you=
=0A=
>     type shutdown -h now.=0A=
=0A=
Isn't that what it's supposed to do?  If you want poweroff then ask for=0A=
poweroff.=0A=
=0A=
>     Or if you type poweroff without a high enough=0A=
>     run level, apparently.=0A=
=0A=
Hmm?=0A=
=0A=
In any case, run levels have nothing to do with the kernel.  The kernel=0A=
implements LINUX_REBOOT_CMD_HALT and LINUX_REBOOT_CMD_POWER_OFF, and=0A=
they should do what they're advertised to do.=0A=
=0A=
>     I'm amenable to removing the halt code, but=0A=
>     there are concerns that this will cause the systems to behave=0A=
>     unintentionally as intended, in that most systems that users=0A=
>     interact with shut down when you call shutdown -h now. There may be=
=0A=
>     scripts that depend on that behavior (or at least assume it).=0A=
=0A=
When did the behavior you're seeking ever exist?=0A=
=0A=
>     I don't see any other platforms doing this.  How do the nodes get pro=
bed=0A=
>     for them?=0A=
> =0A=
> =0A=
>     The answer is I don't know, but this is a common issue with adding=0A=
>     new devices to the device tree in embedded powerpc. The only other=0A=
>     platforms which have gpio-poweroff nodes in their trees are in=0A=
>     arch/arm, and none of those platforms call the probing=0A=
>     function of_platform_bus_probe. I suspect they either probe every=0A=
>     root node, or they somehow construct the match_id. As noted in the=0A=
>     above-referenced commit, putting the nodes under the gpio bus does=0A=
>     not cause them to get probed. This seemed like the best way under=0A=
>     the current corenet code.=0A=
=0A=
Well, let's figure out what it is that PPC should be doing to have=0A=
things work the way it does on ARM.=0A=
=0A=
-Scott=0A=
=0A=
