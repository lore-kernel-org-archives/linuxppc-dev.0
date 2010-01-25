Return-Path: <nanda74pg@rediffmail.com>
Received: from rediffmail.com (f5mail-236-235.rediffmail.com [202.137.236.235])
	by ozlabs.org (Postfix) with SMTP id 8C9D11007D6
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 04:47:40 +1100 (EST)
Date: 25 Jan 2010 17:36:39 -0000
MIME-Version: 1.0
To: <scottwood@freescale.com>
Message-ID: <1264011072.S.5946.11312.f5mail-236-229.rediffmail.com.old.1264440999.19775@webmail.rediffmail.com>
Subject: =?utf-8?B?TkFORCAoVVBNKSAvIE5PUiBGbGFzaChHUENNKSBleGlzdGVuY2UgTVBDODMyeCBhbnkgaXNzdWU=?=
From: "nanda" <nanda74pg@rediffmail.com>
Content-Type: multipart/alternative;
	boundary="=_3bd8932bdc0333df43ad87cfda6c8476"
Cc: linuxppc-dev@ozlabs.org, avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=_3bd8932bdc0333df43ad87cfda6c8476
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"


Thanks for the information.

Based on your input, I could successfully update the dts file and gpio controller configuration. I verified from the GPIO chip intialized and added properly. But, still Iam getting the message as 
"No NAND device found!!!".

In our system we have two flash NOR connected thru GPCM and NAND device(STM Flash is NAND512W3A2C) connected using UPM.

NAND Flash starting address: fb000000(64 MB size)
NOR Flash starting address: fa000000 (16 MB size)

MPC8321E processor's port C, PIN 15 connected to the R/B PIN of NAND Flash.

Below are the dts file changes in mpc832x_rdb.dts 

DTS File changes:
---------------------------- 
qe_pio_c: gpio-controller@1430 {
#gpio-cells = ;
compatible = "fsl,mpc8360-qe-pario-bank",
"fsl,mpc8323-qe-pario-bank";
reg = ;
gpio-controller;
};
};
localbus@e0005000 {
#address-cells = ;
#size-cells = ;
compatible = "fsl,elbc","fsl-pq2pro-localbus","simple-bus" ;
reg = ;
interrupts = ;
interrupt-parent = < &pic >;

nand@fb000000 {
compatible = "fsl,upm-nand";
reg = ; /*64MB*/
fsl,upm-addr-offset = ;
fsl,upm-cmd-offset = ;

gpios = ;
flash {
compatible = "stm,nand512-a";
};
};
nor@fa000000 {
device_type = "rom";
compatible = "direct-mapped";
reg = ; /*16MB*/
probe-type = "CFI";
bank-width = ;
u-boot@0 {
label = "U-Boot";
reg = ; /* 512K */
read-only;
};
fw@80000 {
label = "UCC QE Firmware";
reg = ; /* 256K */
read-only;
};
dtb@c0000 {
label = "DTB";
reg = ; /* 256K */
read-only;
};
kernel@100000 {
label = "Kernel";
reg = ; /* 4M */
read-only;
};
fs@500000 {
label = "Root File System";
reg = ; /* 8M */
};
user@d00000 {
label = "User";
label = "User";
reg = ; /* 3M */
};
};
};

Please let me know if I missed out anything.

Regards,
Nanda





--=_3bd8932bdc0333df43ad87cfda6c8476
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

<br />
Thanks for the information.<br />
<br />
Based on your input, I could successfully update the dts file and gpio cont=
roller configuration. I verified from the GPIO chip intialized and added pr=
operly. But, still Iam getting the message as <br />
"No NAND device found!!!".<br />
<br />
In our system we have two flash NOR connected thru GPCM and NAND device(STM=
 Flash is NAND512W3A2C) connected using UPM.<br />
<br />
NAND Flash starting address: fb000000(64 MB size)<br />
NOR Flash starting address: fa000000 (16 MB size)<br />
<br />
MPC8321E processor's port C, PIN 15 connected to the R/B PIN of NAND Flash.=
<br />
<br />
Below are the dts file changes in mpc832x_rdb.dts <br />
<br />
DTS File changes:<br />
---------------------------- <br />
qe_pio_c: gpio-controller@1430 {<br />
#gpio-cells =3D <2>;<br />
compatible =3D "fsl,mpc8360-qe-pario-bank",<br />
"fsl,mpc8323-qe-pario-bank";<br />
reg =3D <1430 18>;<br />
gpio-controller;<br />
};<br />
};<br />
localbus@e0005000 {<br />
#address-cells =3D <1>;<br />
#size-cells =3D <1>;<br />
compatible =3D "fsl,elbc","fsl-pq2pro-localbus","simple-bus" ;<br />
reg =3D ;<br />
interrupts =3D <4d 8>;<br />
interrupt-parent =3D < &pic >;<br />
<br />
nand@fb000000 {<br />
compatible =3D "fsl,upm-nand";<br />
reg =3D ; /*64MB*/<br />
fsl,upm-addr-offset =3D <10>;<br />
fsl,upm-cmd-offset =3D <8>;<br />
<br />
gpios =3D <&qe_pio_c f 0>;<br />
flash {<br />
compatible =3D "stm,nand512-a";<br />
};<br />
};<br />
nor@fa000000 {<br />
device_type =3D "rom";<br />
compatible =3D "direct-mapped";<br />
reg =3D ; /*16MB*/<br />
probe-type =3D "CFI";<br />
bank-width =3D <2>;<br />
u-boot@0 {<br />
label =3D "U-Boot";<br />
reg =3D <0 00080000>; /* 512K */<br />
read-only;<br />
};<br />
fw@80000 {<br />
label =3D "UCC QE Firmware";<br />
reg =3D <00080000 00040000>; /* 256K */<br />
read-only;<br />
};<br />
dtb@c0000 {<br />
label =3D "DTB";<br />
reg =3D <000c0000 00040000>; /* 256K */<br />
read-only;<br />
};<br />
kernel@100000 {<br />
label =3D "Kernel";<br />
reg =3D <00100000 00400000>; /* 4M */<br />
read-only;<br />
};<br />
fs@500000 {<br />
label =3D "Root File System";<br />
reg =3D <00500000 00800000>; /* 8M */<br />
};<br />
user@d00000 {<br />
label =3D "User";<br />
label =3D "User";<br />
reg =3D <00d00000 00300000>; /* 3M */<br />
};<br />
};<br />
};<br />
<br />
Please let me know if I missed out anything.<br />
<br />
Regards,<br />
Nanda<br />
<br />
<br />
<br />
<br />
<br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadding=
=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;"><TR><td=
><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.rediffm=
ail.com/signatureline.htm@Middle?" target=3D"_blank"><IMG SRC=3D"http://sig=
ads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signatureli=
ne.htm@Middle"></A></td></TR></Table>
--=_3bd8932bdc0333df43ad87cfda6c8476--
