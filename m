Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 924861A00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 03:21:56 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0125.outbound.protection.outlook.com [65.55.169.125])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8F16414009D
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2014 03:21:54 +1100 (AEDT)
Message-ID: <54526521.1090601@Freescale.com>
Date: Thu, 30 Oct 2014 11:19:45 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
 <EA33D307-CCDA-4A30-9386-46FA832FE0CA@codeaurora.org>
 <1414519738.23458.84.camel__4795.38602890006$1414521743$gmane$org@snotra.buserror.net>
 <54515ECB.70404@Freescale.com>
 <1414620996.23458.141.camel__29590.7804662876$1414621051$gmane$org@snotra.buserror.net>
 <5451BF49.6050106@Freescale.com>
 <1414680683.23458.148.camel__4514.07629666409$1414680744$gmane$org@snotra.buserror.net>
In-Reply-To: <1414680683.23458.148.camel__4514.07629666409$1414680744$gmane$org@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, Geoff.Thorpe@Freescale.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linuxppc-dev@ozlabs.org, robh+dt@kernel.org,
 Kumar Gala <galak@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 10/30/2014 09:51 AM, Scott Wood wrote:
> On Wed, 2014-10-29 at 23:32 -0500, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 10/29/2014 05:16 PM, Scott Wood wrote:
>>> On Wed, 2014-10-29 at 16:40 -0500, Emil Medve wrote:
>>>> Hello Scott,
>>>>
>>>>
>>>> On 10/28/2014 01:08 PM, Scott Wood wrote:
>>>>> On Tue, 2014-10-28 at 09:36 -0500, Kumar Gala wrote:
>>>>>> On Oct 22, 2014, at 9:09 AM, Emil Medve <Emilian.Medve@freescale.com> wrote:
>>>>>>
>>>>>>> The Buffer Manager is part of the Data-Path Acceleration Architecture (DPAA).
>>>>>>> BMan supports hardware allocation and deallocation of buffers belonging to
>>>>>>> pools originally created by software with configurable depletion thresholds.
>>>>>>> This binding covers the CCSR space programming model
>>>>>>>
>>>>>>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>>>>>>> Change-Id: I3ec479bfb3c91951e96902f091f5d7d2adbef3b2
>>>>>>> ---
>>>>>>> .../devicetree/bindings/powerpc/fsl/bman.txt       | 98 ++++++++++++++++++++++
>>>>>>> 1 file changed, 98 insertions(+)
>>>>>>> create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman.txt
>>>>>>
>>>>>> Should these really be in bindings/powerpc/fsl, aren’t you guys using this on ARM SoCs as well?
>>>>>
>>>>> The hardware on the ARM SoCs is different enough that I'm not sure the
>>>>> same binding will cover it.  That said, putting things under <arch>
>>>>> should be a last resort if nowhere else fits.
>>>>
>>>> OTC started ported the driver to the the ARM SoC and the feedback has
>>>> been that the driver needed minimal changes. The IOMMU has been the only
>>>> area of concern, and a small change to the binding has been suggested
>>>
>>> Do we need something in the binding to indicate device endianness?
>>
>> As I said, I didn't have enough exposure to the ARM SoC so I can't
>> answer that
>>
>>> If this binding is going to continue to be relevant to future DPAA
>>> generations, I think we really ought to deal with the possibility that
>>> there is more than one datapath instance
>>
>> I'm unsure how relevant this will be going forward. In LS2 B/QMan is
>> abstracted/hidden away behind the MC (firmware).
> 
> This is why I was wondering whether the binding would be at all the
> same...
> 
>>  I wouldn't over-engineer this without a clear picture of what multiple
>> data-paths per SoC even means at this point
> 
> I don't think it's over-engineering.  Assuming only one instance of
> something is generally sloppy engineering.  Linux doesn't need to
> actually pay attention to it until and unless it becomes necessary, but
> it's good to have the information in the device tree up front.

I asked around and the "multiple data-path SoC" seems to be at this
point a speculation. It seems unclear how would it work, what
requirements/problems it would address/solve, what programming interface
it would have. I'm not sure what do you suggest we do

In order to reduce the sloppiness of this binding. I'll add a
memory-region phandle to connect each B/QMan node to their
reserved-memory node

>>> by having phandles and/or a parent container to connect the related
>>> components.
>>
>> Connecting the related components is beyond the scope of this binding.
>> It will soon hit the e-mail list(s) as part of upstreaming the Ethernet
>> driver
> 
> So you want us to merge this binding without being told how this works?

This binding stands on its own and each block (B/QMan) can be used for
some useful purpose by itself. All other blocks/applications that use
the B/QMan use the same basic interface acquire/release a "buffer" and
enqueue/dequeue a "packet". I'm not sure what you feel I didn't share

> Or by "soon" do you mean before this binding is accepted?

No. The Ethernet driver, the QI SEC driver, RMan driver, etc. employ the
B/QMan and *other* hardware resources in some specific way. I don't
think their binding/drivers condition accepting the B/QMan binding/driver


Cheers,
