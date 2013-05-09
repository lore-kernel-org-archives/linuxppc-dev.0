Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B33352C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 20:23:25 +1000 (EST)
Message-ID: <518B7913.6010302@windriver.com>
Date: Thu, 9 May 2013 18:23:15 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
References: <1367970043.3398.39@snotra> <5189B02E.3000109@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3EFA26@039-SN2MPN1-013.039d.mgd.msft.net>
 <518A1AD8.3090103@windriver.com>
In-Reply-To: <518A1AD8.3090103@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/08/2013 05:28 PM, tiejun.chen wrote:
> On 05/08/2013 05:20 PM, Caraman Mihai Claudiu-B02008 wrote:
>>> -----Original Message-----
>>> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
>>> Behalf Of tiejun.chen
>>> Sent: Wednesday, May 08, 2013 4:54 AM
>>> To: Wood Scott-B07421
>>> Cc: agraf@suse.de; kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;
>>> linuxppc-dev@lists.ozlabs.org
>>> Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to
>>> Guest
>>>
>>> On 05/08/2013 07:40 AM, Scott Wood wrote:
>>>> On 05/07/2013 06:06:30 AM, Tiejun Chen wrote:
>>>>> We also can direct ISI exception to Guest like DSI.
>>>>>
>>>>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>>>>> ---
>>>>>   arch/powerpc/kvm/booke_emulate.c |    3 +++
>>>>>   arch/powerpc/kvm/e500mc.c        |    3 ++-
>>>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> Are you seeing a real performance improvement from this?  This will
>>> interfere
>>>
>>> No. But after we reduce the exit to host, shouldn't this improve
>>> performance?
>>
>> We lose some flexibility for this so it make sense only if we gain
>> measurable improvements.
>
> Sounds we have much more works to do.
>
>>
>>>
>>>> somewhat with using the VF bit, if we were to ever do so, since VF only
>>> affects
>>>
>>> Sorry, what is the VF you said?
>>
>> VF stands for virtualization fault see MAS8[VF] and we may use it for virtualized
>
> I almost forget this point :)

Looks KVM PPC have no this mechanism currently since I don't find MAS8_VF is 
used in kernel, right?

If I'm missing something please correct me.

Tiejun

>
>> MMIO. The hypervisor should deny execute access on pages marked with VF.
>> Accordingly
>> in this case guest ISI exceptions should be handled by the hypervisor.
>
