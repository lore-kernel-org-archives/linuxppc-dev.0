Return-Path: <wg@grandegger.com>
Message-ID: <4B71AFFC.3010301@grandegger.com>
Date: Tue, 09 Feb 2010 19:57:00 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 3/3] powerpc: doc/dts-bindings: update doc of FSL I2C
	bindings
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
	<1264685141-26391-3-git-send-email-wg@grandegger.com>
	<1264685141-26391-4-git-send-email-wg@grandegger.com>
	<fa686aa41002090950w2c3cd008k47784089dd3417d7@mail.gmail.com>
In-Reply-To: <fa686aa41002090950w2c3cd008k47784089dd3417d7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ben Dooks <ben-linux@fluff.org>, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> On Thu, Jan 28, 2010 at 6:25 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> From: Wolfgang Grandegger <wg@denx.de>
>>
>> This patch adds the MPC5121 to the list of supported devices,
>> enhances the doc of the "clock-frequency" property and removes
>> the obsolete "cell-index" property from the example nodes.
>> Furthermore and example for the MPC5121 has been added.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> 
> Thanks Wolfgang.  Comments below.
> 
>> ---
>>  Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +++++++++++++++++++----
>>  1 files changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/powerpc/dts-bindings/fsl/i2c.txt b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>> index b6d2e21..2f62dae 100644
>> --- a/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>> +++ b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>> @@ -9,8 +9,9 @@ Recommended properties :
>>
>>  - compatible : compatibility list with 2 entries, the first should
>>    be "fsl,CHIP-i2c" where CHIP is the name of a compatible processor,
>> -   e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The second one
>> -   should be "fsl-i2c".
>> +   e.g. mpc8313, mpc8543, mpc8544, mpc5121, mpc5200 or mpc5200b. The
>> +   second one should be "fsl-i2c". For the mpc5121, an additional node
>> +   "fsl,mpc5121-i2c-ctrl" is required as shown in the example below.
> 
> While you're editing this line; drop the requirement for the second
> value to be 'fsl-i2c'.  We don't use it anymore, and only preserve it
> for backwards compatibility with old trees.

OK.

>>  - interrupts : <a b> where a is the interrupt number and b is a
>>    field that represents an encoding of the sense and level
>>    information for the interrupt.  This should be encoded based on
>> @@ -20,29 +21,46 @@ Recommended properties :
>>    services interrupts for this device.
>>  - fsl,preserve-clocking : boolean; if defined, the clock settings
>>    from the bootloader are preserved (not touched).
>> - - clock-frequency : desired I2C bus clock frequency in Hz.
>> + - clock-frequency : desired I2C bus clock frequency in Hz.  If this
>> +   property and "fsl,preserve-clocking" is not defined, a safe fixed
>> +   clock divider value is used (resulting in a small clock frequency).
> 
> Nah, leave this as is.  Don't make it sound like omitting both
> properties is a valid option.  The driver may (and should!) handle the
> situation gracefully, but that fact does not need to be documented.

The safe value is not a good choice, indeed. Then it will also change
MPC_I2C_CLOCK_SAFE to MPC_I2C_CLOCK_LEGACY in i2c-mpc.c.

I will also fix the other issues you commented on.

Thanks,

Wolfgang.
