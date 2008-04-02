Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33D3ADDEDD
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 22:01:25 +1100 (EST)
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20080402.195215.-1300526901.kouish@swc.toshiba.co.jp>
References: <20080402.195215.-1300526901.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Wed, 02 Apr 2008 22:00:52 +1100
Message-Id: <1207134052.10388.251.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-02 at 19:52 +0900, Ishizaki Kou wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > As you said, if read/write/in/out functions take device parameter,
> > > taking I/O function pointers into the dev_archdata structure should be
> > > the best solution. But they don't take device parameter, and they must
> > > search I/O function pointers with address parameter. I think it's
> > > better they search pointers from bus bridges, because access mothod
> > > for a device on its parent bus bridge, not device itself.
> > 
> > What I meant is that if the pointers are in dev_archdata, we can
> > populate with a different set of pointers for PCI vs. PCI-E.
> 
> I'm afraid I misunderstood your opinion.
> 
> My concern is how to find a device by address when I/O function
> pointers are in dev_archdata.
> 
> You must select the appropriate device with an address, because all
> I/O functions, read/write/in/out don't have device parameter. If the
> address is in MMIO space, you can set 'token' to the address to select
> the device. But in IO space, you can't set 'token' to the I/O port
> address. Thefore you must scan all devices to select the device.
> 
> Do you have any better solution?

No, you are right. The EEH code has a way to go back to the device but
it has significant overhead. Let's stick to your current approach.

Cheers,
Ben.
