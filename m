Return-Path: <B07421@freescale.com>
Message-ID: <502AC0B0.5030801@freescale.com>
Date: Tue, 14 Aug 2012 16:18:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/mpic: Add Open-PIC global timer document
References: <1344578002-8057-1-git-send-email-Dongsheng.wang@freescale.com>
 <50255F49.5050500@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB1450@039-SN2MPN1-022.039d.mgd.msft.net>
 <50293BEA.90401@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB1A08@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259DB1A08@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/13/2012 09:40 PM, Wang Dongsheng-B40534 wrote:
>>>> +Example 2:
>>>>> +
>>>>> +	timer: timer@010f0 {
>>>>> +		compatible = "open-pic,global-timer";
>>>>> +		device_type = "open-pic";
>>>>> +		reg = <0x010f0 4 0x01100 0x100>;
>>>>> +		interrupts = <0 0 3 0
>>>>> +			      1 0 3 0
>>>>> +			      2 0 3 0
>>>>> +		              3 0 3 0>;
>>>>> +	};
>>>>
>>>> 4-cell interrupt specifiers are specific to Freescale MPICs.  This
>>>> means there's no way to describe the timer interrupt on a non-
>> Freescale openpic.
>>>> Again, I suggest we not bother with this in the absence of an actual
>>>> need to support the timer on non-Freescale openpic in partitioned
>> scenarios.
>>>> The existing openpic node is sufficient to describe the
>>>> hardware in the absence of partitioning.   We could have an
>>>> "openpic-no-timer" property to indicate that we're describing it
>>>> separately, so that the absence of a timer node isn't ambiguous as to
>>>> whether it's an old tree or a partitioned scenario.  An fsl,mpic
>>>> compatible would imply openpic-no-timer.
>>>>
>>>> Note that I believe many of the non-Freescale openpic nodes are going
>>>> to be found on systems with real Open Firmware, so we can't go
>>>> changing the device tree for them.
>>> [Wang Dongsheng] In the Open-PIC specification, there are four timer.
>>> 		interrupts = <0 0 3 0
>>> 			      1 0 3 0
>>> 			      2 0 3 0
>>> 		              3 0 3 0>;
>>>
>>> The "interrupts" just let user know there are four timers. Usage based
>> "interrupts"
>>> binding to change dts.
>>
>> I can't understand the above or how it's a response to what I wrote.
>>
> [Wang Dongsheng] I mean this just to tell how many timers to support in Open-PIC
> specification. If someone needs to write "interrupts" into dts, this must comply
> with the specification of the interrupt to write. this is based on the pic driver
> should be changed in different platforms.

My point (beyond that examples provided should be valid for *some*
system) is there is no valid thing to put in the interrupts property
here when the interrupt controller is not "fsl,mpic", so this doesn't work.

-Scott
