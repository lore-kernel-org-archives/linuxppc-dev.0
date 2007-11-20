Return-Path: <charanya.venkatraman@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id AC813DDDD5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 05:59:05 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so612601wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 10:59:04 -0800 (PST)
Message-ID: <fa84b3da0711201059p2104997k2d5f7c47c8bea2c8@mail.gmail.com>
Date: Wed, 21 Nov 2007 00:29:03 +0530
From: "charanya venkatraman" <charanya.venkatraman@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6 kernel hangs after loading device tree
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
      I got a solution to this.The problem was with the current speed
parameter in the DTS,as stated.You need to explicity specify the
speed.It doesnot get filled in from U-boot.You can also probabaly
check the kernel log buf to see what values are set for these
parameters.Anyways,changing the current speed made it work me and my
2.6 kernel is now up.

Thanks.
Charanya.



> Date: Mon, 19 Nov 2007 16:08:03 -0800 (PST)
> From: abhi_linux <seema.pm@gmail.com>
> Subject: Re: 2.6 kernel hangs after loading device tree
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <13848328.post@talk.nabble.com>
> Content-Type: text/plain; charset=us-ascii
>
>
> Hello
> Did u get a solution to this? I have similar issues. How do u enable
> debugging in UBoot?
> Thanks
>
> charanya venkatraman wrote:
> >
> > Hi all
> >        Sorry about the previous mail.Got sent  by mistake.
> >
> > Iam using the 2.6.22.5 kernel on MPC 8560 and MPC8540 on my custom
> > board.Mykernel hangs after loading the device tree in both the
> > processors .There is
> > no output on the serial port after loading the device tree.Am using U-boot
> > 1.2.0 as the bootloader.After enabling debug in u-boot i could see that
> > the
> > control is getting transferred to the kernel after which it hangs.Earlier
> > i
> > tried using 2.6.21 which also hangs at the same point.The config files
> > used
> > were MPC8540ADS_defconfig and MPC8560ADS_defconfig under powerpc
> > directory.
> > The changes that were made to the device tree are:
> > 1.The reg and ranges properties of the soc node have been changed to
> > account
> > for the change in CCSRBAR of my board.
> > 2.Removed the PCI,mdio nodes and ethernet nodes since i dont need support
> > for these as of now.
> >
> > I have tried the following console arguments:
> > MPC8540: bootargs root=/dev/ram rw console=ttyS0,115200
> > MPC8560:bootargs root=/dev/ram rw console=ttyCPM0,115200
> >
> > Any help on this issue??
> >
> > Thanks.
> > Charanya.
