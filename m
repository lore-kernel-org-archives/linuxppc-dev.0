Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 435B9DE092
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 03:08:06 +1100 (EST)
Message-ID: <496B68D9.1040401@grandegger.com>
Date: Mon, 12 Jan 2009 16:59:21 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mpc5200b configure nand driver via dts
References: <c4fbc703368c62be70c700e6f962eb12@email.freenet.de>
	<fa686aa40901120648x3c224999sd0da6e80e4fd43be@mail.gmail.com>
In-Reply-To: <fa686aa40901120648x3c224999sd0da6e80e4fd43be@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: florian.belser@freenet.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Mon, Jan 12, 2009 at 2:07 AM,  <florian.belser@freenet.de> wrote:
>> hello,
>>
>> I have some problems with an mpc5200b based board. It's nearly compatible to
>> the lite5200b board.
>> I connected an samsung k9k8g08u0a nand flash via the lpb bus. This works
>> fine with an self written nand driver.
>> Now I try to use the standard nand driver from linux and configure it via
>> the dts file. But this doesn't work and I get
>> the following output:
>>
>>   nand@1,0 {  //cs1
>>    compatible = "samsung, k9k8g08u08", "cfi-flash";
>                                           ^^^^^^^^^
> 
> NAND Flash is not a CFI flash device.  The cfi-flash driver won't work with it.
> 
>> Now my questions are:
>>  Is there any error in the dts configuration?
>>  Is it principle posible to configure a nand flash via the dts file (in
>> combination with mpc5200b)?
> 
> It is possible to *describe* the NAND flash via the dts file.  The dts
> file doesn't configure anything.  It just describes the hardware
> layout so that you can write or bind the appropriate driver to the
> device.  I don't know if a device tree binding has been defined for
> NAND flash yet.

I find 3 MTD NAND drivers with OF bindings in linux-2.6/drivers/mtd/nand

  $ grep -l of_device *.c
  fsl_elbc_nand.c
  fsl_upm.c
  pasemi_nand.c

The bindings for the FSL UPM are described in
http://lxr.linux.no/linux+v2.6.28/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt.
Something similar is needed for his board (NAND connected to lpb) as well.

>>  I read in some forums that the nand flash must be activated in the u-boot
>> before it can be configured via dts.
> 
> You definitely need to set up the CS line for the NAND before using it
> in Linux.  Typically this is done in U-Boot, but in a pinch it can be
> done in the platform support code (arch/powerpc/platforms/52xx/*)

Yep, and also the R/B pin should be handled somehow, preferably using
the OF GPIO interface.

Wolfgang.
