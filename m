Return-Path: <Hamish.Martin@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWbk33P5szDqGg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 07:17:47 +1100 (AEDT)
From: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To: David Laight <David.Laight@ACULAB.COM>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 0/2] Allow configurable stack size (especially 32k on
 PPC64)
Date: Sun, 26 Feb 2017 20:17:40 +0000
Message-ID: <c054d826-814c-48e7-6975-afb01c613a84@alliedtelesis.co.nz>
References: <20170224005210.1318-1-hamish.martin@alliedtelesis.co.nz>
 <063D6719AE5E284EB5DD2968C1650D6DCFE6EDAD@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFE6EDAD@AcuExch.aculab.com>
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

On 02/24/2017 10:54 PM, David Laight wrote:
> From: Hamish Martin
>> Sent: 24 February 2017 00:52
>> This patch series adds the ability to configure the THREAD_SHIFT value a=
nd
>> thereby alter the stack size on powerpc systems. We are particularly int=
erested
>> in configuring for a 32k stack on PPC64.
>>
>> Using an NXP T2081 (e6500 PPC64 cores) we are observing stack overflows =
as a
>> result of applying a DTS overlay containing some I2C devices. Our scenar=
io is
>> an ethernet switch chassis with plug-in cards. The I2C is driven from th=
e T2081
>> through a PCA9548 mux on the main board. When we detect insertion of the=
 plugin
>> card we schedule work for a call to of_overlay_create() to install a DTS
>> overlay for the plugin board. This DTS overlay contains a further PCA954=
8 mux
>> with more devices hanging off it including a PCA9539 GPIO expander. The
>> ultimate installed I2C tree is:
>>
>> T2081 --- PCA9548 MUX --- PCA9548 MUX --- PCA9539 GPIO Expander
>>
>> When we install the overlay the devices described in the overlay are pro=
bed and
>> we see a large number of stack frames used as a result. If this is coupl=
ed with
>> an interrupt happening that requires moderate to high stack use we obser=
ve
>> stack corruption. Here is an example long stack (from a 4.10-rc8 kernel)=
 that
>> does not show corruption but does demonstrate the length and frame sizes
>> involved.
> ...
>
> ISTM that the device probe needs to be iterative rather than recursive so
> that deeply nested buses don't require deep stacks.
>
> Switching stacks on interrupt entry would also make it much less likely t=
hat
> you'll get an unexpected stack corruption.
>
> The problem with just doubling the stack size is that code will just eat
> it all up and, in a few years, something will hit the limit again.
>
> 	David
>
>
Thanks for your comments David.

Yes, restructuring bus/device probing would be a better solution in the=20
longer term. It's what Ben H was alluding to in his reply to v1 of this=20
patch series. I do suspect that would be a fairly large undertaking=20
across the kernel drivers that may expose numerous bugs.

However, I still feel this series has validity given the inequity=20
between PPC64 and PPC32 minimum stack frame overhead.
Flipping it on its head, would anyone even consider a patch that sought=20
to make things more equivalent between PPC32 and PPC64 where the patch=20
involved reducing the PPC32 stack from 8k to something like 6k? I think not=
.

And of course, finally, this is user selectable and we don't seek to=20
modify the current default behaviour.

Cheers,
Hamish M.=
