Return-Path: <linuxppc-dev+bounces-13489-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9002CCF9E9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Oct 2025 07:30:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxJmS71G7z3bfF;
	Wed, 29 Oct 2025 18:30:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761723000;
	cv=none; b=oBsjqECGSKgLaGuGhq7dX5Zmj+hcfEt9wxwovpotNvFbsMXiwnbT8dmWkMIZdIYDRkruFzQepE77biUw9Sl/RVrV2JKZcUuNt73SGyed56UfahgpYdnvxCW8hf5c7QyLb2f061q0+vpll1/l/JnGcaMmRfaDsrqHs8Qz0+vHxgt8LuQxiqFDZFFg2KL3NFWiYqiCyZS72WpmAUPtiWN6cQkYrGxudP3II24tW27AG320mYngibxpuqGd4/MrrXrtR/TEJe8va/CNd4n9uRzohoChib2iLQIdteknCjpVOwAVuvElAYPPRq1a3AwCYG7za4Gvv/jT6xUCNnKRxdZJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761723000; c=relaxed/relaxed;
	bh=rN1xYOzN0J/jx0YMr9jPDedKW5tDPkNcv84LkBsf4yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGDEKaGQwirsJVZLXIUuDQxUecR8vPLxkh1vGMdBUH+HVS6Pm1JUr5BlSgwfxCUNHDwD8B6MvYjrMEylquKwGkoqOLzOog9qFC7cRb6hbnMUXLiCQjbIgJtstD3N5BNsACLP10+987hnxN/+PFM4AckQeSG8cb23FYmCUzFxwIhkgv+0JcB06ALOUexD1obZIVDWoW/7fOZH6EtjIfoCKko3RSbvrA0Nl+CAc0swT7mJdG7eZHh0qAst/i5ccoD8mriBUuPitGzGOsv2+lHOrk9cD2U5MFTpI0cWk7bOi9y5C60ziVitrwFK8eACYtsuhmukZOzZ8AL+TNDQ94ttMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxJmQ3hWtz30hP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2025 18:29:57 +1100 (AEDT)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 59T7TXwQ1010598;
	Wed, 29 Oct 2025 02:29:33 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 59T7TX9D1010589;
	Wed, 29 Oct 2025 02:29:33 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 29 Oct 2025 02:29:23 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Rob Herring <robh@kernel.org>
Cc: Stan Johnson <userm57@yahoo.com>, linuxppc-dev@lists.ozlabs.org,
        Finn Thain <fthain@linux-m68k.org>
Subject: Re: Excluded List for "#size-cells" warning
Message-ID: <aQHCU1pb7zT167rO@gate>
References: <70d76dcf-c7d4-43c5-c169-07054a37195c@yahoo.com>
 <78e43ec2-a60a-9876-9f03-c0ad92b7da1d@yahoo.com>
 <CAL_JsqJ8amo2ggUVfL=YzRrA9UnqKfKCipn-_yOkahJKZVs5=A@mail.gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJ8amo2ggUVfL=YzRrA9UnqKfKCipn-_yOkahJKZVs5=A@mail.gmail.com>

On Tue, Oct 28, 2025 at 08:17:27PM -0500, Rob Herring wrote:
> On Tue, Oct 28, 2025 at 7:05 PM Stan Johnson <userm57@yahoo.com> wrote:
> >
> > -------- Forwarded Message --------
> > Subject: Excluded List for "#size-cells" warning
> > Date: Tue, 28 Oct 2025 10:00:25 -0600
> > From: Stan Johnson <userm57@yahoo.com>
> > To: debian-powerpc@lists.debian.org
> > CC: Finn Thain <fthain@linux-m68k.org>, Christophe Leroy
> > <christophe.leroy@csgroup.eu>
> >
> > Hello,
> >
> > On a PowerBook G3 Pismo running the latest Debian SID, dmesg reports the
> > warning shown below. I've also seen the warning on PowerBook Lombard and
> > Wallstreet systems. I haven't checked PowerBook 3400c or Kanga.
> 
> Can you send me a dump of the device tree on these systems:
> 
> dtc -O dts /proc/device-tree
> 
> We've been fixing up these cases such as in commit 7e67ef889c9a
> ("powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7")

And of course it is perfectly fine for an actual Open Firmware to *not*
repeat the defaults.  As the documentation (the main IEEE 1275 thing)
says: "A missing “#size-cells” property signifies the default value of
one."  There are many other places in OF geared towards this default
btw, take for example the "reg" word, that silently assumes your node's
#size-cells is 1, and does completely the wrong thing if not.

Flattened device trees are a fine thing, but the gratuitous ways it
differs from OF, are not.


Segher

