Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id AD3F2DDEFF
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 02:20:58 +1000 (EST)
Received: by gxk14 with SMTP id 14so988671gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 09:20:57 -0700 (PDT)
Message-ID: <fa686aa40808130920k2ff6d114w986ec4ce4e001ebe@mail.gmail.com>
Date: Wed, 13 Aug 2008 10:20:56 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 5121 pci 1/3] powerpc: 83xx: pci: Remove need for
	get_immrbase from mpc83xx_add_bridge.
In-Reply-To: <48A30772.4030508@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
	<20080813050924.GD17587@secretlab.ca> <48A3068F.20409@freescale.com>
	<48A30772.4030508@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 13, 2008 at 10:10 AM, Scott Wood <scottwood@freescale.com> wrote:
> John Rigby wrote:
>>
>> As I type this I'm coming to like the primary flag more and more.
>> I'm willing to change it to 'fsl,primary-pci-bridge' though I don't
>> really agree with your argument against the generic name.  It is in
>> the context of an 'fsl,pci-whatever' node so it does not have to be
>> specific.
>
> It *does* have to be specific; what if "primary" comes to mean something
> else in a broader context?

exactly

>> And maybe generic is good, a universal generic solution would be to
>> require all primary pci nodes to have the property then
>> pci_process_bridge_OF_ranges could get it out of the device node
>> instead of having it passed in.
>
> The "universal generic solution" would be to encode legacy I/O devices in
> the device tree, and fix Linux to not assume that they're all on one bus.

... So my argument is; since Linux is broken in this regard, hard code
the fix into the device driver and don't pollute the device tree with
stuff that doesn't actually describe the hardware.  In this case,
primary is entirely a Linux internal implementation detail that will
change in the future.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
