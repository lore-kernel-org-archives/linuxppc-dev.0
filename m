Return-Path: <guigasurf@gmail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82C3EB6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 08:26:14 +1000 (EST)
Received: by bkcjg15 with SMTP id jg15so4756686bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 15:26:10 -0700 (PDT)
MIME-Version: 1.0
Sender: guigasurf@gmail.com
Date: Tue, 12 Jun 2012 19:26:10 -0300
Message-ID: <CAF=5bWdZhORWR+eEWtL1BDgfYDvTH64Fq-=tPMn-aTWRGpwkOA@mail.gmail.com>
Subject: QUICC Engine USB Host controller
From: Guilherme Maciel Ferreira <guilherme.maciel.ferreira@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
Reply-To: guilherme.maciel.ferreira@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

I'm struggling to make the QUICC engine USB host controller to work.
Thus, I came here in the hope to get some light =3D)

I am working on MPC8321 processor and kernel 2.6.32. Comparing against
the mainstream version, I applied some patches to fix some p=C5=95oblems in
the FHCI driver, then it got running.

Now, it seems that the driver detects a new device, but is not able to
get its description. I'm aware that the driver uses the timer to
synchronize its packets exchange, but I couldn't find the proper timer
clock frequency. I've already tried every value I could derive from
the documentation, once as long as I am concerned there is no way to
measure it.

Here follows a relevant dmesg USB driver output, where there is a timeout e=
rror:

[   24.396373] usbcore: registered new interface driver usbfs
[   24.405860] usbcore: registered new interface driver hub
[   24.414642] usbcore: registered new device driver usb
[   24.706132] fsl,usb-fhci e01006c0.usb: at 0xcbaf66c0, irq 23
[   24.721953] fsl,usb-fhci e01006c0.usb: FHCI HOST Controller
[   24.734528] fsl,usb-fhci e01006c0.usb: new USB bus registered,
assigned bus number 1
[   24.745942] fsl,usb-fhci e01006c0.usb: irq 23, io mem 0x00000000
[   24.853738] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   24.860623] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[   24.867902] usb usb1: Product: FHCI HOST Controller
[   24.872836] usb usb1: Manufacturer: Linux 2.6.32 fsl,usb-fhci
[   24.878633] usb usb1: SerialNumber: e01006c0.usb
[   24.937686] usb usb1: configuration #1 chosen from 1 choice
[   24.957830] hub 1-0:1.0: USB hub found
[   24.968867] hub 1-0:1.0: 1 port detected
[   25.367766] usb 1-1: new full speed USB device using fsl,usb-fhci
and address 2
[   25.531795] usb 1-1: device descriptor read/64, error -110
[   25.787864] usb 1-1: device descriptor read/64, error -110
[   26.024464] usb 1-1: new full speed USB device using fsl,usb-fhci
and address 3
[   26.199736] usb 1-1: device descriptor read/64, error -110
[   26.455838] usb 1-1: device descriptor read/64, error -110
[   26.688100] usb 1-1: new full speed USB device using fsl,usb-fhci
and address 4
[   27.123765] usb 1-1: device not accepting address 4, error -110
[   27.271797] usb 1-1: new full speed USB device using fsl,usb-fhci
and address 5
[   27.712333] usb 1-1: device not accepting address 5, error -110
[   27.735892] hub 1-0:1.0: unable to enumerate USB device on port 1


And here follows a snippet from my device tree:

qe@e0100000 {
	#address-cells =3D <1>;
	#size-cells    =3D <1>;
	device_type =3D "qe";
	compatible =3D "fsl,qe";
	reg =3D <0xe0100000 0x480>;
	ranges =3D <0x0 0xe0100000 0x100000>;
	brg-frequency =3D <0>;
	bus-frequency =3D <0>;

	timer@440 {
		compatible =3D "fsl,mpc8321-qe-gtm",
			             "fsl,mpc8360-qe-gtm",
			             "fsl,qe-gtm", "fsl,gtm";
		reg =3D <0x440 0x40>; // 64 bytes @ offset 0x000440
		interrupts =3D <12 13 14 15>;
		interrupt-parent =3D <&qeic>;
		clock-frequency =3D <100000000>; // 100 MHz???
	};

	usb@6C0 {
		#address-cells =3D <1>;
		#size-cells    =3D <0>;
		compatible =3D "fsl,mpc8321-qe-usb",
			             "fsl,mpc8323-qe-usb",
			             "fsl,mpc8360-qe-usb";
		reg =3D <0x6c0 0x40 0x700 0x100>;
		interrupts =3D <11>;
		interrupt-parent =3D <&qeic>;
		mode =3D "host";
		fsl,fullspeed-clock =3D "clk3";
		hub-power-budget =3D "100";
		gpios =3D <
			&qe_pio_a  8 0	// USBOE
			&qe_pio_a  1 0	// USBTXP
			&qe_pio_a  0 0	// USBTXN
			&qe_pio_a  4 0	// USBRXP
			&qe_pio_a  5 0	// USBRXN
			&qe_pio_d 21 1	// SPEED
			&qe_pio_d 25 0	// POWER/SUSPEND
		>;
	};
};

Thanks in advance for anyone willing to help me.

Best regards,

--=20
Guilherme Maciel Ferreira
Site: http://guilhermemacielferreira.com/
