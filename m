Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 159CF1A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 08:32:17 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8D9D2140080
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2014 08:32:14 +1100 (AEDT)
Message-ID: <5452ADE0.1030709@Freescale.com>
Date: Thu, 30 Oct 2014 16:30:08 -0500
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
 <54526521.1090601@Freescale.com>
 <1414686590.23458.151.camel__44619.4786033176$1414686664$gmane$org@snotra.buserror.net>
 <54526B13.3010704@Freescale.com>
 <1414704371.23458.157.camel@snotra.buserror.net>
In-Reply-To: <1414704371.23458.157.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 corbet@lwn.net, Geoff.Thorpe@Freescale.com, ijc+devicetree@hellion.org.uk,
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


On 10/30/2014 04:26 PM, Scott Wood wrote:
> On Thu, 2014-10-30 at 11:45 -0500, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 10/30/2014 11:29 AM, Scott Wood wrote:
>>> On Thu, 2014-10-30 at 11:19 -0500, Emil Medve wrote:
>>>> Hello Scott,
>>>>
>>>>
>>>> On 10/30/2014 09:51 AM, Scott Wood wrote:
>>>>> On Wed, 2014-10-29 at 23:32 -0500, Emil Medve wrote:
>>>>>> Hello Scott,
>>>>>>
>>>>>>
>>>>>> On 10/29/2014 05:16 PM, Scott Wood wrote:
>>>>>>> On Wed, 2014-10-29 at 16:40 -0500, Emil Medve wrote:
>>>>>>>> Hello Scott,
>>>>>>>>
>>>>>>>>
>>>>>>>> On 10/28/2014 01:08 PM, Scott Wood wrote:
>>>>>>>>> On Tue, 2014-10-28 at 09:36 -0500, Kumar Gala wrote:
>>>>>>>>>> On Oct 22, 2014, at 9:09 AM, Emil Medve <Emilian.Medve@freescale.com> wrote:
>>>>>>>>>>
>>>>>>>>>>> The Buffer Manager is part of the Data-Path Acceleration Architecture (DPAA).
>>>>>>>>>>> BMan supports hardware allocation and deallocation of buffers belonging to
>>>>>>>>>>> pools originally created by software with configurable depletion thresholds.
>>>>>>>>>>> This binding covers the CCSR space programming model
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>>>>>>>>>>> Change-Id: I3ec479bfb3c91951e96902f091f5d7d2adbef3b2
>>>>>>>>>>> ---
>>>>>>>>>>> .../devicetree/bindings/powerpc/fsl/bman.txt       | 98 ++++++++++++++++++++++
>>>>>>>>>>> 1 file changed, 98 insertions(+)
>>>>>>>>>>> create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman.txt
>>>>>>>>>>
>>>>>>>>>> Should these really be in bindings/powerpc/fsl, aren’t you guys using this on ARM SoCs as well?
>>>>>>>>>
>>>>>>>>> The hardware on the ARM SoCs is different enough that I'm not sure the
>>>>>>>>> same binding will cover it.  That said, putting things under <arch>
>>>>>>>>> should be a last resort if nowhere else fits.
>>>>>>>>
>>>>>>>> OTC started ported the driver to the the ARM SoC and the feedback has
>>>>>>>> been that the driver needed minimal changes. The IOMMU has been the only
>>>>>>>> area of concern, and a small change to the binding has been suggested
>>>>>>>
>>>>>>> Do we need something in the binding to indicate device endianness?
>>>>>>
>>>>>> As I said, I didn't have enough exposure to the ARM SoC so I can't
>>>>>> answer that
>>>>>>
>>>>>>> If this binding is going to continue to be relevant to future DPAA
>>>>>>> generations, I think we really ought to deal with the possibility that
>>>>>>> there is more than one datapath instance
>>>>>>
>>>>>> I'm unsure how relevant this will be going forward. In LS2 B/QMan is
>>>>>> abstracted/hidden away behind the MC (firmware).
>>>>>
>>>>> This is why I was wondering whether the binding would be at all the
>>>>> same...
>>>>>
>>>>>>  I wouldn't over-engineer this without a clear picture of what multiple
>>>>>> data-paths per SoC even means at this point
>>>>>
>>>>> I don't think it's over-engineering.  Assuming only one instance of
>>>>> something is generally sloppy engineering.  Linux doesn't need to
>>>>> actually pay attention to it until and unless it becomes necessary, but
>>>>> it's good to have the information in the device tree up front.
>>>>
>>>> I asked around and the "multiple data-path SoC" seems to be at this
>>>> point a speculation. It seems unclear how would it work, what
>>>> requirements/problems it would address/solve, what programming interface
>>>> it would have. I'm not sure what do you suggest we do
>>>>
>>>> In order to reduce the sloppiness of this binding. I'll add a
>>>> memory-region phandle to connect each B/QMan node to their
>>>> reserved-memory node
>>>
>>> Thanks, that's the sort of thing I was looking for.  There should also
>>> be a connection from the portals to the relevant bqman node
>>
>> Nothing in the current programing model requires a portal to know its
>> B/QMan "parent". Should I add a phandle of sorts anyway?
> 
> Well, you at least have the requirement to initialize the qbman parent
> before using its portals, and you need to use the portals that go with
> the qbman instances that are connected to the device you want to
> access...
> 
>>> So there's no hardware connection between the bman and qman themselves?
>>
>> Not a single one
> 
> OK.  Please keep in mind that I haven't worked with this stuff as
> closely as you have. :-)

Huh? What do you mean?


Cheers,
