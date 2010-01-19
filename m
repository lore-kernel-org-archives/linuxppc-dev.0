Return-Path: <nanda74pg@rediffmail.com>
Received: from rediffmail.com (f5mail-237-237.rediffmail.com [202.137.237.237])
	by ozlabs.org (Postfix) with SMTP id 2B689B7C98
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 23:51:04 +1100 (EST)
Date: 19 Jan 2010 12:40:14 -0000
Message-ID: <20100119124014.22519.qmail@f5mail-237-237.rediffmail.com>
MIME-Version: 1.0
To: <wg@grandegger.com>, <avorontsov@ru.mvista.com>
Subject: =?utf-8?B?ZnNsIHVwbSBOQU5EIEZsYXNoIGlzc3VlIHdpdGhvdXQgR1BJTyBjaGlwIGhhbmRsZXI=?=
From: "nanda" <nanda74pg@rediffmail.com>
Content-Type: multipart/alternative;
	boundary="=_c9eee608535d82e8c16d9284918b0e96"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=_c9eee608535d82e8c16d9284918b0e96
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"


  We had merged the 2.6.24 with the FSL based NAND driver, we observed that gpio library is mandatory to be included. We have not included the gpios configured in the dts file as the we don’t have the separate GPIO chip(arch/powepc/boot/dts/board.dts). 
 After executing the image in the board, we observed the below
1)	The device ID and manufacture Id was printed as "c0" and "c0" and the error message "No NAND device found!!!".  Does it mean it is not accessing the NAND flash and the values read are junk one?
2)	Processor of the board doesn’t connect the Ready/Busy of the NAND flash through the separate GPIO chip. I mean it is directly connected from GPIO Port C of PIN 15 to the Ready/Busy PIN of the NAND flash. Hence is it necessary to port the gpio specific functions like gpio_request/gpio_free(specified in fsl_upm.c file), instead should we need to configure the PIN par_io_config_pin()  for configuration of the PORT C with 15th PIN and set the data value using par_io_data_set() (specified arch/powerpc/sysdev/qe_lib/qe_io.c)

Please let me know any input on the above issue.

Thanks in advance

Regards,
Nanda

--=_c9eee608535d82e8c16d9284918b0e96
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

<br />
  We had merged the 2.6.24 with the FSL based NAND driver, we observed that=
 gpio library is mandatory to be included. We have not included the gpios c=
onfigured in the dts file as the we don=E2=80=99t have the separate GPIO ch=
ip(arch/powepc/boot/dts/board.dts). <br />
 After executing the image in the board, we observed the below<br />
1)	The device ID and manufacture Id was printed as "c0" and "c0" and the er=
ror message "No NAND device found!!!".  Does it mean it is not accessing th=
e NAND flash and the values read are junk one?<br />
2)	Processor of the board doesn=E2=80=99t connect the Ready/Busy of the NAN=
D flash through the separate GPIO chip. I mean it is directly connected fro=
m GPIO Port C of PIN 15 to the Ready/Busy PIN of the NAND flash. Hence is i=
t necessary to port the gpio specific functions like gpio_request/gpio_free=
(specified in fsl_upm.c file), instead should we need to configure the PIN =
par_io_config_pin()  for configuration of the PORT C with 15th PIN and set =
the data value using par_io_data_set() (specified arch/powerpc/sysdev/qe_li=
b/qe_io.c)<br />
<br />
Please let me know any input on the above issue.<br />
<br />
Thanks in advance<br />
<br />
Regards,<br />
Nanda<br />
<br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadding=
=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;"><TR><td=
><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.rediffm=
ail.com/signatureline.htm@Middle?" target=3D"_blank"><IMG SRC=3D"http://sig=
ads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signatureli=
ne.htm@Middle"></A></td></TR></Table>
--=_c9eee608535d82e8c16d9284918b0e96--
