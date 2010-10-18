Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D8C4B70DC
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 03:06:41 +1100 (EST)
Received: from mail78-am1 (localhost.localdomain [127.0.0.1])	by
	mail78-am1-R.bigfish.com (Postfix) with ESMTP id AA847E0141	for
	<linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 16:06:36 +0000 (UTC)
Received: from am1ehsmhs008.bigfish.com (unknown [10.3.201.246])	by
	mail78-am1.bigfish.com (Postfix) with ESMTP id 762581A70046	for
	<linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 16:06:36 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9IG71ZP025313	for <linuxppc-dev@ozlabs.org>;
	Mon, 18 Oct 2010 09:07:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9IG6XNH000442	for <linuxppc-dev@ozlabs.org>;
	Mon, 18 Oct 2010 11:06:33 -0500 (CDT)
Date: Mon, 18 Oct 2010 11:06:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt common to
	elbc	devices
Message-ID: <20101018110631.22d6f081@udp111988uds.am.freescale.net>
In-Reply-To: <4CBC0B95.9010300@windriver.com>
References: <1287386552-10647-1-git-send-email-tie-fei.zang@freescale.com>
	<4CBC0B95.9010300@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: B07421@freescale.com, dedekind1@gmail.com, dwmw2@infradead.org,
	B25806@freescale.com, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
	B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 18 Oct 2010 16:55:49 +0800
"tiejun.chen" <tiejun.chen@windriver.com> wrote:

> Looks you always iounmap(fsl_lbc_ctrl_dev->regs) on position 'err' but here
> of_iomap() is already failed you should skip iounmap() fsl_lbc_ctrl_dev->regs
> again. So you should improve that as the following on 'err', or layout 'err' in
> gain.
> ------
> 	if(fsl_lbc_ctrl_dev->regs)
> 		iounmap(fsl_lbc_ctrl_dev->regs);
> 

It looks like iounmap(NULL) is a no-op, just like kfree(NULL).

-Scott
