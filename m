Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 45A42B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Jul 2010 03:13:02 +1000 (EST)
Received: from mail136-tx2 (localhost.localdomain [127.0.0.1])	by
	mail136-tx2-R.bigfish.com (Postfix) with ESMTP id F1380CD8157	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jul 2010 16:57:17 +0000 (UTC)
Received: from TX2EHSMHS035.bigfish.com (unknown [10.9.14.252])	by
	mail136-tx2.bigfish.com (Postfix) with ESMTP id AA95B5A804E	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jul 2010 16:57:17 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6JGv5CQ026844	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jul 2010 09:57:16 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6JHACg2024726	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 12:10:12 -0500 (CDT)
Date: Mon, 19 Jul 2010 11:57:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address
	via  proc
Message-ID: <20100719115703.7faffa4f@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTimJwnmf1YTPIy7OqdjseiUspzlxwRcjPMQ6Vv6j@mail.gmail.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279496491.10390.1725.camel@pasglop>
	<8388D248-51F3-4F36-BBE0-CDE9E278E65E@freescale.com>
	<AANLkTimJwnmf1YTPIy7OqdjseiUspzlxwRcjPMQ6Vv6j@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Matthew McClintock <msm@freescale.com>,
	Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 18 Jul 2010 22:32:38 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Sun, Jul 18, 2010 at 10:28 PM, Matthew McClintock <msm@freescale.com> wrote:
> > Upon first examining the details of getting kexec working on our platform I noticed our device tree passed from u-boot contained an additional memreserve section for the boot page. Subsequently, I've been trying to preserve the ones passed in for the kexec'ed kernel thinking anyone could add anything they wanted for their own particular needs and would quite possibly need those regions preserved across reboots.
> >
> > Recently, I've discovered the boot page address is given in the device tree as a property. So, for our platform (mpc85xx) in particular, I'm back to not needing the read the old memreserve sections... I can completely reconstruct the appropriate memreserve regions for kexec'ing from the information passed in the device tree.
> >
> > That isn't to say there might not be more memreserve regions that are not there for some valid reason. I'm not sure if we need to attempt to address another scenario where there are other memreserve regions. So this would be a good time to address this issue if anyone believes it is a worthwhile pursuit to have a mechanism to have memreserve regions persistent across kexec'ing - or any other reboot.
> 
> No, we haven't needed anything to date, so no sense trying to design a
> solution for a theoretical need.  Leave it be for now.

So why do we have memreserve at all?

If we honor it on the first boot, seems like we should keep that
information around on subsequent boots.  I wouldn't want to be the one
to have to debug when that theoretical need becomes actual. :-(

Or am I misunderstanding what this is trying to do?

-Scott
