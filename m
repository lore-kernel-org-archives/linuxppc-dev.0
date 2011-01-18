Return-Path: <sshtylyov@mvista.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 7A832B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 23:34:12 +1100 (EST)
Received: by ewy19 with SMTP id 19so3059019ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 04:34:09 -0800 (PST)
Message-ID: <4D35887C.5030102@ru.mvista.com>
Date: Tue, 18 Jan 2011 15:33:00 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Zang Roy-R61911 <R61911@freescale.com>
Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
	<4D342C6E.6000608@ru.mvista.com>
	<2239AC579C7D3646A720227A37E0268109001B@039-SN1MPN1-004.039d.mgd.msft.net>
	<4D357918.4040001@ru.mvista.com>
	<2239AC579C7D3646A720227A37E02681090699@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <2239AC579C7D3646A720227A37E02681090699@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Xu Lei-B33228 <B33228@freescale.com>,
	Sergei Shtylyov <sshtylyov@mvista.com>,
	"jgarzik@pobox.com" <jgarzik@pobox.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 18-01-2011 14:43, Zang Roy-R61911 wrote:

>> On 18-01-2011 6:01, Zang Roy-R61911 wrote:
>>
>>>>> In FSL sata v2 block, the snoop bit of PRDT Word3 description
>>>>> information is at bit28 instead of bit22.

>>>>> This patch adds FSL sata v2 probe and resolve this difference.

>>>>> Signed-off-by: Xulei<B33228@freescale.com>

>>> [snip]

>>>>> diff --git a/arch/powerpc/boot/dts/p1022ds.dts
>>>> b/arch/powerpc/boot/dts/p1022ds.dts
>>>>> index 2bbecbb..9ad41dd 100644
>>>>> --- a/arch/powerpc/boot/dts/p1022ds.dts
>>>>> +++ b/arch/powerpc/boot/dts/p1022ds.dts
>>>>> @@ -475,14 +475,14 @@
>>>>>     		};
>>>>>
>>>>>     		sata@18000 {
>>>>> -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
>>>>> +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>>>>>     			reg =<0x18000 0x1000>;
>>>>>     			cell-index =<1>;
>>>>>     			interrupts =<74 0x2>;
>>>>>     		};
>>>>>
>>>>>     		sata@19000 {
>>>>> -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
>>>>> +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>>>>>     			reg =<0x19000 0x1000>;
>>>>>     			cell-index =<2>;
>>>>>     			interrupts =<41 0x2>;

>>>>       Please put this into the separate patch and push thru the PPC tree.

>>> I agree to put to them to separate patches, but should we
>>> pull in the separate patches to one candidate tree to make
>>> the function work?

>>      I don't understand. What is "candidate tree"?

> Powerpc or ide git repository for upstream to mainline.

    s/ide/libata/

> It is odd that patches for one function in different trees.

    The libata tree doesn't need to be concerned with PPC board specific 
device trees. Although it's up to the maintainer... just cross post the patch, 
and let the corresponding maintainers fogure it out.

> Thanks.
> Roy

WBR, Sergei
