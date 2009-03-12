Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 7D6DEDDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 00:32:30 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so550034ywb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 06:32:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <44C5CFA72BC0E242A53B64DC1E67DEB80A695E6FE2@SI-MBX10.de.bosch.com>
References: <44C5CFA72BC0E242A53B64DC1E67DEB80A695E6FE2@SI-MBX10.de.bosch.com>
Date: Thu, 12 Mar 2009 07:32:28 -0600
Message-ID: <fa686aa40903120632yb46c34bxdecf21f01996bf42@mail.gmail.com>
Subject: Re: DTS device tree node for dual port RAM
From: Grant Likely <grant.likely@secretlab.ca>
To: "EXTERNAL Lange Matthias (AA-DGW/ENG1)" <Matthias.Lange@beissbarth.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2009 at 5:24 AM, EXTERNAL Lange Matthias (AA-DGW/ENG1)
<Matthias.Lange@beissbarth.com> wrote:
> Hi,
>
> I am working on a MPC5200-based board. There is a dual port RAM connected=
 to the MPC5200 via the localbus. In my setup one can raise an interrupt at=
 the MPC5200 to signal new that new data has arrived in the dual port RAM. =
I have already found out that the interrupt delivery actually works (do_IRQ=
 gets called when raising the interrupt).
>
> My problem is that my driver (kernel 2.6.24) can not register for the int=
errupt. Each time I call request_irq I get -ENOSYS. I am suspecting that I =
have done something wrong in my dts defining the dual port RAM. I have defi=
ned the device as follows
>
> localbus {
> =A0 =A0 =A0 =A0compatible =3D "fsl,orion-localbus",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,mpc5200-localbus",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,pq2-localbus";

This should be: compatible =3D "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple=
-bus";

It doesn't make much sense to claim compatibility with fsl,orion or
fsl,pq2 because the mpc5200 localbus is neither of those.

> =A0 =A0 =A0 =A0#address-cells =3D <2>;
> =A0 =A0 =A0 =A0#size-cells =3D <1>;
> =A0 =A0 =A0 =A0reg =3D <f0010100 40>;
> =A0 =A0 =A0 =A0ranges =3D <0 0 fe000000 00400000>;
>
> =A0 =A0 =A0 =A0dpram@40000000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "dpram";

Don't use device_type.  It doesn't make any sense in the flattened
device tree.  Use a compatible value instead, and prefix dpram with
the vendor and board name of the platform.  ie: compatible =3D
"<company>,<board>-dpram".  You should also document what this
compatible value means in Documentation/powerpc/device-tree/

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <0 0 0>;

What hardware irq# are you using?  See this link for a description of
what the interrupts property should look like for external IRQs:

http://patchwork.ozlabs.org/patch/11349/

To use this property, the irq_of_parse_and_map() function will
translate from the device tree to a Linux IRQ number.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&mpc5200_pic>;

You probably also want a reg =3D <0 0 0x00400000>; property for mapping
the address range.

> =A0 =A0 =A0 =A0};
> };
>
> What am I doing wrong? What am I missing?
>
> Thanks,
> Matthias Lange.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
