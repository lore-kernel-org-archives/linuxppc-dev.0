Return-Path: <robert.sciuk@exfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: P4080: attempting to use the uio_pdrv to attach FPGA on localbus ...
Date: Wed, 16 Nov 2011 16:19:51 -0500
Message-ID: <2DD52030B5146141BEB762A11AE97C4C010A0519@SPQCEXC05.exfo.com>
In-reply-to: <mailman.2323.1320874671.15294.devicetree-discuss@lists.ozlabs.org>
References: <mailman.2323.1320874671.15294.devicetree-discuss@lists.ozlabs.org>
From: "Robert Sciuk" <robert.sciuk@exfo.com>
To: <devicetree-discuss@lists.ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have succeeded in using the i2c bus with GPIO expander to access the =
programming pins of my FPGA devices, but the data port uses the =
localbus.  I had initially thought that the uio platform driver would be =
the ideal approach to creating a device which would allow configuration =
from userland via the /dev/uio[0|1] device interface, but apparently the =
device binding is not being accomplished as expected. =20

	localbus@ffe124000 {
		compatible =3D "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
		reg =3D <0xf 0xfe124000 0 0x1000>;
		interrupts =3D <25 2 0 0>;
		interrupt-parent =3D <&mpic>;
		#address-cells =3D <2>;
		#size-cells =3D <1>;

                /* Local bus region mappings */
                ranges =3D <0 0 0xf 0xe8000000 0x08000000 	/* CS0: Boot =
flash */
                          1 0 0xf 0xd0000000 0x8000 		/* CS1: FPGA0 */
                          2 0 0xf 0xd1000000 0x8000 >; 	/* CS2: FPGA1 */

		flash@0,0 {
		  ........
            };=20

		lim: fpga@1,0 {
			compatible =3D "uio_pdrv";
			pin-handle=3D<&lim_ctrl>;
		};=20

		nitro: fpga@2,0 {
			compatible =3D "uio_pdrv";
			pin-handle=3D<&fpe0_ctrl &fpe1_ctrl>;
		};=20
	};

I have aliases pointing to the localbus nodes lim and nitro, but it =
appears that the uio_pdrv driver does not bind to the device based upon =
the compatible property of the tree.  I'm hoping to be able to mmap the =
localbus port memory (0xf_d000_0000 and 0xf_d100_0000) respectively when =
I open /dev/uio[0|1].  Is there additional driver registration needed in =
order to use the uio_pdrv driver?  What am I missing??

Any pointers would be appreciated.

Cheers,
Rob
