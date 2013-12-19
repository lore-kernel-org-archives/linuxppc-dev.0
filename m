Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from mx.vmgattei.com (mx.vmgattei.com [77.223.18.35])
 by ozlabs.org (Postfix) with ESMTP id 714212C0078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 04:49:52 +1100 (EST)
Received: from localhost (mx.vmgattei.com [127.0.0.1])
 by mx.vmgattei.com (Postfix) with ESMTP id 4753822DF6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 18:49:48 +0100 (CET)
Received: from mx.vmgattei.com ([127.0.0.1])
 by localhost (mx.vmgattei.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sESAgems82d9 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 19 Dec 2013 18:49:48 +0100 (CET)
Message-ID: <52B331B7.8060606@sirius-es.it>
Date: Thu, 19 Dec 2013 18:49:43 +0100
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, agust@denx.de, Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH] powerpc/512x: dts: disable MPC5125 usb module
References: <1387448639-11050-1-git-send-email-matteo.facchinetti@sirius-es.it>
 <20131219123017.GM8064@book.gsilab.sittig.org>
In-Reply-To: <20131219123017.GM8064@book.gsilab.sittig.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/12/2013 13:30, Gerhard Sittig wrote:
> On Thu, Dec 19, 2013 at 11:23 +0100, Matteo Facchinetti wrote:
>> USB controller pin-muxing is not initialized correctly and when system boot,
>> causes a kernel panic.
>> USB controller is also connected with a USB3320 ulpi tranciever and
>> DTS should be includes the correct dependency for initialize and activate
>> this component.
>>
>> Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
>> ---
>>   arch/powerpc/boot/dts/mpc5125twr.dts | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts b/arch/powerpc/boot/dts/mpc5125twr.dts
>> index 806479f..85452a7 100644
>> --- a/arch/powerpc/boot/dts/mpc5125twr.dts
>> +++ b/arch/powerpc/boot/dts/mpc5125twr.dts
>> @@ -230,6 +230,9 @@
>>   		};
>>   
>>   		usb@3000 {
>> +			/* TODO correct pinmux config and fix USB3320 ulpi dependency */
>> +			status = "disabled";
>> +
>>   			compatible = "fsl,mpc5121-usb2-dr";
>>   			reg = <0x3000 0x400>;
>>   			#address-cells = <1>;
>> -- 
>> 1.8.3.2
> I agree on the change to the board dts file, but suggest to
> reword the commit description for improved reception.
>
> I feel it's worth trying to phrase the subject line, the commit
> message, and the patch such that they can get considered
> independently from each other, as not all of them are necessarily
> available at the same time.  Often they get looked up from
> different perspectives, like terse listing first for orientation,
> log with description then to determine whether to have a closer
> look, the patch only at the end after the other checks told you
> to look into more details.  Assuming that they always show up in
> combination may turn out to be inaccurate.
>
> So I suggest some text along those lines:
>
>    at the moment the USB controller's pin muxing is not setup
>    correctly and causes a kernel panic upon system startup, so
>    disable the USB1 device tree node in the MPC5125 tower board
>    dts file
>
>    the USB controller is connected to an USB3320 ULPI transceiver
>    and the device tree should receive an update to reflect correct
>    dependencies and required initialization data before the USB1
>    node can get re-enabled
>
> Does that sound correct to you?  Does it reflect your intention,
> or did I put something in wrong terms?

Yes, it's exactly what I tried to explain. All is right.
Now, I learned. Thank you.

> A minor nit would be that other reviewers in the past suggested
> to put the 'status = "disabled"' line last in the list of
> properties (right before optional children).  I don't have strong
> feelings about this.  Putting it first might better reflect your
> motivation of only re-enabling the node after fixing the lack or
> inappropriateness of existing information first.

I put it as first property because is very temporary and because is the 
most important information for the moment:
"the USB1 port doesn't works for these reasons...".

But, I think that if this property is usually at the and of the node 
list, it's better follow this suggestion.


Then I'll send a v2 patch with the newer description and with this change.

>
> A different matter is that I'd suggest to re-work the MPC5125
> device tree.  It recently escaped my attention because it did not
> share any information with the MPC5121 trees.  Comparing the
> MPC5125 board DTS with the MPC5121 DTS include file resulted in a
> lot of unnecessary "differences" that turned out to be whitespace
> or comment style only, or differences in the order of nodes.
> There were only few real differences in the information, and the
> MPC5125 device tree appears to only describe a subset of what the
> SoC actually contains.
>
> It may be worth looking into
> - identifying common parts that are shared among the MPC5121 and
>    MPC5125 (my recent CCF update lists differences, but does not
>    explicitly list similarities, and is from the clocks
>    perspective and may not cover all of the SoC components)
> - putting those common parts into .dtsi files if possible
> - making the MPC5125 tower board reference the DTS includes,
>    sharing as much as possible with the other SoC variants
>
> This may involve another split of the mpc5121.dtsi into what's
> common to all MPC512x variants, and what's exclusive to MPC5121
> only.
>
> But that is a bigger task than the above quick adjustment, and is
> not a required fix but just an improvement in maintainability or
> completeness of information.  So I suggest to pick your USB1
> disabling for -next and 3.14 now, and to address the DTS cleanup
> and sharing later.

It was from the first commit of mpc5125twr.dts file that I would have 
liked to rework all mpc5xxx DTS tree.
At the moment I have already started this task but it's better to open 
another thread for this discussion and I agree with you that it's not a 
priority.

Now, I'm working to the NFC controller and I'm porting to linux 3.13 the 
driver that we are using in linux 3.9.4.
When I done a preliminary version I'll post for starting a discussion 
about its correct integration.

I think it's time to add this driver in mainline for use NFC as well.

Best regards,
Matteo Facchinetti
