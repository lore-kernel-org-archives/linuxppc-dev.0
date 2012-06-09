Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D3692B6FD4
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2012 08:59:22 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/15] i2c/powermac: Register i2c devices from device-tree
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <1334823416-9138-2-git-send-email-benh__33169.052625499$1334826821$gmane$org@kernel.crashing.org>
 <m2r4tofuxr.fsf@igel.home> <1339279889.24838.93.camel@pasglop>
 <m2k3zgf79j.fsf@igel.home> <1339281364.24838.94.camel@pasglop>
Date: Sun, 10 Jun 2012 00:59:18 +0200
In-Reply-To: <1339281364.24838.94.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Sun, 10 Jun 2012 08:36:04 +1000")
Message-ID: <m2fwa4f5x5.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2012-06-10 at 00:30 +0200, Andreas Schwab wrote:
>> > Should we keep the tas_create method for those ? We could have some code
>> > in the aoa core file that calls those "fixups" to create missing
>> > devices...
>> 
>> I'm not sure if the function is needed, if the device can be created in
>> i2c_powermac_register_devices.
>
> But it doesn't have a device-node ... does it ? Which machine is this
> btw ?

It's a PowerMac G5.  During booting I see this:

PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
i2c i2c-5: i2c-powermac: modalias failure on /ht@0,f2000000/pci@1/mac-io@7/i2c@18000/deq@6a
i2c i2c-5: i2c-powermac: invalid reg on /ht@0,f2000000/pci@1/mac-io@7/i2c@18000/i2c-modem
PowerMac i2c bus u3 1 registered
i2c i2c-6: i2c-powermac: modalias failure on /u3@0,f8000000/i2c@f8001000/cereal@1c0
PowerMac i2c bus u3 0 registered

The deq node has no compatible, perhaps the modalias can be constructed
out of the name instead?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
