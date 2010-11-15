Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20101115212432.GA17754@oksana.dev.rtsoft.ru>
References: <1289841916-3825-1-git-send-email-w.sang@pengutronix.de>
	<1289841916-3825-2-git-send-email-w.sang@pengutronix.de>
	<20101115173250.GA22104@oksana.dev.rtsoft.ru>
	<4CE1A0E4.5030505@firmworks.com>
	<20101115212432.GA17754@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 15 Nov 2010 14:58:51 -0700
Message-ID: <AANLkTi=H_zONah7YuKSffkGrSiGa+7-LSbXE+qO=86Zj@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: pcm030/032: add pagesize to dts
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mitch Bradley <wmb@firmworks.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2010 at 2:24 PM, Anton Vorontsov <cbouatmailru@gmail.com> w=
rote:
> On Mon, Nov 15, 2010 at 11:06:44AM -1000, Mitch Bradley wrote:
> [...]
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eeprom@52 {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D=
 "catalyst,24c32";
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D<0x52>;
>> >>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pagesize =3D<32>=
;
>> >
>> >I think you'd better drop the pagesize property altogether, and
>> >instead make the compatible string more specific (if needed at
>> >all. are there any 'catalyst,24c32' chips with pagesize !=3D 32?)
>>
>> Microchip makes a 24c32 part that looks pretty similar to the
>> catalyst part, but Microchip's has a 64-byte page size compared to
>> Catalyst's 32.
>
> Well, when using microchip part, the compatible string would be
> "microchip,24c32", correct? Then we have all the information
> already, no need for the pagesize.
>
>> It would probably be feasible to have a generic I2C EEPROM driver
>> that could handle many different parts, parameterized by total size,
>> block size, and page size.

The current at24.c driver is already parameterized; but part of the
parameter data is statically linked into the board support code.

>
> I guess it can do this already via I2C ID table. The problem
> is that I2C core is only using part ID (no vendor ID matching).

This could potentially be changed for at24 devices since the i2c
subsystem already matches by name.  It would mean adding the vendor
prefix to all instantiations of the device in the kernel, although it
would mess up the current heuristic used by of_modalias_node() (not a
show-stopper).

>
> So, the current driver may just implement quirks like this:
>
> if (of_device_is_compatible(np, "catalyst,24c32"))
> =A0 =A0 =A0 =A0pagesize =3D 32;
>
> Or, if it's some generic pattern, something like
>
> if (of_device_is_compatible_vendor(np, "catalyst"))
> =A0 =A0 =A0 =A0pagesize /=3D 2;

This would get ugly in a hurry.  It would be better to make it data
driven by searching for a better match in an of_device_id table so
that the workarounds don't grow over time and eventually achieve
sentience.

g.
