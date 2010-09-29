Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 91132B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 18:47:59 +1000 (EST)
Message-ID: <4CA2FDA3.20704@windriver.com>
Date: Wed, 29 Sep 2010 16:49:39 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Parsing a bus fault message?
References: <2bef2051c143a8d6e619519b222016f9.squirrel@localhost>	<20100928153153.GA22485@ovro.caltech.edu>
	<20100928134554.323667e5@udp111988uds.am.freescale.net>
In-Reply-To: <20100928134554.323667e5@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=UTF-8
Cc: david.hagood@gmail.com, linuxppc-dev@lists.ozlabs.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Tue, 28 Sep 2010 08:31:54 -0700
> "Ira W. Snyder" <iws@ovro.caltech.edu> wrote:
> 
>> On Tue, Sep 28, 2010 at 09:26:51AM -0500, david.hagood@gmail.com wrote:
>>> Alternatively, can somebody see a hint in the message that I don't know
>>> enough to pick out? At this point, my code is trying to memcpy() from the
>>> PCIe bus (mapped via the outbound ATMU) to local memory, so the fault is
>>> either a) the ATMU is not accessible b) the ATMU is accessible but not
>>> mapped (which I would have thought the ioremap call I made would have
>>> handled) or c) the chip is not able to bus master on the PCI bus.
> 
> Check the LAWs, the outbound ATMU, and the PCI device's BAR.  Make sure

I also meet machine check exception if configure LAW improperly for PCI. (i.e.
unmatched PCIe controller id.)

>From you log looks 0xexxxxxxx should be your PCI space. So you can check if that
 fall into appropriate LAW configuration. Maybe you can post your boot log and
error log here.

> the address goes where you're expecting at each level.
> 
>>> Machine check in kernel mode.
>>> Caused by (from SRR1=149030): Transfer error ack signal
>> ^^^ this is the line that contains some critical info
>>
>> In the 86xx CPU manual, you should be able to find information about the
>> SRR1 register. Decoding the hex SRR1=0x149030 may help.

Actually 'Transfer error ack signal' is the result just after kernel decode
SRR1/MSSSR0.

>>
>> The kernel is telling you this is a TEA (transfer error acknowledge)
>> error. I've only seen this when I get an unhandled timeout on the local
>> bus. For example, a FPGA that has died in the middle of a request.
> 

I met this only one time when kernel access USB host controller REGs on one
mpc837x. But the same kernel is fine on another same version target. So I think
sometimes you have to check the hardware.

> I've seen it when you access a physical address that has no device
> backing it up.
>

Yes. This should be most common reason for machine check exception when we
access one address with cache inhibited.

>> On the PCI bus, I haven't seen this error. The 83xx PCI controller is
>> smart enough to return 0xffffffff when reading a non-existent device.
> 
> I believe that behavior is configurable.

I know 0xfffffffff will be returned by some PCI controller when PCI controller
access non-existent device. Because PCI controller can't get any response from
that non-existed device. So PCI controller think this 'read' should be aborted
by asserting bus to one known state, 0xffffffff. But I have to admit I really am
not sure if this is configured. I prefer to this behavior should be associated
to the given PCI controller fixed feature.

Tiejun

> 
> -Scott
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
