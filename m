Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 08CCDDDE32
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 09:19:58 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1NMLqwh015083
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:21:52 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1NMJtFR251364
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:19:55 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1NMJt0C011821
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:19:55 -0500
Received: from zod.rchland.ibm.com (wecm-9-67-149-29.wecm.ibm.com
	[9.67.149.29])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1NMJsBL011817
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:19:55 -0500
Date: Sat, 23 Feb 2008 16:19:22 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3] [POWERPC] 4xx: Add support for AMCC 440EP Yosemite
	board
Message-ID: <20080223161922.13198ea7@zod.rchland.ibm.com>
In-Reply-To: <20080223160813.2f8d282b@zod.rchland.ibm.com>
References: <20080223160813.2f8d282b@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 23 Feb 2008 16:08:13 -0600
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> This small series of patches adds support for the AMCC 440EP Yosemite
> evaluation board.  This is the newer evaluation board for PowerPC 440EP
> chips, replacing the older Bamboo board.
> 
> This is just the initial round of patches, but they are functional.
> Also of note is that while all for on-board UARTs are enumerated in the
> DTS file, only two of them are usable on the board.  The other two have
> their "status" property set to disabled.  If used in conjunction with
> the of_device_is_disabled patches I just sent out, then devices for
> those won't be created.  This is not required.

Olof asked on IRC why even bother enumerating the extra UARTs.  I have
two reasons for this.

1) I want a user of the of_device_is_disabled patches, if only to show
it works and provide an example (it does work btw).

2) When I get to doing the EBC stuff for bamboo and yosemite, there are
devices that can come and go depending on dip switch settings (due to
pin sharing).  My nefarious plan is to enumerate all of the devices in
the device tree, and poke a status = "disabled" property into the ones
that are no longer usable because of the dip switch settings.  E.g.
EMAC1 becomes disabled if the NAND flash is enabled on Bamboo, etc.

josh
