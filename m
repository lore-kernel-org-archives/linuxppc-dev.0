Return-Path: <sshtylyov@mvista.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D7B0B7021
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 21:23:46 +1000 (EST)
Received: by bkwj10 with SMTP id j10so4037502bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 04:23:42 -0700 (PDT)
Message-ID: <4F8417DB.3040502@mvista.com>
Date: Tue, 10 Apr 2012 15:22:03 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Thang Nguyen <tqnguyen@apm.com>
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
 <4F82B61D.8010502@mvista.com>
 <8a0ea5bd221ddeb9eded16e180aa8fbb@mail.gmail.com>
In-Reply-To: <8a0ea5bd221ddeb9eded16e180aa8fbb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 10-04-2012 7:46, Thang Nguyen wrote:

> Hi Sergei,
> Thanks for your review.

> On Maui, there are 2 separate SATA controllers but they share the same
> AHBDMA controller. Each SATA controller is assigned a fixed DMA channel on
> the AHBDMA (channel 0 is assigned to SATA controller 0 and channel 1 is
> assigned to SATA controller 1).
> For the 460EX, there is only 1 SATA controller and it uses channel 0 for
> transferring data.

> In my opinion, in the case of Maui, we can use the same DMA information in
> 2 device nodes as they use the same DMA controller. And in another CPU, if
> they use different DMA controller, the corresponding information will also
> be different.

    No, either the DMA controller should be a separate device node, or both 
ports and DMA controller should be packed into the single device node. The way 
you're doing it is incorrect because it creates memory resource conflict 
between devices when they are instantiated as platfrom devices.

> Regards,
> Thang Nguyen -
> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Monday, April 09, 2012 5:13 PM
> To: Thang Q. Nguyen
> Cc: Benjamin Herrenschmidt; Paul Mackerras; Jeff Garzik; Grant Likely; Rob
> Herring; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> linux-ide@vger.kernel.org; devicetree-discuss@lists.ozlabs.org
> Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change
> filename from sata_dwc_460ex.c to sata_dwc_4xx.c

> Hello.

> On 03-04-2012 14:12, Thang Q. Nguyen wrote:

>> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
> [...]

>> diff --git a/arch/powerpc/boot/dts/bluestone.dts
> b/arch/powerpc/boot/dts/bluestone.dts
>> index cfa23bf..803fda6 100644
>> --- a/arch/powerpc/boot/dts/bluestone.dts
>> +++ b/arch/powerpc/boot/dts/bluestone.dts
>> @@ -155,6 +155,27 @@
>>    					/*RXDE*/  0x5 0x4>;
>>    		};
>>
>> +		/* SATA DWC devices */
>> +		SATA0: sata@bffd1000 {
>> +			compatible = "amcc,sata-apm821xx";
>> +			reg =<4 0xbffd1000 0x800   /* SATA0 */
>> +			       4 0xbffd0800 0x400>; /* AHBDMA */
>> +			dma-channel=<0>;
>> +			interrupt-parent =<&UIC0>;
>> +			interrupts =<26 4    /* SATA0 */
>> +			              25 4>;  /* AHBDMA */
>> +		};
>> +
>> +		SATA1: sata@bffd1800 {
>> +			compatible = "amcc,sata-apm821xx";
>> +			reg =<4 0xbffd1800 0x800   /* SATA1 */
>> +			       4 0xbffd0800 0x400>; /* AHBDMA */
>> +			dma-channel=<1>;
>> +			interrupt-parent =<&UIC0>;
>> +			interrupts =<27 4    /* SATA1 */
>> +			              25 4>;  /* AHBDMA */
>> +		};
>> +

>      So, this is dual SATA controller, not dual port SATA controller?
> BTW, it's wrong to have the same AHBDMA resource in two device nodes I
> think.

> MBR, Sergei

    Can you get rid of the following? It looks stupid when you post to the 
maliing list.

> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,
> is for the sole use of the intended recipient(s) and contains information
> that is confidential and proprietary to AppliedMicro Corporation or its subsidiaries.
> It is to be used solely for the purpose of furthering the parties' business relationship.
> All unauthorized review, use, disclosure or distribution is prohibited.
> If you are not the intended recipient, please contact the sender by reply e-mail
> and destroy all copies of the original message.

WBR, Sergei
