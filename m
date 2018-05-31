Return-Path: <diana.craciun@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0059.outbound.protection.outlook.com [104.47.2.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xVPH4JCCzDrbH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 00:35:31 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Leo Li <leoyang.li@nxp.com>
Subject: Re: [RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
Date: Thu, 31 May 2018 14:35:25 +0000
Message-ID: <VI1PR0401MB2463C17743BC5C25C2152631FF630@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
 <1527020969.30674.13.camel@buserror.net>
 <VI1PR0401MB246345AD11EC8666B7187F8DFF6D0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <1527621245.30674.30.camel@buserror.net>
 <87wovjykh8.fsf@concordia.ellerman.id.au>
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

On 5/31/2018 5:21 PM, Michael Ellerman wrote:=0A=
> Scott Wood <oss@buserror.net> writes:=0A=
>> On Tue, 2018-05-29 at 15:22 +0000, Diana Madalina Craciun wrote:=0A=
>>> On 05/22/2018 11:31 PM, Scott Wood wrote:=0A=
>>>> Should there be a way for the user to choose not to enable this (editi=
ng=0A=
>>>> the=0A=
>>>> device tree doesn't count), for a use case that is not sufficiently=0A=
>>>> security=0A=
>>>> sensitive to justify the performance loss?  What is the performance im=
pact=0A=
>>>> of=0A=
>>>> this patch?=0A=
>>> My reason was that on the other architectures Spectre variant 1=0A=
>>> mitigations are not disabled either. But I think that it might be a goo=
d=0A=
>>> idea to add a bootarg parameter to disable the barrier.=0A=
>> Is there a specific policy reason why they allow spectre v2 to be disabl=
ed but=0A=
>> not v1,=0A=
> No.=0A=
>=0A=
>> or just a matter of not having a mechanism to disable it,=0A=
> Yes and no. Some of the v1 mitigation is done via masking which can't be=
=0A=
> easily patched. eg. array_index_nospec()=0A=
>=0A=
>> or the parts which could practically be disabled not impacting=0A=
>> performance much?=0A=
> That's the mean reason AIUI.=0A=
>=0A=
> We can add a nospectre_v1 command line option if necessary.=0A=
=0A=
What about nobarrier_nospec (or similar) instead of nospectre_v1 command=0A=
line? We are not disabling all the v1 mitigations, the masking part will=0A=
remain unchanged.=0A=
=0A=
Diana=0A=
=0A=
=0A=
