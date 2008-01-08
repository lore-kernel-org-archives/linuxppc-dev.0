Return-Path: <galak@kernel.crashing.org>
Message-Id: <026A8588-DC44-4EBB-885B-6D70117BF1A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <4A496992-9B46-427D-8F40-447E92F8CA3D@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] add MPC837x MDS board default device tree
Date: Mon, 7 Jan 2008 23:46:07 -0600
References: <1196851073-11801-1-git-send-email-leoli@freescale.com>
	<20071207020130.GA26412@localhost.localdomain>
	<4A496992-9B46-427D-8F40-447E92F8CA3D@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2007, at 2:12 AM, Kumar Gala wrote:

>
> On Dec 6, 2007, at 8:01 PM, David Gibson wrote:
>
>> On Wed, Dec 05, 2007 at 06:37:53PM +0800, Li Yang wrote:
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>> Update SATA nodes; remove serdes nodes; add aliases and labels.
>>>
>>> arch/powerpc/boot/dts/mpc8377_mds.dts |  270 +++++++++++++++++++++++
>>> ++++++++
>>> arch/powerpc/boot/dts/mpc8378_mds.dts |  256 +++++++++++++++++++++++
>>> ++++++
>>> arch/powerpc/boot/dts/mpc8379_mds.dts |  284 +++++++++++++++++++++++
>>> ++++++++++
>>> 3 files changed, 810 insertions(+), 0 deletions(-)
>>> create mode 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
>>> create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
>>> create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts
>>>
>>> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/
>>> boot/dts/mpc8377_mds.dts
>>> new file mode 100644
>>> index 0000000..919ffd0
>>> --- /dev/null
>>> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
>> [snip]
>>> +	aliases {
>>> +		ethernet0 = "/soc@e0000000/ethernet@24000";
>>> +		ethernet1 = "/soc@e0000000/ethernet@25000";
>>> +		serial0 = "/soc@e0000000/serial@4500";
>>> +		serial1 = "/soc@e0000000/serial@4600";
>>> +		pci0 = "/pci@e0008500";
>>
>> You can use path references for these now.
>>
>>> +	};
>>> +
>>> +	cpus {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		PowerPC,837x@0 {
>>
>> This should absolutely not have a "x" in it.  Either have an exact
>> model, or just use "cpu@9" (in which case you can put the model in
>> "compatible").
>>
>> [snip]
>>> +		i2c@3000 {
>>> +			device_type = "i2c";
>>
>> Drop the device_type.  No "i2c" device_type class is defined.
>>
>> [snip]
>>> +		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
>>> +		usb@23000 {
>>> +			device_type = "usb";
>>
>> Drop device_type here too.
>>
>>> +			compatible = "fsl-usb2-dr";
>>> +			reg = <23000 1000>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			interrupt-parent = < &ipic >;
>>> +			interrupts = <26 8>;
>>> +			phy_type = "utmi_wide";
>>> +		};
>>> +
>>> +		mdio@24520 {
>>> +			device_type = "mdio";
>>> +			compatible = "gianfar";
>>
>> Grr... not your fault, but this crap in the gianfar driver where it
>> uses the same compatible property for the mdio and MAC has to be
>> fixed.
>
> I've fixed this now.  Look at my tree/patch.
>
>> [snip]
>>
>>> +		serial1:serial@4600 {
>>
>> Standard style puts a space after the colon.
>>
>>> +			device_type = "serial";
>>> +			compatible = "ns16550";
>>> +			reg = <4600 100>;
>>> +			clock-frequency = <0>;
>>> +			interrupts = <a 8>;
>>> +			interrupt-parent = < &ipic >;
>>> +		};
>>> +
>>> +		crypto@30000 {
>>> +			model = "SEC3";
>>> +			compatible = "talitos";
>>
>> This driver, also, needs fixing to recognize a better formatted
>> compatible property.
>
> Can you respin with David's changes as well as mirror my cleanup of
> the other 83xx/85xx .dts


Any updates on new versions of the .dts for mpc837x?

- k
