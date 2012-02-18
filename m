Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C2421007D5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 11:47:57 +1100 (EST)
Message-ID: <4F3EF533.90409@freescale.com>
Date: Fri, 17 Feb 2012 18:47:47 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: [linuxppc-release] [PATCH 1/2] powerpc: document the FSL MPIC
 message register binding
References: <1329446943-9732-1-git-send-email-B38951@freescale.com>
 <9F6FE96B71CF29479FF1CDC8046E15032F516B@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15032F516B@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "meador_inge@mentor.com" <meador_inge@mentor.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 09:50 AM, Yoder Stuart-B08248 wrote:
> 
> 
>> -----Original Message-----
>> From: linuxppc-release-bounces@linux.freescale.net [mailto:linuxppc-release-
>> bounces@linux.freescale.net] On Behalf Of Jia Hongtao-B38951
>> Sent: Thursday, February 16, 2012 8:49 PM
>> To: linuxppc-dev@lists.ozlabs.org
>> Cc: meador_inge@mentor.com; Li Yang-R58472; Jia Hongtao-B38951
>> Subject: [linuxppc-release] [PATCH 1/2] powerpc: document the FSL MPIC message register
>> binding
>>
>> This binding documents how the message register blocks found in some FSL MPIC implementations
>> shall be represented in a device tree.
>>
>> Signed-off-by: Meador Inge <meador_inge@mentor.com>
>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>>  .../devicetree/bindings/powerpc/fsl/mpic-msgr.txt  |   62 ++++++++++++++++++++
>>  1 files changed, 62 insertions(+), 0 deletions(-)  create mode 100644
>> Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
>> b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
>> new file mode 100644
>> index 0000000..b4ae70e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
>> @@ -0,0 +1,62 @@
>> +* FSL MPIC Message Registers
>> +
>> +This binding specifies what properties must be available in the device
>> +tree representation of the message register blocks found in some FSL
>> +MPIC implementations.
>> +
>> +Required properties:
>> +
>> +    - compatible: Specifies the compatibility list for the message register
>> +      block.  The type shall be <string> and the value shall be of the form
>> +      "fsl,mpic-v<version>-msgr", where <version> is the version number of
>> +      the MPIC containing the message registers.
> 
> The type for compatibles is a <string-list>.
> 
>> +    - reg: Specifies the base physical address(s) and size(s) of the
>> +      message register block's addressable register space.  The type shall be
>> +      <prop-encoded-array>.
>> +
>> +    - interrupts: Specifies a list of interrupt source and level-sense pairs.
>> +      The type shall be <prop-encoded-array>.  The length shall be equal to
>> +      the number of registers that are available for receiving interrupts.
> 
> How many interrupts are there?   If more than 1,  this is where
> you need to specify what each interrupt is for.

They aren't "for" anything in particular -- each interrupt is associated
with a message register.  The binding does say that the number of
interrupts corresponds to the bits set in the receive mask.

>> +Optional properties:
>> +
>> +    - mpic-msgr-receive-mask: Specifies what registers in the containing block
>> +      are allowed to receive interrupts.  The value is a bit mask where a set
>> +      bit at bit 'n' indicates that message register 'n' can receive interrupts.
>> +      The type shall be <prop-encoded-array>.  If not present, then all of
>> +      the message registers in the block are available.
> 
> Your example implies that this is 1 32-bit cell.  If that is the case then
> this really should be of type '<u32>'.

And should clarify that "bit 'n'" means numbered from LSB, given how PPC
hardware docs tend to use the opposite convention.

-Scott
