Return-Path: <prvs=09166d1b57=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpW302RG4zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 00:38:03 +1000 (AEST)
Subject: Re: [PATCH] powerpc: define the fman node for the kmcoge4 DTS
To: Scott Wood <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <1459949825-10533-1-git-send-email-valentin.longchamp@keymile.com>
 <1459979380.32510.75.camel@buserror.net> <5705FAD3.40106@keymile.com>
 <1460857751.32510.175.camel@buserror.net>
From: Valentin Longchamp <valentin.longchamp@keymile.com>
Message-ID: <5714F144.4060909@keymile.com>
Date: Mon, 18 Apr 2016 16:37:56 +0200
MIME-Version: 1.0
In-Reply-To: <1460857751.32510.175.camel@buserror.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/04/16 03:49, Scott Wood wrote:
> On Thu, 2016-04-07 at 08:14 +0200, Valentin Longchamp wrote:
>> On 06/04/16 23:49, Scott Wood wrote:
>>> On Wed, 2016-04-06 at 15:37 +0200, Valentin Longchamp wrote:
>>>> Now that the FMAN mac driver has been merged the fman node is relevant.
>>>>
>>>> The kmcoge4 board implements 3 ethernet interfaces, 1 with a RGMII phy
>>>> and 2 with fixed 1 Giga SGMII links.
>>>>
>>>> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
>>>> ---
>>>>  arch/powerpc/boot/dts/fsl/kmcoge4.dts | 39
>>>> +++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 39 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
>>>> b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
>>>> index 6858ec9..1cec66d 100644
>>>> --- a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
>>>> +++ b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
>>>> @@ -106,6 +106,45 @@
>>>>  		sata@221000 {
>>>>  			status = "disabled";
>>>>  		};
>>>> +
>>>> +		fman0: fman@400000 {
>>>> +			enet0: ethernet@e0000 {
>>>> +				phy-connection-type = "sgmii";
>>>> +				local-mac-address = [00 11 22 33 44
>>>> 55];
>>>> +				fixed-link {
>>>> +					speed = <1000>;
>>>> +					full-duplex;
>>>> +				};
>>>> +			};
>>>> +			mdio0: mdio@e1120 {
>>>> +				front_phy: ethernet-phy@11 {
>>>> +					reg = <0x11>;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			enet1: ethernet@e2000 {
>>>> +				phy-connection-type = "sgmii";
>>>> +				local-mac-address = [00 11 22 33 44
>>>> 56];
>>>> +				fixed-link {
>>>> +					speed = <1000>;
>>>> +					full-duplex;
>>>> +				};
>>>> +			};
>>>
>>> No hardcoded MAC addresses.
>>>
>>
>> For these 2 interfaces where I have the local-mac-address field, the MAC
>> addresses are set later by an application that reads the real address in
>> some
>> EEPROM. However, in order to let the fman mac_probe to run successfully in
>> the
>> first place I have set non-zero MAC addresses since the local-mac-address
>> fields
>> are not set by u-boot.
> 
> Why can't it be set from U-Boot?

It can and should be set from u-boot. It's an old leftover from the vxworks time
where all the MAC addresses where set from the vxworks application itself. When
the company migrated to embedded Linux, they only implemented setting the MAC
address for the "debug" Ethernet interface in u-boot (for NFS boot). The other
were still controlled by the application after the Kernel boot and since then it
has remained so.

I will write this down on the (long) list of remaining vxworks migration cleanups.

> 
> If you absolutely must hardcode a mac address, use one with the locally
> -administered bit set (0x02 in the first byte).

I don't think this is necessary. As you hinted above, the correct way would be
to set them from u-boot and there is nothing that would prevent it other than
actually implementing it (u-boot actually has access to the MAC-address list of
the board).

I send a v2 patch without these fields.

> 
>> I have found several local-mac-address fields in other DTS files that are
>> all
>> zeros, and thus are rejected by of_get_mac_address. Are they leftovers from
>> the
>> past or should they be used here as well ? If not, I will simply drop these
>> 2
>> fields.
> 
> That's a relic from ancient U-Boots that could only overwrite existing
> properties rather than insert them from scratch.
> 

OK, interesting to know, thanks for the explanation.

Valentin
