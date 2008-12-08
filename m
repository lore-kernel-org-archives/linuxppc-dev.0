Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id 51FBBDDEE4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 10:40:52 +1100 (EST)
Date: Mon, 08 Dec 2008 15:40:40 -0800
Subject: Re: PPC4xx ECC Configs, Defines and Source
From: Grant Erickson <gerickson@nuovations.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Message-ID: <C562F078.1353A%gerickson@nuovations.com>
In-Reply-To: <20081208181006.6900303b@zod.rchland.ibm.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/8/08 3:10 PM, Josh Boyer wrote:
> On Mon, 08 Dec 2008 14:08:01 -0800
> Grant Erickson <gerickson@nuovations.com> wrote:
> 
> Well, at the moment CONFIG_PPC4xx_IBM_DDR2 doesn't exist, and has no
> meaning.  Adding a Kconfig option for it just so you can select an ECC
> option seems superfluous.  Because if you select no for ECC, then you
> have a Kconfig option that does nothing.  You could simply have:
> 
> CONFIG_4xx_IBM_DDR2_ECC
> 
> or something like that.

Reasonable enough.

> I'll buy that.  Just start with ppc4xx_ecc.c with your initial support
> and then we can refactor as other implementations get added (if they
> do).

Sounds good.

>>         SDRAM0: memory-controller {
>>             compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
>>             dcr-reg = <0x010 0x002>;
>>             ...
>>             interrupt-parent = <&SDRAM0>;
>>             interrupts = <0x0 0x1>;
>>             interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
>>                              /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
>>             ...
>>         };
> 
> More like this one.
> 
>> or some such. My DTS expertise is near zero and growing.
> 
> That's pretty darn good so far.

Great, thanks.

> Just to make sure, are you planning on just implementing a driver to
> deal with whatever settings the bootloader configured?  E.g., if ECC is
> enabled deal with correctable/uncorrectable errors and if not, do
> nothing?  Basically you are looking to implement a scrub driver, yes?
> 
> I ask because since ECC is memory module specific and memory controller
> setup is pretty tricky, I think it's best to leave whatever
> configuration the bootloader set and work with that.  Having to redo
> memory controller setups in Linux to enable ECC isn't something I'd
> look forward to.

Precisely. The driver will basically check if ECC is enabled (as was set/not
set by u-boot) and, if so, will take ECC SEC/DED interrupts, log SEC errors
to some data structure fetchable by a proc entry or some device node. For
DED errors, execute on some policy, at its simplest, generating a panic.

At no point will the driver/code attempt to change the controller
configuration beyond reading/clearing ECC event/interrupt status.

Regards,

Grant
