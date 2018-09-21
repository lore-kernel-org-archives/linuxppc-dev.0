Return-Path: <york.sun@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42H1mD4L81zF3Pw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 04:07:54 +1000 (AEST)
From: York Sun <york.sun@nxp.com>
To: Scott Wood <oss@buserror.net>, Scott Wood <swood@redhat.com>
CC: David Lamparter <equinox@diac24.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH ppc-next] powerpc/fsl-booke: don't load early TLB at once
Date: Fri, 21 Sep 2018 18:07:48 +0000
Message-ID: <DB7PR04MB4298007BF024E96CB6B2A02D9A120@DB7PR04MB4298.eurprd04.prod.outlook.com>
References: <20180920224856.GJ487685@eidolon.nox.tf>
 <1537489893.7689.38.camel@redhat.com>
 <DB7PR04MB4298A6AD0F866804A3F4FB6F9A120@DB7PR04MB4298.eurprd04.prod.outlook.com>
 <666d304e5aeae639dbae2f5e9f62d7234041d6d2.camel@buserror.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/21/2018 10:47 AM, Scott Wood wrote:=0A=
> On Fri, 2018-09-21 at 17:40 +0000, York Sun wrote:=0A=
>> On 09/20/2018 05:31 PM, Scott Wood wrote:=0A=
>>> On Fri, 2018-09-21 at 00:48 +0200, David Lamparter wrote:=0A=
>>>> This is a *partial* revert of "powerpc/85xx: Load all early TLB entrie=
s=0A=
>>>> at once" (d9e1831a420267a7ced708bb259d65b0a3c0344d.)=0A=
>>>>=0A=
>>>> My dusty old P4080DS just completely fails to boot (no output at all)=
=0A=
>>>> without this revert.  I have no clue what's going on here, I just=0A=
>>>> bisected it down and since it looks like an optimization to me I just=
=0A=
>>>> reverted it - and voil=E1, the P4080 boots again.=0A=
>>>=0A=
>>> It's not an optimization; it was required to get kdump working, at leas=
t=0A=
>>> for certain choices of crash kernel location.  I just tried booting a 3=
2-=0A=
>>> bit kernel and did not see this problem -- but I don't have access to a=
=0A=
>>> p4080ds anymore.  I tried with qemu e500mc, and also running a 32-bit=
=0A=
>>> kernel on e6500 (needs a tiny change to get past SMP init, since 32-bit=
=0A=
>>> isn't really supported on e6500, but you do get output even without tha=
t).=0A=
>>>=0A=
>>> Do you have a JTAG that can be used to find out where it's hanging?  If=
=0A=
>>> not, I can try to get early debug working (needs an early IOMMU mapping=
).=0A=
>>>=0A=
>>> York, can you try booting the latest kernel on p4080ds?=0A=
>>>=0A=
>>=0A=
>> Scott,=0A=
>>=0A=
>> I haven't tried P4080DS for a long time. What defconfig do you use for=
=0A=
>> this board? I tried latest master branch (commit a27fb6d983c7b5) with=0A=
>> corenet_basic_defconfig, it didn't boot up. Kernel has an exception very=
=0A=
>> early (pc ffffae80).=0A=
>>=0A=
>> However, before I claimed the board, someone booted Linux 4.14.71 on=0A=
>> this board. I need to track down where the image came from.=0A=
> =0A=
> Use corenet32_smp_defconfig=0A=
> =0A=
> corenet_basic_defconfig is just a fragment used by the makefiles in assem=
bling=0A=
> the final config.=0A=
> =0A=
=0A=
Thanks for the instruction. Linux comes up OK with corenet32_smp_defconfig.=
=0A=
=0A=
root@p4080ds:~# uname -a=0A=
Linux p4080ds 4.19.0-rc4-00206-ga27fb6d #1 SMP Fri Sep 21 10:56:36 PDT=0A=
2018 ppc GNU/Linux=0A=
=0A=
York=0A=
=0A=
