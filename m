Return-Path: <ppc@mindchasers.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BA271A0048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 23:20:47 +1000 (AEST)
Received: from resqmta-ch2-02v.sys.comcast.net
 (resqmta-ch2-02v.sys.comcast.net [69.252.207.34])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 828121401AB
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2015 23:20:45 +1000 (AEST)
Message-ID: <552FB721.1070605@mindchasers.com>
Date: Thu, 16 Apr 2015 09:20:33 -0400
From: Bob Cochran <ppc@mindchasers.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
 Pan Lijun-B44306 <Lijun.Pan@freescale.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
 <1428618671.22867.551.camel@freescale.com> <552F3E37.7030507@mindchasers.com>
In-Reply-To: <552F3E37.7030507@mindchasers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Schmitt Richard-B43082 <richard.schmitt@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/16/2015 12:44 AM, Bob Cochran wrote:
> On 04/09/2015 06:31 PM, Scott Wood wrote:
>> On Thu, 2015-04-09 at 16:52 -0500, Pan Lijun-B44306 wrote:
>>> Hi Maintainers,
>>>
>>> We have a proposal for writing the defconfigs for freescale's
>>> powperpc platforms in a new way.
>>> Can you take a look and provide some feedback?
>>>
>>> You know currently we have mpc85xx_defconfig, corenet32_defconfig,
>>> bsc913x_defconfig, *fman*_defconfig, etc.
>>> We are going to extract some common parts from the existing
>>> defconfigs, and name it, say, fsl_basic_defconfig.
>>> Then, we could create some defconfigs targeting specific features or
>>> specific platforms.
>>> Say, features specific: kvm_defconfig, fman_defconfig, etc.
>>> Platforms specific: p1_defconfig, p2_defcongfig, p4_defconfig,
>>> t1_defconfig, t2_defconfig, t2_defconfig, b4_defconfig, etc
>>> When we want to make a kernel image for p1 platform,
>>> Using the following steps:
>>>
>>> make ./scripts/kconfig/merge_config.sh
>>> arch/powerpc/configs/fsl_basic_config p1_defconfig
>>> make
>>>
>>> What do you think of this new approach?
>>> Will you accept this approach?
>>
>> I'm OK with a merge_config approach.
>>
>> I'm not OK with having separate builds for p1/p2/p4/t1/t2/b4.
>>
>> -Scott
>
>
> As you probably know, Freescale makes use of the Yocto Project build
> system for its SDK and submits patches to the SDK at a public
> meta-fsl-ppc repo at
> http://git.yoctoproject.org/cgit/cgit.cgi/meta-fsl-ppc/
>
> I have seen some kernel related patches in the past come across the
> Yocto Project site that made use of the Yocto Project kernel tools,
> which includes a process for maintaining kernel configuration fragments.


Here is a link to a patch from a Freescale developer introducing Yocto 
kernel tool support (description files & configuration fragments) to the 
meta-fsl-ppc repo (FSL QorIQ SDK on Yocto).

https://lists.yoctoproject.org/pipermail/meta-freescale/2014-October/010890.html



>   It sounds like the requirements you have could be met with Yocto's
> existing process.
>
> I was hoping to see Freescale continue to move in the direction of using
> the Yocto kernel tools rather than roll its own solution.
>
> The Yocto kernel tools make use of description files (*.scc) and
> configuration fragments (*.cfg).
>
> Here is a link to the latest stable Yocto kernel development manual:
> http://www.yoctoproject.org/docs/1.7.1/kernel-dev/kernel-dev.html
>
> Bob
>
>
>
>
>
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
