Return-Path: <jcrigby@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id EADBEDDECE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Mar 2007 04:11:20 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b21so799349ana
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 09 Mar 2007 09:11:18 -0800 (PST)
Message-ID: <4b73d43f0703090911y3c2898cdmfdb84f8c7f5da8f@mail.gmail.com>
Date: Fri, 9 Mar 2007 10:11:18 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto read I2C on MPC5200 Lite
In-Reply-To: <20070309113506.GB6726@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070307122430.GA73298@server.idefix.lan>
	<4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
	<20070309113506.GB6726@server.idefix.lan>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The some 5200's have had a problem with
a missing clock pulse on scl.

The latest ppc tree plus Doman Puncer's i2c patch of a few
days ago
http://article.gmane.org/gmane.linux.ports.ppc.embedded/15718/match=3Di2c
should fix the problem if that is it.

On 3/9/07, Matthias Fechner <idefix@fechner.net> wrote:
> Hello John,
>
> * John Rigby <jrigby@freescale.com> [07-03-07 14:17]:
> > On a stock lite5200b the only thing that shows up is a serial
> > eeprom at address 0x50.
>
> thx a lot, that tool helped me a lot.
> I have written a very small c-program to access the I2C bus to read the
> temperature of my MAX6633 and convert it to =B0C.
>
> That worked fine, but after reading the value some time, the I2C bus
> is dead. The kernel says:
> i2c_adapter i2c-1: ioctl, cmd=3D0x705, arg=3D0x7feaf8ec
> i2c_adapter i2c-1: ioctl, cmd=3D0x706, arg=3D0x40
> i2c_adapter i2c-1: ioctl, cmd=3D0x720, arg=3D0x7feaf8f0
> i2c_adapter i2c-1: master_xfer[0] W, addr=3D0x40, len=3D1
> i2c_adapter i2c-1: master_xfer[1] R, addr=3D0x40, len=3D2
> I2C: timeout
>
> Is that maybe a bug in the I2C driver (i2c-mpc) or is my programm
> faulty?
> If it helps I can attach the programm.
>
> Best regards,
> Matthias
>
> --
>
> "Programming today is a race between software engineers striving to
> build bigger and better idiot-proof programs, and the universe trying to
> produce bigger and better idiots. So far, the universe is winning." --
> Rich Cook
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
