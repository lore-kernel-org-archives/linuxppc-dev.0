Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B71B618.6020807@grandegger.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
	<1264685141-26391-3-git-send-email-wg@grandegger.com>
	<1264685141-26391-4-git-send-email-wg@grandegger.com>
	<fa686aa41002090950w2c3cd008k47784089dd3417d7@mail.gmail.com>
	<4B71AFFC.3010301@grandegger.com> <4B71B618.6020807@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 15:15:02 -0700
Message-ID: <fa686aa41002091415i1b1b722epe44a6ba52a7c066f@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] powerpc: doc/dts-bindings: update doc of FSL I2C
	bindings
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wolfgang Grandegger <wg@denx.de>, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 9, 2010 at 12:23 PM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Wolfgang Grandegger wrote:
>> Hi Grant,
>>
>> Grant Likely wrote:
>>> On Thu, Jan 28, 2010 at 6:25 AM, Wolfgang Grandegger <wg@grandegger.com=
> wrote:
>>>> From: Wolfgang Grandegger <wg@denx.de>
>>>>
>>>> This patch adds the MPC5121 to the list of supported devices,
>>>> enhances the doc of the "clock-frequency" property and removes
>>>> the obsolete "cell-index" property from the example nodes.
>>>> Furthermore and example for the MPC5121 has been added.
>>>>
>>>> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
>>> Thanks Wolfgang. =A0Comments below.
>>>
>>>> ---
>>>> =A0Documentation/powerpc/dts-bindings/fsl/i2c.txt | =A0 30 +++++++++++=
++++++++----
>>>> =A01 files changed, 24 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/powerpc/dts-bindings/fsl/i2c.txt b/Document=
ation/powerpc/dts-bindings/fsl/i2c.txt
>>>> index b6d2e21..2f62dae 100644
>>>> --- a/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>>>> +++ b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>>>> @@ -9,8 +9,9 @@ Recommended properties :
>>>>
>>>> =A0- compatible : compatibility list with 2 entries, the first should
>>>> =A0 =A0be "fsl,CHIP-i2c" where CHIP is the name of a compatible proces=
sor,
>>>> - =A0 e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The second =
one
>>>> - =A0 should be "fsl-i2c".
>>>> + =A0 e.g. mpc8313, mpc8543, mpc8544, mpc5121, mpc5200 or mpc5200b. Th=
e
>>>> + =A0 second one should be "fsl-i2c". For the mpc5121, an additional n=
ode
>>>> + =A0 "fsl,mpc5121-i2c-ctrl" is required as shown in the example below=
.
>>> While you're editing this line; drop the requirement for the second
>>> value to be 'fsl-i2c'. =A0We don't use it anymore, and only preserve it
>>> for backwards compatibility with old trees.
>>
>> OK.
>>
>>>> =A0- interrupts : <a b> where a is the interrupt number and b is a
>>>> =A0 =A0field that represents an encoding of the sense and level
>>>> =A0 =A0information for the interrupt. =A0This should be encoded based =
on
>>>> @@ -20,29 +21,46 @@ Recommended properties :
>>>> =A0 =A0services interrupts for this device.
>>>> =A0- fsl,preserve-clocking : boolean; if defined, the clock settings
>>>> =A0 =A0from the bootloader are preserved (not touched).
>>>> - - clock-frequency : desired I2C bus clock frequency in Hz.
>>>> + - clock-frequency : desired I2C bus clock frequency in Hz. =A0If thi=
s
>>>> + =A0 property and "fsl,preserve-clocking" is not defined, a safe fixe=
d
>>>> + =A0 clock divider value is used (resulting in a small clock frequenc=
y).
>>> Nah, leave this as is. =A0Don't make it sound like omitting both
>>> properties is a valid option. =A0The driver may (and should!) handle th=
e
>>> situation gracefully, but that fact does not need to be documented.
>>
>> The safe value is not a good choice, indeed. Then it will also change
>> MPC_I2C_CLOCK_SAFE to MPC_I2C_CLOCK_LEGACY in i2c-mpc.c.
>>
>> I will also fix the other issues you commented on.
>
> And I will also remove the "device_type" line from:
>
> =A0-------------
> =A0Required properties :
>
> =A0- device_type : Should be "i2c"
> =A0- reg : Offset and length of the register set for the device

Yes, please.

Hmmm.  compatible should also be in the 'required properties' section.

Thanks,
g.
