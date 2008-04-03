Return-Path: <xiaochang.duan@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2BFB8DE598
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Apr 2008 04:41:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: Xilinx LLTEMAC driver issues
Date: Thu, 3 Apr 2008 11:41:30 -0600
In-Reply-To: <7e0dd21a0804030939p30699ae3s4c485eb35a53b7ee@mail.gmail.com>
References: <20080329125416.B09261AD8051@mail119-sin.bigfish.com>
	<000601c8931f$e1d549a0$a57fdce0$@se>
	<7e0dd21a0804020020s66a091ferfbbf4142adcd84ae@mail.gmail.com>
	<20080403003200.CB2BF1968046@mail103-sin.bigfish.com>
	<BAY138-W45D7625ED50533D8D2680BB2F70@phx.gbl>
	<20080403154253.286DE5A004D@mail128-sin.bigfish.com>
	<7e0dd21a0804030939p30699ae3s4c485eb35a53b7ee@mail.gmail.com>
From: "Xiaochang Duan" <xiaochang.duan@xilinx.com>
To: "Johann Baudy" <johaahn@gmail.com>
Message-Id: <20080403174131.F0A54538057@mail176-sin.bigfish.com>
Cc: John Linn <linnj@xilinx.com>, git <git@xilinx.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the clarification. :)
-Xiaochang

-----Original Message-----
From: Johann Baudy [mailto:johaahn@gmail.com]=20
Sent: Thursday, April 03, 2008 10:39 AM
To: Xiaochang Duan
Cc: MingLiu; John Bonesio; linuxppc-embedded@ozlabs.org; John Linn; git
Subject: Re: Xilinx LLTEMAC driver issues

The only part of the patch that really solves the checksum offload
calculation is into xenet_DmaSend_internal().
The rest is warning removal, comment update and developer friendly =
define :)

Best regards,
Johann


2008/4/3 Xiaochang Duan <xiaochang.duan@xilinx.com>:
>
>
>
>
> According to C operator precedence =
((http://www.difranco.net/cop2220/op-prec.htm), the following patch =
should not be needed as operator "<<" has higher precedence than =
operator "|".
>
>
>
> -    XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, (Start) << 16 | =
(Insert))
>
>
> +    XLlDma_mBdWrite((BdPtr), XLLDMA_BD_USR1_OFFSET, ((Start) << 16) |
>
> + (Insert))
>
>
>
> Also FYI, the XLlDma_mBdWrite currently is defined in xlldma driver =
as:
>
>
>
> #define XLlDma_mBdWrite(BaseAddress, Offset, Data)                \
>
>             (*(u32*)((u32)(BaseAddress) + (u32)(Offset)) =3D (Data))
>
>
>
> So I don't understand why the patch could help.
>
>
>
> Thanks,
>
> -Xiaochang
>
> ________________________________

>
> From: MingLiu [mailto:eemingliu@hotmail.com]
> Sent: Thursday, April 03, 2008 2:29 AM
> To: John Bonesio; Johann Baudy
> Cc: linuxppc-embedded@ozlabs.org; John Linn; git
>
> Subject: RE: Xilinx LLTEMAC driver issues
>
>
>
>
>
>
> Dear all,
>
> > The change with the extra parenthesis (in the patch starting with =
line 133) seems unecessary. I looked at the XLlDma_mBdWrite macro and it =
appeared to have the correct use of parethesis in the implementation.
> > So, assuming there's nothing subtle that I missed, it's not needed. =
However, it does no harm either.
>
> However it really helps after I tried this patch. So there should be =
some difference after it is used.
>
> One more question, does this mean that the problem is not on the =
hardware timing, but the device driver?
>
> BR
> Ming
> ________________________________

>
> Windows Live =
Writer=A3=AC=D6=A7=B3=D6=C0=EB=CF=DF=D7=AB=D0=B4=B2=A9=BF=CD=C4=DA=C8=DD=A3=
=AC=CB=E6=CA=B1=CB=E6=B5=D8=CF=EB=D0=B4=BE=CD=D0=B4=A1=A3 =
=C1=A2=BC=B4=CA=B9=D3=C3=A3=A1



--=20
Johann Baudy
johaahn@gmail.com
