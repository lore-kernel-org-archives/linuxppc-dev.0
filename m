Return-Path: <nanda74pg@rediffmail.com>
Received: from rediffmail.com (f5mail-236-229.rediffmail.com [202.137.236.229])
	by ozlabs.org (Postfix) with SMTP id 900FCB7CC1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 05:22:05 +1100 (EST)
Date: 20 Jan 2010 18:11:12 -0000
MIME-Version: 1.0
To: <scottwood@freescale.com>
Message-ID: <1263921085.S.3173.3591.f5mail-147-110.rediffmail.com.old.1264011068.46402@webmail.rediffmail.com>
Subject: =?utf-8?B?UmU6IFJlOiBmc2wgdXBtIE5BTkQgRmxhc2ggaXNzdWUgd2l0aG91dCBHUElPIGNoaXAgaGFuZGxlcg==?=
From: "nanda" <nanda74pg@rediffmail.com>
Content-Type: multipart/alternative;
	boundary="=_ae2fc71448069051de0bb354bcc0d23a"
Cc: linuxppc-dev@ozlabs.org, avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=_ae2fc71448069051de0bb354bcc0d23a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"

my response inlined..

On Tue, 19 Jan 2010 22:41:25 +0530  wrote
>nanda wrote:
> 
> We had merged the 2.6.24 

That's pretty old...
>> We were using 2.6.24 as this kernel version this is the references used by us for MPC8321E.
> with the FSL based NAND driver,

Which one? Which chip are you using, and how is NAND attached to it?
>> MPC8321E processor connected to STM NAND Flash. Port C PIN 15 of the processor connected to the R/B# ( Ready/Busy PIN) of the STM NAND Flash. 

> we observed that gpio library is mandatory to be included. We have not included the 
> gpios configured in the dts file as the we don’t have the separate GPIO 
> chip(arch/powepc/boot/dts/board.dts).

What separate GPIO chip? Which "board.dts" are you looking at?
>> dts file I was refering is mpc832x_rdb.dts file, which we assumed that GPIO controller is not required. ( Correct me if my assumption is correct)  

> After executing the image in the board, we observed the below
> 1) The device ID and manufacture Id was printed as "c0" and "c0" and the 
> error message "No NAND device found!!!". Does it mean it is not 
> accessing the NAND flash and the values read are junk one?
> 2) Processor of the board doesn’t connect the Ready/Busy of the NAND 
> flash through the separate GPIO chip. I mean it is directly connected 
> from GPIO Port C of PIN 15 to the Ready/Busy PIN of the NAND flash. 
> Hence is it necessary to port the gpio specific functions like 
> gpio_request/gpio_free(specified in fsl_upm.c file), instead should we 
> need to configure the PIN par_io_config_pin() for configuration of the 
> PORT C with 15th PIN and set the data value using par_io_data_set() 
> (specified arch/powerpc/sysdev/qe_lib/qe_io.c)

Have you tried pointing the "gpios" property at pin 15 of port C? The 
whole point of this abstraction is that these connections are described 
in the data, not in the code.
>> Iam not sure how to specify the  in the mpc832x_rdb.dts for the pin 15 port C of the MPc8321E processor. Please help us on the same.
Some reference which I made was mpc836x_rdk.dts file which mandates the GPIO controller, hence I felt not required(Correct me if Iam wrong)

-Nanda

--=_ae2fc71448069051de0bb354bcc0d23a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

my response inlined..<br />
<br />
On Tue, 19 Jan 2010 22:41:25 +0530  wrote<br />
>nanda wrote:<br />
> <br />
> We had merged the 2.6.24 <br />
<br />
That's pretty old...<br />
>> We were using 2.6.24 as this kernel version this is the references used =
by us for MPC8321E.<br />
> with the FSL based NAND driver,<br />
<br />
Which one? Which chip are you using, and how is NAND attached to it?<br />
>> MPC8321E processor connected to STM NAND Flash. Port C PIN 15 of the pro=
cessor connected to the R/B# ( Ready/Busy PIN) of the STM NAND Flash. <br /=
>
<br />
> we observed that gpio library is mandatory to be included. We have not in=
cluded the <br />
> gpios configured in the dts file as the we don=E2=80=99t have the separat=
e GPIO <br />
> chip(arch/powepc/boot/dts/board.dts).<br />
<br />
What separate GPIO chip? Which "board.dts" are you looking at?<br />
>> dts file I was refering is mpc832x_rdb.dts file, which we assumed that G=
PIO controller is not required. ( Correct me if my assumption is correct)  =
<br />
<br />
> After executing the image in the board, we observed the below<br />
> 1) The device ID and manufacture Id was printed as "c0" and "c0" and the =
<br />
> error message "No NAND device found!!!". Does it mean it is not <br />
> accessing the NAND flash and the values read are junk one?<br />
> 2) Processor of the board doesn=E2=80=99t connect the Ready/Busy of the N=
AND <br />
> flash through the separate GPIO chip. I mean it is directly connected <br=
 />
> from GPIO Port C of PIN 15 to the Ready/Busy PIN of the NAND flash. <br /=
>
> Hence is it necessary to port the gpio specific functions like <br />
> gpio_request/gpio_free(specified in fsl_upm.c file), instead should we <b=
r />
> need to configure the PIN par_io_config_pin() for configuration of the <b=
r />
> PORT C with 15th PIN and set the data value using par_io_data_set() <br /=
>
> (specified arch/powerpc/sysdev/qe_lib/qe_io.c)<br />
<br />
Have you tried pointing the "gpios" property at pin 15 of port C? The <br /=
>
whole point of this abstraction is that these connections are described <br=
 />
in the data, not in the code.<br />
>> Iam not sure how to specify the <gpios> in the mpc832x_rdb.dts for the p=
in 15 port C of the MPc8321E processor. Please help us on the same.<br />
Some reference which I made was mpc836x_rdk.dts file which mandates the GPI=
O controller, hence I felt not required(Correct me if Iam wrong)<br />
<br />
-Nanda<br />
<br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadding=
=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;"><TR><td=
><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.rediffm=
ail.com/signatureline.htm@Middle?" target=3D"_blank"><IMG SRC=3D"http://sig=
ads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signatureli=
ne.htm@Middle"></A></td></TR></Table>
--=_ae2fc71448069051de0bb354bcc0d23a--
