Return-Path: <scott.wood@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10061.outbound.protection.outlook.com [40.107.1.61])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbSVN3ppbzDsdl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Sep 2016 07:05:31 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Andy Fleming <afleming@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "aperez@alexperez.com" <aperez@alexperez.com>
Subject: Re: [PATCH 2/3] corenet: Support gpio power/reset for corenet
Date: Fri, 16 Sep 2016 21:05:23 +0000
Message-ID: <DB5PR0401MB1928DE9CD2B29C991EF30A3E91F30@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-3-git-send-email-afleming@gmail.com>
 <DB5PR0401MB192878019FFA33204D6A3EBD91F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <CAKWjMd4PLus4rDr+SXTPewYRy6E8HBKowyqhiv5rqK+JpayMog@mail.gmail.com>
 <DB5PR0401MB192850140BF39D4BA322BD6991FF0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <1F518F22-C205-4106-BABF-2917C22E80FB@gmail.com>
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

On 09/15/2016 03:03 AM, Andy Fleming wrote:=0A=
> I agree that halt and power off mean and have always meant different=0A=
> things to the kernel. The problem is that most desktop systems,=0A=
> having halted, pass control to the BIOS which--usually--shuts off the=0A=
> power. Am I wrong about this? I've been using shutdown -h now to turn=0A=
> off my Linux systems for nearly 2 decades now, but I admit that I=0A=
> don't do it often, and I tend to stick with whatever works.=0A=
=0A=
>From the shutdown man page:=0A=
=0A=
     -h=0A=
           Equivalent to --poweroff, unless --halt is specified.=0A=
=0A=
Again, let's talk in terms of the kernel API rather than quirky=0A=
userspace commands.=0A=
=0A=
FWIW, I've always used "halt -p" and recall the system not powering off=0A=
on PCs when I use plain "halt", though it's been many years since I've=0A=
tried.=0A=
=0A=
>>>    I don't see any other platforms doing this.  How do the nodes get pr=
obed=0A=
>>>    for them?=0A=
>>>=0A=
>>>=0A=
>>>    The answer is I don't know, but this is a common issue with adding=
=0A=
>>>    new devices to the device tree in embedded powerpc. The only other=
=0A=
>>>    platforms which have gpio-poweroff nodes in their trees are in=0A=
>>>    arch/arm, and none of those platforms call the probing=0A=
>>>    function of_platform_bus_probe. I suspect they either probe every=0A=
>>>    root node, or they somehow construct the match_id. As noted in the=
=0A=
>>>    above-referenced commit, putting the nodes under the gpio bus does=
=0A=
>>>    not cause them to get probed. This seemed like the best way under=0A=
>>>    the current corenet code.=0A=
>>=0A=
>> Well, let's figure out what it is that PPC should be doing to have=0A=
>> things work the way it does on ARM.=0A=
> =0A=
> For all of the devices? Or just these two?=0A=
=0A=
All of them.  If ARM isn't maintaining these annoying lists why should=0A=
we have to? :-P=0A=
=0A=
-Scott=0A=
=0A=
