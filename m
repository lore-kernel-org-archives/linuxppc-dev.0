Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A170A1A0484
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 01:21:13 +1000 (AEST)
Date: Fri, 18 Sep 2015 16:20:51 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 devicetree@vger.kernel.org, Sunil Goutham <sgoutham@cavium.com>,
 Robert Richter <rric@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
 Iyappan Subramanian <isubramanian@apm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Li Yang <leoli@freescale.com>, Keyur Chudgar <kchudgar@apm.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] Phy and mdiobus fixes
Message-ID: <20150918152050.GI21084@n2100.arm.linux.org.uk>
References: <20150918094625.GB21084@n2100.arm.linux.org.uk>
 <20150918095600.GC21084@n2100.arm.linux.org.uk>
 <20150918150128.GV2722@xsjsorenbubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150918150128.GV2722@xsjsorenbubuntu>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 18, 2015 at 08:01:28AM -0700, Sören Brinkmann wrote:
> Hi Russell,
> 
> On Fri, 2015-09-18 at 10:56AM +0100, Russell King - ARM Linux wrote:
> > Sorry guys, some of you will get the patches twice, as Sören's name
> > in the header caused vger to reject all the patches.
> 
> That is the first time I hear about an issue like that. I've been
> receiving patches fine thus far and nobody reported any rejections (by
> vger) to me. Is it some bounce on Xilinx/my side or is vger suddenly
> rejecting non-ascii chars or is something in the mail processing chain
> not properly encoding those chars?
> Please, let me know if I can help with the problem.

It's to do with how I generate the patch set and submit it to my MTA.
The result is that the header fields contain an ö.  Almost all MTAs
accept this despite it being questionable, but zmailer is extra fussy
and rejects this - and rejected the messages to lkml, netdev, etc.

Normally, the MUA would encode "Sören Brinkmann" in a header into a
7-bit ascii representation as "=?utf-8?B?U8O2cmVu?= Brinkmann".

It's one of the many issues of not using a MUA to send out patches.

It's also worth noting that git-send-email misses out mime headers
(or used to - which is why I have my own scripts for doing this)
which technically makes the bodies it mails out in violation of the
RFCs.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
