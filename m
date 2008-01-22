Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6AF6DDE4A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:06:02 +1100 (EST)
Message-Id: <D2BA9CA7-96CF-40B8-8AE2-DC70A0955321@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40801221354i53b5e8ebn8fc547b8eea75ebe@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Add docs for Freescale PowerQUICC SATA device
	tree nodes
Date: Tue, 22 Jan 2008 16:05:37 -0600
References: <Pine.LNX.4.64.0801221536430.25559@blarg.am.freescale.net>
	<fa686aa40801221354i53b5e8ebn8fc547b8eea75ebe@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 22, 2008, at 3:54 PM, Grant Likely wrote:

> On 1/22/08, Kumar Gala <galak@kernel.crashing.org> wrote:
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> Documentation/powerpc/booting-without-of.txt |   30 ++++++++++++++++ 
>> ++++++++++
>> 1 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
>> Documentation/powerpc/booting-without-of.txt
>> index 3584c33..387310a 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
>> @@ -2743,6 +2743,36 @@ platforms are moved over to use the  
>> flattened-device-tree model.
>>                };
>>        };
>>
>> +    * Freescale 8xxx/3.0 Gb/s SATA nodes
>> +
>> +    SATA nodes are defined to describe on-chip Serial ATA  
>> controllers.
>> +    Each SATA port should have its own node.
>> +
>> +    Required properties:
>> +    - compatible        : compatible list, contains 2 entries,  
>> first is
>> +                        "fsl,CHIP-sata", where CHIP is the processor
>> +                        (mpc8315, mpc8379, etc.) and the second is
>> +                        "fsl,pq-sata"
>
> As discussed on IRC, I don't like the approach of trying to define
> generic names for these ip cores.  Too much can change in the future
> to make the definition of the generic type drift over time.  Better to
> always refer to exact chip variants.
>
> ie.  Assuming mpc8315 was the first part to contain the sata core; the
> dts should claim "fsl,CHIP-sata","fsl,mpc8315-sata" instead of
> "fsl,CHIP-sata","fsl,pq-sata".
>
> It ends up being the same amount of work to support, but it doesn't
> fall into the trap of making stuff up.
>
> Another example; when describing serial ports, we still use an
> *ancient* device to claim compatibility with: "ns16550".  ns16550 is
> specific, not generic, yet everyone still knows what it means.

Think of the 'specific' name as 'fsl,pq-sata'.  Just like ns16550  
there are lot of variants that do slightly different things which is  
captured by the even more specific 'fsl,mpc8313-sata' name.

I note your disagreement. :)

- k
