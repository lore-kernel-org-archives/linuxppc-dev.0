Return-Path: <jgpobox@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C02FFB70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Jan 2011 12:10:25 +1100 (EST)
Received: by vws20 with SMTP id 20so130137vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 17:10:22 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4D3639FB.10608@pobox.com>
Date: Tue, 18 Jan 2011 20:10:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@mvista.com>, kumar.gala@freescale.com,
	Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
	<4D342C6E.6000608@ru.mvista.com>
In-Reply-To: <4D342C6E.6000608@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Xulei <B33228@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/17/2011 06:47 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 17-01-2011 10:10, Xulei wrote:
>
>> In FSL sata v2 block, the snoop bit of PRDT Word3 description
>> information is at bit28 instead of bit22.
>
>> This patch adds FSL sata v2 probe and resolve this difference.
>
>> Signed-off-by: Xulei <B33228@freescale.com>
>
> AFAIK, full name is required.
>
>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> [...]
>
>> diff --git a/arch/powerpc/boot/dts/p1022ds.dts
>> b/arch/powerpc/boot/dts/p1022ds.dts
>> index 2bbecbb..9ad41dd 100644
>> --- a/arch/powerpc/boot/dts/p1022ds.dts
>> +++ b/arch/powerpc/boot/dts/p1022ds.dts
>> @@ -475,14 +475,14 @@
>> };
>>
>> sata@18000 {
>> - compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
>> + compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>> reg =<0x18000 0x1000>;
>> cell-index =<1>;
>> interrupts =<74 0x2>;
>> };
>>
>> sata@19000 {
>> - compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
>> + compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>> reg =<0x19000 0x1000>;
>> cell-index =<2>;
>> interrupts =<41 0x2>;
>
> Please put this into the separate patch and push thru the PPC tree.

I think it's OK to send 100% of this via the PPC tree.  The sata_fsl.c 
patch for data_snoop variability directly keys off a call to 
platform-specific detail (of_device_is_compatible call).

Acked-by: Jeff Garzik <jgarzik@redhat.com>
