Message-ID: <009601c134d5$4bc7aca0$b300000a@foolio1>
From: "Eli Chen" <eli@routefree.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	"Alexander Kolesnikov" <akolesni@qualcomm.com>
References: <4.2.2.20010830111127.02d754d0@qisrael.qi.qualcomm.com>
Subject: Re: USB support in the HardHet Linux 2.4.2 on the IBM Walnut
Date: Mon, 3 Sep 2001 17:05:24 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0093_01C1349A.9F440E90"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0093_01C1349A.9F440E90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Alexander,

We have managed to get the USB ohci driver to work on the Walnut board.  I
believe one of the problems was that the 405gp platform did not guarantee
cache coherency for pci-dma.  This is supposedly fixed by patches
ohci-0323*.patch and pcipool patches (you can find on usb-devel mailing
list).

That didn't improve things at all.  Then I discovered that cache invalidates
were happening on addresses not aligned with the 405gp cacheline.  This
junked some good data, and I fixed it by using kmalloc'ed memory for dma and
aligning end addresses manually.  I also have a fix for the Pegasus ethernet
dongle (other drivers probably have to be patched as well.)

The code uses a macro called L1_CACHE_ALIGN:
#define L1_CACHE_ALIGN(x)
(((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))

where L1_CACHE_BYTES is 32 for 405gp.


hope this helps!  sorry if it's too messy.  I'll try to help more if I can.

Eli

----- Original Message -----
From: "Alexander Kolesnikov" <akolesni@qualcomm.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, August 30, 2001 2:19 AM
Subject: USB support in the HardHet Linux 2.4.2 on the IBM Walnut


>
> Hi All,
>
> We have problems with different USB chips on the Walnut board:
>
> 1.Using of a OHCI chip causes to kernel crash. This problem is famous but
> we really need to know whether does any "on the shelf" solution for the
> particular case exist.
>
> 2.When a UHCI chip is used, the USB device connecting to it causes to the
> following error messages:
>
> usb_control/buk_msg:timeout
> usb.c:USB device not accepting new address = XX (error=-110)
>
> The used USB hubs and devices work properly with another OS on the PC
> platform.
>
> Thanks in advance.
>
>

------=_NextPart_000_0093_01C1349A.9F440E90
Content-Type: application/octet-stream;
	name="usb.h.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="usb.h.patch"

Index: usb.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/routefree/depot/rf/src/hr/linux/include/linux/usb.h,v=0A=
retrieving revision 1.1.1.2=0A=
retrieving revision 1.2=0A=
diff -r1.1.1.2 -r1.2=0A=
599,600c599,604=0A=
< 	struct usb_device_descriptor descriptor;/* Descriptor */=0A=
< 	struct usb_config_descriptor *config;	/* All of the configs */=0A=
---=0A=
> 	/* The reason for the alignment is that we're DMA-ing the descriptor =
struct,=0A=
> 	 * and we want to make sure when the cacheline is invalidated it =
doesn't clobber=0A=
> 	 * any data also in the cacheline, since the descriptor is only 18 =
bytes.=0A=
> 	 */=0A=
> 	struct usb_device_descriptor __attribute__ =
((aligned(L1_CACHE_BYTES))) descriptor;/* Descriptor */=0A=
> 	struct usb_config_descriptor __attribute__ =
((aligned(L1_CACHE_BYTES))) *config;	/* All of the configs */=0A=

------=_NextPart_000_0093_01C1349A.9F440E90
Content-Type: application/octet-stream;
	name="usb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="usb.patch"

Index: pegasus.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/routefree/depot/rf/src/hr/linux/drivers/usb/pegasus.c,v=0A=
retrieving revision 1.2=0A=
retrieving revision 1.6=0A=
diff -r1.2 -r1.6=0A=
54,55c54,55=0A=
< #define	PEGASUS_USE_INTR=0A=
< #define	PEGASUS_WRITE_EEPROM=0A=
---=0A=
> #undef PEGASUS_USE_INTR=0A=
> #undef PEGASUS_WRITE_EEPROM=0A=
126a127=0A=
> 	unsigned char *buffer;=0A=
128a130,136=0A=
> 	buffer =3D kmalloc(L1_CACHE_ALIGN(size),GFP_KERNEL);=0A=
> 	if (!buffer) {=0A=
>                 err("unable to allocate memory for configuration =
descriptors");=0A=
>                 return 0;=0A=
>         }=0A=
> 	memcpy(buffer,data,size);=0A=
> 	=0A=
143c151=0A=
< 			  data, size, ctrl_callback, pegasus );=0A=
---=0A=
> 			  buffer, L1_CACHE_ALIGN(size), ctrl_callback, pegasus );=0A=
156a165,166=0A=
> 	memcpy(data,buffer,size);=0A=
> 	kfree(buffer);=0A=
163a174=0A=
>         unsigned char *buffer;=0A=
165a177,183=0A=
>         buffer =3D kmalloc(size,GFP_KERNEL);=0A=
>         if (!buffer) {=0A=
>                 err("unable to allocate memory for configuration =
descriptors");=0A=
>                 return 0;=0A=
>         }=0A=
>         memcpy(buffer,data,size);=0A=
> =0A=
180c198=0A=
< 			  data, size, ctrl_callback, pegasus );=0A=
---=0A=
> 			  buffer, size, ctrl_callback, pegasus );=0A=
187a206=0A=
> 		kfree(buffer);=0A=
193a213=0A=
> 	kfree(buffer);=0A=
200a221=0A=
>         unsigned char *buffer;=0A=
203a225,231=0A=
>         buffer =3D kmalloc(1,GFP_KERNEL);=0A=
>         if (!buffer) {=0A=
>                 err("unable to allocate memory for configuration =
descriptors");=0A=
>                 return 0;=0A=
>         }=0A=
>         memcpy(buffer,&data,1);=0A=
> =0A=
218c246=0A=
< 			  &data, 1, ctrl_callback, pegasus );=0A=
---=0A=
> 			  buffer, 1, ctrl_callback, pegasus );=0A=
225a254=0A=
> 		kfree(buffer);=0A=
231a261=0A=
> 	kfree(buffer);=0A=
Index: usb.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/routefree/depot/rf/src/hr/linux/drivers/usb/usb.c,v=0A=
retrieving revision 1.2=0A=
retrieving revision 1.5=0A=
diff -r1.2 -r1.5=0A=
1772c1772=0A=
< 				     sizeof(dev->descriptor));=0A=
---=0A=
> 				     L1_CACHE_ALIGN(sizeof(dev->descriptor)));=0A=
1789a1790=0A=
> 	unsigned char *buffer;=0A=
1792a1794,1799=0A=
> 	buffer =3D kmalloc(L1_CACHE_ALIGN(1), GFP_KERNEL);=0A=
> 	if (!buffer) {=0A=
> 		err("unable to allocate memory for configuration descriptors");=0A=
> 		return -ENOMEM;=0A=
> 	}=0A=
> =0A=
1795c1802,1803=0A=
< 	    0, ifnum, &type, 1, HZ * GET_TIMEOUT)) < 0)=0A=
---=0A=
> 	    0, ifnum, buffer, L1_CACHE_ALIGN(1), HZ * GET_TIMEOUT)) < 0) {=0A=
> 		kfree(buffer);=0A=
1796a1805,1808=0A=
> 	}=0A=
> =0A=
> 	type =3D *buffer;=0A=
> 	kfree(buffer);=0A=
1851a1864=0A=
> 	unsigned char *buffer;=0A=
1865a1879,1884=0A=
> 	buffer =3D kmalloc(L1_CACHE_ALIGN(sizeof(status)), GFP_KERNEL);=0A=
>         if (!buffer) {=0A=
>                 err("unable to allocate memory for configuration =
descriptors");=0A=
>                 return -ENOMEM;=0A=
>         }=0A=
> =0A=
1868c1887,1891=0A=
< 		&status, sizeof(status), HZ * SET_TIMEOUT);=0A=
---=0A=
> 		buffer, L1_CACHE_ALIGN(sizeof(status)), HZ * SET_TIMEOUT);=0A=
> =0A=
> 	memcpy(&status,buffer,sizeof(status));=0A=
> 	kfree(buffer);=0A=
> =0A=
1953c1976=0A=
< 	unsigned char buffer[8];=0A=
---=0A=
> 	unsigned char *buffer;=0A=
1955,1956c1978=0A=
< 	struct usb_config_descriptor *desc =3D=0A=
< 		(struct usb_config_descriptor *)buffer;=0A=
---=0A=
>  	struct usb_config_descriptor *desc;=0A=
1984a2007,2013=0A=
> 	buffer =3D kmalloc(L1_CACHE_ALIGN(8), GFP_KERNEL);=0A=
> 	if (!buffer) {=0A=
> 		err("unable to allocate memory for configuration descriptors");=0A=
>                 return -ENOMEM;=0A=
> 	}=0A=
> 	desc =3D (struct usb_config_descriptor *)buffer;=0A=
> =0A=
1988c2017=0A=
< 		result =3D usb_get_descriptor(dev, USB_DT_CONFIG, cfgno, buffer, 8);=0A=
---=0A=
> 		result =3D usb_get_descriptor(dev, USB_DT_CONFIG, cfgno, buffer, =
L1_CACHE_ALIGN(8));=0A=
2002c2031=0A=
< 		bigbuffer =3D kmalloc(length, GFP_KERNEL);=0A=
---=0A=
> 		bigbuffer =3D kmalloc(L1_CACHE_ALIGN(length), GFP_KERNEL);=0A=
2010c2039=0A=
< 		result =3D usb_get_descriptor(dev, USB_DT_CONFIG, cfgno, bigbuffer, =
length);=0A=
---=0A=
> 		result =3D usb_get_descriptor(dev, USB_DT_CONFIG, cfgno, bigbuffer, =
L1_CACHE_ALIGN(length));=0A=
2034a2064=0A=
> 	kfree(buffer);=0A=
2036a2067=0A=
> 	kfree(buffer);=0A=
2131c2162=0A=
< 	err =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0, &dev->descriptor, =
8);=0A=
---=0A=
> 	err =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0, &dev->descriptor, =
L1_CACHE_ALIGN(8));=0A=
Index: hub.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/routefree/depot/rf/src/hr/linux/drivers/usb/hub.c,v=0A=
retrieving revision 1.2=0A=
retrieving revision 1.3=0A=
diff -r1.2 -r1.3=0A=
128a129=0A=
>         unsigned char *buffer;=0A=
194c195,204=0A=
< 	ret =3D usb_get_hub_status(dev, &hubstatus);=0A=
---=0A=
>         buffer =3D kmalloc(sizeof(struct usb_hub_status),GFP_KERNEL);=0A=
> 	if (!buffer) {=0A=
>                 err("unable to allocate memory for configuration =
descriptors");=0A=
>                 kfree(hub->descriptor);=0A=
>                 return -1;=0A=
>         }=0A=
>         memcpy(buffer,&hubstatus,sizeof(struct usb_hub_status));=0A=
> 	ret =3D usb_get_hub_status(dev,buffer);=0A=
>         memcpy(&hubstatus,buffer,sizeof(struct usb_hub_status));=0A=
>         kfree(buffer);=0A=
446a457=0A=
>         unsigned char *buffer;=0A=
453c464,474=0A=
< 		ret =3D usb_get_port_status(hub, port + 1, &portsts);=0A=
---=0A=
>                 buffer =3D kmalloc(sizeof(struct =
usb_hub_status),GFP_KERNEL);=0A=
>                 if (buffer) {=0A=
>                     memcpy(buffer,&portsts,sizeof(struct =
usb_hub_status));=0A=
>                     ret =3D usb_get_port_status(hub, port + 1, buffer);=0A=
>                     memcpy(&portsts,buffer,sizeof(struct =
usb_hub_status));=0A=
>                     kfree(buffer);=0A=
>                 } else {=0A=
>                     err("unable to allocate memory for configuration =
descriptors");=0A=
>                     ret =3D -1;=0A=
>                 }=0A=
> =0A=
643a665,666=0A=
>         unsigned char *buffer;=0A=
>         int temp_ret;=0A=
687c710,720=0A=
< 			ret =3D usb_get_port_status(dev, i + 1, &portsts);=0A=
---=0A=
>                         buffer =3D kmalloc(sizeof(struct =
usb_hub_status),GFP_KERNEL);=0A=
>                         if (buffer) {=0A=
>                             memcpy(buffer,&portsts,sizeof(struct =
usb_hub_status));=0A=
>                             ret =3D usb_get_port_status(dev, i + 1, =
buffer);=0A=
>                             memcpy(&portsts,buffer,sizeof(struct =
usb_hub_status));=0A=
>                             kfree(buffer);=0A=
>                         } else {=0A=
>                             err("unable to allocate memory for =
configuration descriptors");=0A=
>                             ret =3D -1;=0A=
>                         }=0A=
> =0A=
733a767,777=0A=
>                 buffer =3D kmalloc(sizeof(struct =
usb_hub_status),GFP_KERNEL);=0A=
>                 if (buffer) {=0A=
>                     memcpy(buffer,&hubsts,sizeof(struct =
usb_hub_status));=0A=
>                     temp_ret =3D usb_get_hub_status(dev, buffer);=0A=
>                     memcpy(&hubsts,buffer,sizeof(struct =
usb_hub_status));=0A=
>                     kfree(buffer);=0A=
>                 } else {=0A=
>                     err("unable to allocate memory for configuration =
descriptors");=0A=
>                     temp_ret =3D -1;=0A=
>                 }=0A=
> =0A=
735c779=0A=
< 		if (usb_get_hub_status(dev, &hubsts) < 0)=0A=
---=0A=
> 		if (temp_ret < 0)=0A=
Index: usb-ohci.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/routefree/depot/rf/src/hr/linux/drivers/usb/usb-ohci.h,v=0A=
retrieving revision 1.2=0A=
retrieving revision 1.3=0A=
diff -r1.2 -r1.3=0A=
60c60=0A=
< } __attribute((aligned(16)));=0A=
---=0A=
> } __attribute((aligned(L1_CACHE_BYTES)));=0A=
118c118=0A=
< } __attribute((aligned(16)));=0A=
---=0A=
> } __attribute((aligned(L1_CACHE_BYTES)));=0A=
561c561=0A=
< 		16 /* byte alignment */,=0A=
---=0A=
> 		L1_CACHE_BYTES /* byte alignment */,=0A=
568c568=0A=
< 		16 /* byte alignment */,=0A=
---=0A=
> 		L1_CACHE_BYTES /* byte alignment */,=0A=

------=_NextPart_000_0093_01C1349A.9F440E90--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
