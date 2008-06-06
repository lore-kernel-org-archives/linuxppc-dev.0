Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4FD48DE0F9
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 20:10:04 +1000 (EST)
Message-ID: <48490CF7.6050205@grandegger.com>
Date: Fri, 06 Jun 2008 12:09:59 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 1/4] [POWERPC] 85xx: add board support for the	TQM8548
	modules
References: <4847AC75.8080405@grandegger.com>
	<71165662-0864-4CDE-A1B3-29487253B85F@kernel.crashing.org>
	<20080605225215.GF30980@yookeroo.seuss>
In-Reply-To: <20080605225215.GF30980@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, Jun 05, 2008 at 08:43:51AM -0500, Kumar Gala wrote:
>> On Jun 5, 2008, at 4:05 AM, Wolfgang Grandegger wrote:
> [snip]
>>> +			timebase-frequency = <0>;	// from U-Boot
>>> +			bus-frequency = <0>;	// from U-Boot
>>> +			clock-frequency = <0>;	// from U-Boot
>> u-boot will add this for us so no need for them.
> 
> I think it's worth including them (with the comments) for
> documentation purposes though.  Plus allowing the bootloader and
> bootwrapper to just replace property values without resizing or
> inserting is somewhat worthwhile of itself.

I understand your point and while testing the new blob, I realized that
 the DTB image created with

 $ make ARCH=powerpc tqm8548.dtb

does not work because work space is missing:

  ## Flattened Device Tree blob at 00900000
     Booting using the fdt blob at 0x900000
     Loading Device Tree to 007fe000, end 007ff8e0 ... OK
  WARNING: could not create /chosen FDT_ERR_NOSPACE.
  ERROR: /chosen node create failed - must RESET the board to recover.

As I see it, I have to define DTS_FLAGS manually

  $ export DTS_FLAGS="-R4 -S0x3000"
  $ make ARCH=powerpc tqm8548.dtb

to get a working blob. Is that the intended behavior?

Wolfgang.
