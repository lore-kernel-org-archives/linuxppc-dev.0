Return-Path: <wg@grandegger.com>
Message-ID: <478B18D9.6020201@grandegger.com>
Date: Mon, 14 Jan 2008 09:10:01 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: I2C and CAN bus on MPC5200B device tree
References: <478A967E.7080201@genesi-usa.com>
	<fa686aa40801131635o499c8c08i6a2667cd7df1a72e@mail.gmail.com>
In-Reply-To: <fa686aa40801131635o499c8c08i6a2667cd7df1a72e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 1/13/08, Matt Sealey <matt@genesi-usa.com> wrote:
>> Hi guys,
>>
>> I know the I2C stuff is up in the air (I cannot pinpoint the documentation
>> for it) and have not found any CAN bus documentation for device trees.
>>
>> I want to update the firmware tree to add these but, am basically looking
>> for those docs, or someone to go over a few points.. is there some kind of
>> tree standard I should be looking at, or some patch I missed which has
>> a driver which implements something that looks at a compatible tree?
> 
> I think some consensus has been achieved for describing i2c busses and
> their attached devices, but I don't think booting-without-of.txt has
> been updated with the details yet.  I need to look into that more.
> 
> I don't think anyone has tackled CAN.  Best bet is to draft a tree in
> the way you think it should be described and post it to the list.
> That will give a starting point for us to discuss it and come to
> consensus.

For MSCAN on the MPC5200 we currently have:

		mscan@900 {
			device_type = "mscan";
			compatible = "mpc5200b-mscan","mpc5200-mscan";
			cell-index = <0>;
			interrupts = <2 11 0>;
			interrupt-parent = <&mpc5200_pic>;
			reg = <900 80>;
		};

		mscan@980 {
			device_type = "mscan";
			compatible = "mpc5200b-mscan","mpc5200-mscan";
			cell-index = <1>;
			interrupts = <2 12 0>;
			interrupt-parent = <&mpc5200_pic>;
			reg = <980 80>;
		};

The only thing missing is a property defining the routing of the CAN
signals, CAN 1 on I2C1 pins or CAN 2 on TMR01 pins. I think it does not
make sense to describe CAN devices on the CAN bus like for I2C.

Wolfgang.
