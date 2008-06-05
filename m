Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.243])
	by ozlabs.org (Postfix) with ESMTP id B2A5BDE0E7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 04:47:04 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so2556493agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 11:47:03 -0700 (PDT)
Message-ID: <fa686aa40806051146h10d9add6ude64d59cedf08f7d@mail.gmail.com>
Date: Thu, 5 Jun 2008 12:46:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <20080605132735.3433f2af@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
	<48481373.8010706@freescale.com>
	<20080605132735.3433f2af@zod.rchland.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 12:27 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Thu, 05 Jun 2008 11:25:23 -0500
> Timur Tabi <timur@freescale.com> wrote:
>
>> Josh Boyer wrote:
>>
>> > And it does.  It does so by the unique "regs" properties and
>> > unit-names.  You can assign the index that the i2c subsystem needs
>> > based on probe order, like I already said.
>>
>> The probe order is not sufficient on platforms that specifically enumerate their
>> I2C (or whatever) devices.  For instance, in order to do audio playback on an
>> MPC8610, SSI1 needs to use DMA channel 0.  The SSI driver specifically needs to
>> find the register addresses for DMA channel 0.
>
> I don't understand this statement.  Are your I2C macros hot-pluggable?
> Can you dynamically add/remove an I2C engine on your hardware somehow?
> Are you mucking about with the DTB and randomly moving around the I2C
> node blobs so they probe order differs from boot to boot?
>
> If not, then the probe order will be static for every boot.  You can
> assign the index using a static int that is incremented after each node
> is discovered and the ordering of the devices will never change.  Can
> you explain why something like that isn't possible or sufficient?
>
> (And I'm talking about I2C, not DMA.  I don't care about DMA because
> this conversation will go off into the weeds if we start talking about
> cell-index and every possible device out there.)

I need to disagree here.  Behavior should never be dependent on device
tree order.  It should be absolutely fine for devices to be probed in
a different order and different bus ids to be assigned.

In Timur's case, it is absolutely appropriate to use cell-index and/or
a phandle to make sure it gets the correct DMA registers (which is
what cell-index is intended to solve).  It is not appropriate to
depend on that same number to also be the logical i2c bus number.

Cheers,
g.
>
> josh
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
