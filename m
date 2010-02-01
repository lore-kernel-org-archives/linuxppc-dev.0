Return-Path: <Dan.Geer@faa.gov>
Received: from relay2.faa.gov (relay2.faa.gov [204.108.10.7])
	by ozlabs.org (Postfix) with ESMTP id 98156B7D55
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 06:00:18 +1100 (EST)
In-Reply-To: <4B671C4D.5070806@freescale.com>
References: <OF7C180968.43598D84-ON852576BD.006286D6-852576BD.0063AC38@faa.gov>
	<4B671C4D.5070806@freescale.com>
Subject: Re: BSE-IP
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF7ADBC091.CA74BF20-ON852576BD.0065FA13-852576BD.00685848@faa.gov>
From: Dan.Geer@faa.gov
Date: Mon, 1 Feb 2010 13:59:43 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Has your firmware already set up the serial port?  cpm-serial doesn't
make
> assumptions about specific addresses, but it does assume that the BRG,
pins,
> etc. have been set up for the serial port to work.

Yes. Or, so I thought. First, I interrupt the bootstrap with <Esc>.  Then,
I load the image into RAM with 'load simpleImage.bseip 200000' then 'go
200000'.  All of which is echo'd out the serial console by the firmware.
I assumed that the low-level setups were complete.  However, in the old
ppc/boot/m8xx_tty.c there is some initialization for SMC1 and the BRG
(serial_init()).  Where should I do this in the new model?  Is
platform_specific_init() the right place?

> If this isn't the case, you'll need to do it from a custom bootwrapper
platform
> file.
>
> >                                      d-cache-line-size = <8>;       //
8 bytes
> > per line
> >                                      i-cache-line-size = <8>;       //
8 bytes
> > per line
>
> Shouldn't this be 16 bytes?

Thanks!  I read "4 word boundary" in the manual, and assumed 16bit words.
I fixed this, but same results.  I think I have a little more init work
todo.

> >              soc@ff000000 {
>
> Is this the correct IMMR address for your firmware?

Yes, this is the correct IMMR address.

Thanks for your help!
Dan
