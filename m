Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.250])
	by ozlabs.org (Postfix) with ESMTP id 49AA4DDF4A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:07:33 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so2985334agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 21:07:31 -0700 (PDT)
Message-ID: <fa686aa40806052107r4f5903e6t1e408dff4dfa4eed@mail.gmail.com>
Date: Thu, 5 Jun 2008 22:07:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"Scott Wood" <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	"Stefan Roese" <sr@denx.de>, "Timur Tabi" <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <20080605024140.GA30980@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<20080605024140.GA30980@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 4, 2008 at 8:41 PM, David Gibson <dwg@au1.ibm.com> wrote:
> On Wed, Jun 04, 2008 at 09:19:42PM -0500, Josh Boyer wrote:
>> On Wed, 4 Jun 2008 10:43:51 -0500
>> Scott Wood <scottwood@freescale.com> wrote:
>>
>> > On Wed, Jun 04, 2008 at 10:24:15AM -0500, Timur Tabi wrote:
>> > > Stefan Roese wrote:
>> > > > I'm wondering what is currently recommended in the I2C device tree nodes? The
>> > > > current IBM I2C driver (i2c-ibm_iic.c) checks "index" and most FSL dts files
>> > > > use "cell-index". Some 4xx dts files implement "cell-index" some have no
>> > > > index at all.
>> > > >
>> > > > So what should be used here. Please advise and I'll prepare a patch for it.
>> > >
>> > > I just posted a patch for the FSL I2C driver to check for cell-index.  I'm under
>> > > the impression that cell-index is the standard for enumerating devices in the
>> > > device tree.
>> >
>> > No, it's the standard for correlating devices with portions of a shared
>> > register block elsewhere.  Your use in the I2C node is merely a hack to
>> > deal with Linux wanting to deal with indices rather than pointers,
>> > combined with a lack of a decent way to look up a device struct from the
>> > device node.
>>
>> So if possible, I'd like to eliminate the *index stuff all together
>> from the 4xx driver.  The private data structure contains an idx
>> parameter, but this can be populated based on probe order or something.
>>
>> >From a device tree perspective, index and cell-index are both
>> incorrect.  The IIC macros don't share register blocks with anything,
>> are enumerated as unique instances per macro in the device tree, and
>> should be able to be distinguished by "regs" and/or unit address.
>>
>> Does anyone disagree with that?
>
> Hear, hear.
>
> Aliases can also provide a reasonable way of enumerating devices, if
> "reg" isn't suitable on its own.  Though obviously, drivers will need
> some sort of fallback if suitable aliases don't exist in the tree.

The fallback is to just let the i2c layer auto-assign an ID.  The only
reason I can think of to want to assign a specific id to an i2c bus is
so that a userspace application can reference a specific bus.  The
drivers really shouldn't care.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
