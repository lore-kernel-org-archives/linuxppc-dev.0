Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH v11 5/6] flexcan: Prefer device tree clock frequency if
	available.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E4400CC.3020704@pengutronix.de>
Date: Thu, 11 Aug 2011 12:40:03 -0500
Message-Id: <1BE7ECA1-8E3D-4750-9DC7-0FABC1B6E545@kernel.crashing.org>
References: <1313078831-2511-1-git-send-email-holt@sgi.com>
	<1313078831-2511-6-git-send-email-holt@sgi.com>
	<4E4400CC.3020704@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>,
	Robin Holt <holt@sgi.com>, Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 11, 2011, at 11:18 AM, Marc Kleine-Budde wrote:

> On 08/11/2011 06:07 PM, Robin Holt wrote:
>> If our CAN device's device tree node has a clock-frequency property,
>> then use that value for the can devices clock frequency.  If not, =
fall
>> back to asking the platform/mach code for the clock frequency =
associated
>> with the flexcan device.
>=20
> nitpicking follows inline:
>=20
>> Signed-off-by: Robin Holt <holt@sgi.com>
>> To: Kumar Gala <galak@kernel.crashing.org>
>> To: Wolfgang Grandegger <wg@grandegger.com>,
>> To: Marc Kleine-Budde <mkl@pengutronix.de>,
>> To: U Bhaskar-B22300 <B22300@freescale.com>
>> To: Scott Wood <scottwood@freescale.com>
>> To: Grant Likely <grant.likely@secretlab.ca>
>> Cc: socketcan-core@lists.berlios.de,
>> Cc: netdev@vger.kernel.org,
>> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
>> Cc: devicetree-discuss@lists.ozlabs.org
>> ---
>> .../devicetree/bindings/net/can/fsl-flexcan.txt    |    2 +
>> drivers/net/can/flexcan.c                          |   33 =
+++++++++++++++-----
>> 2 files changed, 27 insertions(+), 8 deletions(-)
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt =
b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
>> index c78dcbb..a4382c7 100644
>> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
>> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
>> @@ -11,6 +11,7 @@ Required properties:
>>=20
>> - reg : Offset and length of the register set for this device
>> - interrupts : Interrupt tuple for this device
>> +- clock-frequency : The oscillator frequency driving the flexcan =
device
>>=20
>> Example:
>>=20
>> @@ -19,4 +20,5 @@ Example:
>>           reg =3D <0x1c000 0x1000>;
>>           interrupts =3D <48 0x2>;
>>           interrupt-parent =3D <&mpic>;
>> +          clock-frequency =3D <0x0bebc1fc>;
>=20
> Does the device tree support dec coded integers? IMHO a frequency is
> best expressed in decimal.

Yes it does, and agree that in the example a dec # might be better

- k=
