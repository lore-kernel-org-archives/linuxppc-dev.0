Return-Path: <Hamish.Martin@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTsk22g3yzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:41:46 +1100 (AEDT)
From: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To: Michael Ellerman <mpe@ellerman.id.au>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 0/2] Allow configurable stack size (especially 32k on
 PPC64)
Date: Fri, 24 Feb 2017 00:35:10 +0000
Message-ID: <81a2fd09-d646-7dd1-1567-02a0d2044221@alliedtelesis.co.nz>
References: <20170220202440.25796-1-hamish.martin@alliedtelesis.co.nz>
 <871suqn3m7.fsf@concordia.ellerman.id.au>
In-Reply-To: <871suqn3m7.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/22/2017 07:25 PM, Michael Ellerman wrote:
> Hamish Martin <hamish.martin@alliedtelesis.co.nz> writes:
>> This patch series adds the ability to configure the THREAD_SHIFT value a=
nd
>> thereby alter the stack size on powerpc systems. We are particularly int=
erested
>> in configuring for a 32k stack on PPC64.
> ...
>>
>> For instance for a 70 frame stack, the architecture overhead just for th=
e stack
>> frames is:
>>    70 * 16 bytes =3D 1120 bytes for PPC32, and
>>    70 * 112 bytes =3D 7840 bytes for PPC64.
>> So a simple doubling of the PPC32 stack size leaves us with a shortfall =
of 5600
>> bytes (7840 - (2 * 1120)). In the example the stack frame overhead for P=
PC32 is
>> 1120/8192 =3D 13.5% of the stack space, whereas for PPC64 it is 7840/163=
84 =3D
>> 47.8% of the space.
>>
>> The aim of this series is to provide the ability for users to configure =
for
>> larger stacks without altering the defaults in a way that would impact e=
xisting
>> users. However, given the inequity between the PPC32 and PPC64 stacks wh=
en
>> taking into account the respective minimum stack frame sizes, we believe
>> consideration should be given to having a large default. We would apprec=
iate
>> any input or opinions on this issue.
>
> Thanks for the detailed explanation.
>
> The patches look fine, so I don't see any reason why we wouldn't merge
> this. I might make the config option depend on EXPERT, but that's just
> cosmetic.
>
>
> You're right about the difference in stack overhead between 32 & 64-bit.
> But I guess on the other hand we've been using 16K stacks on 64-bit for
> over 15 years, and although we have had some reports of stack overflow
> they're not a common problem.
>
> cheers
>
Yes, 15 years testing is hard to argue against, but in our case we feel=20
we have a stack that is reasonable and would cause no problems on PPC32.=20
This seems like a good compromise.
I think I was most keen to hear from you guys about whether it was a=20
flat out crazy idea, or if it would open up a huge can of hidden worms.=20
 From your response that seems not to be the case.

Thanks for the input, Michael. I'll add the EXPERT dependency and resubmit.
