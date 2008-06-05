Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72140DFA40
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 04:28:15 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55ISBKU029070
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 14:28:11 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55IS0pj056678
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 12:28:03 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55IRulN004045
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 12:27:57 -0600
Date: Thu, 5 Jun 2008 13:27:35 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605132735.3433f2af@zod.rchland.ibm.com>
In-Reply-To: <48481373.8010706@freescale.com>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
	<48481373.8010706@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 05 Jun 2008 11:25:23 -0500
Timur Tabi <timur@freescale.com> wrote:

> Josh Boyer wrote:
> 
> > And it does.  It does so by the unique "regs" properties and
> > unit-names.  You can assign the index that the i2c subsystem needs
> > based on probe order, like I already said.
> 
> The probe order is not sufficient on platforms that specifically enumerate their
> I2C (or whatever) devices.  For instance, in order to do audio playback on an
> MPC8610, SSI1 needs to use DMA channel 0.  The SSI driver specifically needs to
> find the register addresses for DMA channel 0.

I don't understand this statement.  Are your I2C macros hot-pluggable?
Can you dynamically add/remove an I2C engine on your hardware somehow?
Are you mucking about with the DTB and randomly moving around the I2C
node blobs so they probe order differs from boot to boot?

If not, then the probe order will be static for every boot.  You can
assign the index using a static int that is incremented after each node
is discovered and the ordering of the devices will never change.  Can
you explain why something like that isn't possible or sufficient?

(And I'm talking about I2C, not DMA.  I don't care about DMA because
this conversation will go off into the weeds if we start talking about
cell-index and every possible device out there.)

josh
