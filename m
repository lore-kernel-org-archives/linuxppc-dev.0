Return-Path: <tmk@cmcltd.com>
Received: from cmcdns1.cmcltd.com (navint.cmcltd.com [59.160.161.31])
	by ozlabs.org (Postfix) with ESMTP id 9A3C267B9E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 16:15:05 +1000 (EST)
From: Mohan Krishna T <tmk@cmcltd.com>
To: 'Peter Ryser' <peter.ryser@xilinx.com>, <linuxppc-embedded@ozlabs.org>
Subject: =?UTF-8?Q?RE=3A_Unable_to_boot_linux_on_Xilinx_ML403_board?=
Date: Tue, 26 Sep 2006 11:44:26 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <451800D9.5010702@xilinx.com>
Message-ID: <smtp_4518C3AA_7052_0002.eml@>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have tried the option you have suggested but couldn't boot successfully. I
tried to debug where exactly the kernel is getting hanged. I could found
that its hanging in gunzip() function call. It is never coming out of loop
that decompress the ramdisk image.=20

Any suggestions?=20

Thanks in advance...

Regards
Mohan Krishna T


-----Original Message-----
From: linuxppc-embedded-bounces+tmk=3Dcmcltd.com=40ozlabs.org
=5Bmailto:linuxppc-embedded-bounces+tmk=3Dcmcltd.com=40ozlabs.org=5D On =
Behalf Of
Peter Ryser
Sent: Monday, September 25, 2006 9:46 PM
To: linuxppc-embedded=40ozlabs.org
Subject: Re: Unable to boot linux on Xilinx ML403 board


>avail ram:     00770000 08000000
> =20
>

The ML403 only has 64 MB of RAM, ie. 0x04000000. For a start you can=20
change the amount of memory Linux thinks it has available by adding
    mem=3D0x4000000
to the kernel command line like
    Linux/PPC load: console=3Dtty1 console=3DttyS0,9600 ip=3Doff =
root=3D/dev/ram=20
rw mem=3D0x4000000

Later, you want to change xparameters*.h in arch/ppc/platforms/xilinx_ocp

- Peter



_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded=40ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



DISCLAIMER

=E2=80=9CThe information contained in this e-mail message and/or =
attachments to it may contain confidential or privileged information. If =
you are not the intended recipient, any dissemination, use, review, =
distribution, printing or copying of the information contained in this =
e-mail message and/or attachments to it are strictly prohibited. If you =
have received this communication in error, please notify us by reply =
e-mail or telephone and immediately and permanently delete the message and =
any attachments. Thank you=22=
