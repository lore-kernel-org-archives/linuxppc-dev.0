Return-Path: <soumya.k.s@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 731F168802
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 15:55:27 +1100 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.12.11/Motgate7) with ESMTP id jBF58f6w020378
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 22:08:41 -0700 (MST)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id jBF552xD013118
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 23:05:03 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 15 Dec 2005 12:54:54 +0800
Message-ID: <C82A9B11BE247C4E952DC733EA98DAA1C55006@ZMY16EXM66.ds.mot.com>
From: "KS Soumya-ask067" <soumya.k.s@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux dependency for PCI Window on U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

Hi,
	Is there anything more specific that I need to do to enable my PCI =
window to 512MB? I'm using Linux kernel 2.4.20 / KO2.6.10 with MPC8540 =
ADS defconfig and U-Boot for the same. By default, the U-Boot is =
specifying a window of 256MB (0x80000000 - 0x8fffffff). Even if the =
Linux specifies 512MB (0x80000000 - 0x9fffffff), I am not able to access =
my device registers on 9f4f0000 (BAR of my device).=20
But if I specify in U-Boot to make the PCI window as 512MB, (or if I =
make the Linux to hold 256MB) then Im able to access my device. What =
should I do for my kernel not to be dependent on U-Boot for the same?=20
Any pointers would be of great help. Thank you.

-Soumya

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org =
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of =
linuxppc-embedded-request@ozlabs.org
Sent: Wednesday, December 14, 2005 8:01 PM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 16, Issue 36

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific than =
"Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. Re: how to define BASE_BAUD (Debora Liu)
   2. "make xconfig" error (2.4.25 devel) (HappyPhot)
   3. Re: MPC8245 with its internal UART (HappyPhot)
   4. SPI driver for 82xx (Dmytro Bablinyuk)
   5. Re: pq2_find_bridges hangs system (Alex BASTOS)
   6. Re: pq2_find_bridges hangs system (Vitaly Bordug)
   7. [SOLVED] Re: pq2_find_bridges hangs system  (Alex BASTOS)
   8. Re: [SOLVED] Re: pq2_find_bridges hangs system (Vitaly Bordug)
   9. 8260 ethernet driver multicast problem (Robin Mathew)
  10. Re: [SOLVED] Re: pq2_find_bridges hangs system (Kumar Gala)


----------------------------------------------------------------------

Message: 1
Date: Wed, 14 Dec 2005 09:39:32 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
Subject: Re: how to define BASE_BAUD
To: "HappyPhot" <happyphot@gmail.com>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Message-ID: <200512140929125.SM00772@RavProxy>

Hello, HappyPhot

In message <2005-12-14 01:19:49 happyphot@gmail.com> you wrote:

>   Can anybody tell me how to define the "BASE_BAUD" value for the=20
>"struct serial_state rs_table[]" ?
>  It seems has different value for each platform !!

yes, this is different for each platform.
see your crystal used by UART.

=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1Debora Liu
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1deboralh@fel.com.cn
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A12005-12-14




------------------------------

Message: 2
Date: Wed, 14 Dec 2005 11:41:45 +0800
From: "HappyPhot" <happyphot@gmail.com>
Subject: "make xconfig" error (2.4.25 devel)
To: <linuxppc-embedded@ozlabs.org>
Message-ID: <000401c60063$3dc46040$0760120a@photon>
Content-Type: text/plain; format=3Dflowed; charset=3D"big5";
	reply-type=3Doriginal

Hello,
  I am trying "linuxppc_2_4_devel-2005-10-25-1440".
The "make xconfig" seems not work. ("make menuconfig" is ok) It shows :
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
....
./tkparse < ../arch/ppc/config.in >> kconfig.tk
arch/ppc/8xx_io/Config.in: 312: unknown define_bool value
make[1]: *** [kconfig.tk] Error 1
....
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Does this version support "make xconfig" ?

thank you,
/HappyPhot



------------------------------

Message: 3
Date: Wed, 14 Dec 2005 14:36:10 +0800
From: "HappyPhot" <happyphot@gmail.com>
Subject: Re: MPC8245 with its internal UART
To: <hs@denx.de>,	<linuxppc-embedded@ozlabs.org>
Message-ID: <005301c60078$b8dd1550$0760120a@photon>
Content-Type: text/plain; format=3Dflowed; charset=3D"iso-8859-1";
	reply-type=3Doriginal

Hi,
  I've tried this (CPC45_config) on Denx Kernel 2.4.25, and my serial =
console works now. Thank you very much.

  Is there any similar platform for kernel 2.6 ? (i.e. MPC8245 with its =
internal UART )

thank you,
/HappyPhot

>=20
>> Who can tell me which flatform is similar to mine ? I've tried "make=20
>> sandpoint_defconfig", but seems not the right one.
>=20
> If you want to use Linux 2.4.25, you can try CPC45_defconfig from the=20
> Denx Kernel ...



------------------------------

Message: 4
Date: Wed, 14 Dec 2005 18:13:02 +1100
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
Subject: SPI driver for 82xx
To: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Message-ID: <439FC5FE.8090703@rftechnology.com.au>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Is anywhere available SPI driver (SPI peripheral) for 82xx for 2.6.x =
kernel?
I will appreciate any reference or suggestion.

Thank you

Dmytro



------------------------------

Message: 5
Date: Wed, 14 Dec 2005 11:21:02 +0100
From: Alex BASTOS <alebas@televes.com>
Subject: Re: pq2_find_bridges hangs system
To: Alex BASTOS <alebas@televes.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Message-ID: <1134555662.439ff20e6e812@webmail.televes.com:443>
Content-Type: text/plain; charset=3DISO-8859-15

Vitaly,

So, I have arrived to some conclusions.

1) With my previous kernel version (2.6.11) I had no problems because it =
had CONFIG_PCI_8260 and CONFIG_PPC_INDIRECT_PCI unset.
So I think no effective read/write operation was executed, and so that, =
no Machine Check.

In fact, this is the configuration I would prefer for my board. I have =
to set CONFIG_PCI for enabling USB, but I don't want all the HW stuff of =
the PCI. I can get these also with 2.6.15 if I modify Kconfig, to allow =
me to unset PCI_8260 (and then PPC_INDIRECT_PCI) for my board.
With that, the problem dissapears and I can boot 2.6.15.

Shouldn't this (PCI_8260) be visible from xconfig for those like me who =
wants USB (=3D> CONFIG_PCI) but don't really have any PCI device?

2) Although I am using Uboot 1.1.4, it is not top of git. I have found =
your changes to support PCI on 8272ADS for u-boot are not still applied =
on the version i am using. So, could this be causing the problem? Is =
there any configuration done in u-boot required by the PCI on the linux =
kernel to boot (BR3,OR3, EMR, ...)?

I should say that, on ADS, I have an older version of u-boot, 1.1.2, and =
it boots OK.

3) I have seen that from u-boot, a reset occurs when I read Internal =
Memory at offset 0x10904 (PCI CFG_DATA). From BDI, when I do the same =
all PCI section on IM becomes zero. Is this a known behaviour? May this =
reflect a hardware problem?

In conclusion, 1) solves my "must", a working board (without PCI).
But I still would like to know what am I doing so wrong with this.

Best regards,

Alex

Citando Alex BASTOS <alebas@televes.com>:

> Vitaly,
>
> It didn't work. So I will check pq2ads_setup_pci to check if some=20
> board specific issue is affected.
>
> I will say you if I find anything
>
> Thanks
>
> Alex.
>



------------------------------

Message: 6
Date: Wed, 14 Dec 2005 14:29:34 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: pq2_find_bridges hangs system
To: Alex BASTOS <alebas@televes.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Message-ID: <43A0021E.7030406@ru.mvista.com>
Content-Type: text/plain; charset=3DISO-8859-15; format=3Dflowed

Alex BASTOS wrote:
> Vitaly,
>=20
> So, I have arrived to some conclusions.
>=20
> 1) With my previous kernel version (2.6.11) I had no problems because=20
> it had CONFIG_PCI_8260 and CONFIG_PPC_INDIRECT_PCI unset.
> So I think no effective read/write operation was executed, and so=20
> that, no Machine Check.
>=20
> In fact, this is the configuration I would prefer for my board. I have =

> to set CONFIG_PCI for enabling USB, but I don't want all the HW stuff=20
> of the PCI. I can get these also with 2.6.15 if I modify Kconfig, to=20
> allow me to unset PCI_8260 (and then PPC_INDIRECT_PCI) for my board.
> With that, the problem dissapears and I can boot 2.6.15.
>=20
> Shouldn't this (PCI_8260) be visible from xconfig for those like me=20
> who wants USB (=3D> CONFIG_PCI) but don't really have any PCI device?
>=20
Maybe, but I guess more correct is to deal with USB->PCI dependency..=20
Is it really needed(I am not USB expert)?
> 2) Although I am using Uboot 1.1.4, it is not top of git. I have found =

> your changes to support PCI on 8272ADS for u-boot are not still=20
> applied on the version i am using. So, could this be causing the=20
> problem? Is there any configuration done in u-boot required by the PCI =

> on the linux kernel to boot (BR3,OR3, EMR, ...)?
>=20
> I should say that, on ADS, I have an older version of u-boot, 1.1.2,=20
> and it boots OK.
>=20
My changes do not required for kernel to deal with PCI, that patch just =
allows access to PCI in U-Boot. Hence I might be useful if you'll head =
for resolving this issue which I guess unlikely to happen
> 3) I have seen that from u-boot, a reset occurs when I read Internal=20
> Memory at offset 0x10904 (PCI CFG_DATA). From BDI, when I do the same=20
> all PCI section on IM becomes zero. Is this a known behaviour? May=20
> this reflect a hardware problem?
>=20
Sounds weird=20
> In conclusion, 1) solves my "must", a working board (without PCI).
> But I still would like to know what am I doing so wrong with this.
>=20
IMHO ability to disable PCI_8260 while PCI is on might be confusing, at =
least for upstream.



> Best regards,
>=20
> Alex
>=20
> Citando Alex BASTOS <alebas@televes.com>:
>=20
>> Vitaly,
>>
>> It didn't work. So I will check pq2ads_setup_pci to check if some=20
>> board specific issue is affected.
>>
>> I will say you if I find anything
>>
>> Thanks
>>
>> Alex.
>>
>=20
>=20


--
Sincerely,
Vitaly


------------------------------

Message: 7
Date: Wed, 14 Dec 2005 15:13:22 +0100
From: Alex BASTOS <alebas@televes.com>
Subject: [SOLVED] Re: pq2_find_bridges hangs system
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Message-ID: <1134569602.43a0288234662@webmail.televes.com:443>
Content-Type: text/plain; charset=3DISO-8859-15

Vitaly,

> Maybe, but I guess more correct is to deal with USB->PCI dependency..
> Is it really needed(I am not USB expert)?

Neither am I. I guess for this Host Controler it is not needed at HW =
level, but I am not sure why it is still required by the SW.


> > 3) I have seen that from u-boot, a reset occurs when I read Internal =

> > Memory at offset 0x10904 (PCI CFG_DATA). From BDI, when I do the=20
> > same all PCI section on IM becomes zero. Is this a known behaviour?
> > May this reflect a hardware problem?
> >
> Sounds weird

Here is the problem. The cause for this weird behaviour is that I had =
PCI_ARBITER_EN_  disabled. So, a HW problem at the end.
I had disabled it trying to reduce power compsumption due to the PCI, as =
I am not going to use it. It seems it is not possible that way.
Any idea how to get this done?

> > In conclusion, 1) solves my "must", a working board (without PCI).
> > But I still would like to know what am I doing so wrong with this.
> >
> IMHO ability to disable PCI_8260 while PCI is on might be confusing,=20
> at least for upstream.

You are right.

Thanks so much for your help.

Best regards,

Alex


------------------------------

Message: 8
Date: Wed, 14 Dec 2005 17:14:51 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [SOLVED] Re: pq2_find_bridges hangs system
To: Alex BASTOS <alebas@televes.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Message-ID: <43A028DB.5090906@ru.mvista.com>
Content-Type: text/plain; charset=3DISO-8859-15; format=3Dflowed

Alex BASTOS wrote:
> Vitaly,
>=20
>> Maybe, but I guess more correct is to deal with USB->PCI dependency..
>> Is it really needed(I am not USB expert)?
>=20
> Neither am I. I guess for this Host Controler it is not needed at HW=20
> level, but I am not sure why it is still required by the SW.
>=20
>=20
>>> 3) I have seen that from u-boot, a reset occurs when I read Internal =

>>> Memory at offset 0x10904 (PCI CFG_DATA). From BDI, when I do the=20
>>> same all PCI section on IM becomes zero. Is this a known behaviour?
>>> May this reflect a hardware problem?
>>>
>> Sounds weird
>=20
> Here is the problem. The cause for this weird behaviour is that I had=20
> PCI_ARBITER_EN_  disabled. So, a HW problem at the end.
> I had disabled it trying to reduce power compsumption due to the PCI,=20
> as I am not going to use it. It seems it is not possible that way.
> Any idea how to get this done?
>=20
Well, I guess the best you can do now - just use custom tree. I'll try =
to find good solution for such a case (PCI required by deps but not hw) =
next time I'll touch PCI.

>>> In conclusion, 1) solves my "must", a working board (without PCI).
>>> But I still would like to know what am I doing so wrong with this.
>>>
>> IMHO ability to disable PCI_8260 while PCI is on might be confusing,=20
>> at least for upstream.
>=20
> You are right.
>=20
> Thanks so much for your help.
>=20
> Best regards,
>=20
> Alex
>=20
>=20


--
Sincerely,
Vitaly


------------------------------

Message: 9
Date: Wed, 14 Dec 2005 19:58:40 +0530
From: Robin Mathew <robbinmathew@gmail.com>
Subject: 8260 ethernet driver multicast problem
To: linuxppc-embedded@ozlabs.org
Message-ID:
	<5b74ec4d0512140628y42986bc0h2f107e788dd115b6@mail.gmail.com>
Content-Type: text/plain; charset=3D"iso-8859-1"

Hi,
I was encountering a problem with the receipt of multicast packets from =
eth interface in 8260 platform. The issue was traced to the fcc_enet.c =
driver. A stray return in the set_multicast_list function was the =
culprit.

The following is the changes that I have made-

Index: fcc_enet.c
@@ -1488,7 +1488,6 @@

     cep =3D (struct fcc_enet_private *)dev->priv;

-return;
     /* Get pointer to FCC area in parameter RAM.
     */
     ep =3D (fcc_enet_t *)dev->base_addr;


Can you please tell me whether there is any issue with setting the =
driver in multicast or promiscous mode. Was this change deliberately =
done or is it really a bug?

Thanks in advance,
Robin
-------------- next part --------------
An HTML attachment was scrubbed...
URL: =
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20051214/af24a6=
1a/attachment.html

------------------------------

Message: 10
Date: Wed, 14 Dec 2005 08:30:48 -0600
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [SOLVED] Re: pq2_find_bridges hangs system
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,	Alex BASTOS
	<alebas@televes.com>
Message-ID: <386A8114-FA1C-44E2-A8F1-CF48F4AF495E@kernel.crashing.org>
Content-Type: text/plain; charset=3DUS-ASCII; delsp=3Dyes; =
format=3Dflowed


On Dec 14, 2005, at 8:14 AM, Vitaly Bordug wrote:

> Alex BASTOS wrote:
>> Vitaly,
>>> Maybe, but I guess more correct is to deal with USB->PCI=20
>>> dependency..
>>> Is it really needed(I am not USB expert)?
>> Neither am I. I guess for this Host Controler it is not needed at HW=20
>> level, but I am not sure why it is still required by the SW.
>>>> 3) I have seen that from u-boot, a reset occurs when I read=20
>>>> Internal Memory at offset 0x10904 (PCI CFG_DATA). From BDI, when I=20
>>>> do the same all PCI section on IM becomes zero. Is this a known=20
>>>> behaviour?
>>>> May this
>>>> reflect a hardware problem?
>>>>
>>> Sounds weird
>> Here is the problem. The cause for this weird behaviour is that I had =

>> PCI_ARBITER_EN_  disabled. So, a HW problem at the end.
>> I had disabled it trying to reduce power compsumption due to the PCI, =

>> as I am not going to use it. It seems it is not possible that way.
>> Any idea how to get this done?

I'm guessing you dont have anything else doing arbitration on the bus.

- kumar



------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 16, Issue 36
*************************************************
