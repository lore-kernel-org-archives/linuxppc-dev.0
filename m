Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 4353CB710E
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Sep 2010 04:11:12 +1000 (EST)
Received: from mail144-tx2 (localhost.localdomain [127.0.0.1])	by
	mail144-tx2-R.bigfish.com (Postfix) with ESMTP id 68E54600147	for
	<linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 18:11:09 +0000 (UTC)
Received: from TX2EHSMHS034.bigfish.com (unknown [10.9.14.252])	by
	mail144-tx2.bigfish.com (Postfix) with ESMTP id 4560E18C804C	for
	<linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 18:11:09 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o7VIAvtl005173	for
	<linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 11:10:57 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o7VIOdu9004082	for <linuxppc-dev@ozlabs.org>;
	Tue, 31 Aug 2010 13:24:39 -0500 (CDT)
Date: Tue, 31 Aug 2010 13:10:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/3] PPC: Fix compilation of fsl_rio.c
Message-ID: <20100831131055.01e844d3@schlenkerla.am.freescale.net>
In-Reply-To: <1283220922-20369-3-git-send-email-agraf@suse.de>
References: <1283220922-20369-1-git-send-email-agraf@suse.de>
	<1283220922-20369-3-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, Thomas Moll <thomas.moll@sysgo.com>,
	Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 31 Aug 2010 04:15:21 +0200
Alexander Graf <agraf@suse.de> wrote:

> Commit a52c8f52 introduced machine check magic for the RapidIO chip.
> Unfortunately it was so magical that it used constants that aren't even
> defined!
> 
> This patch bluntly comments out the broken constant's usage. This
> probably means that said functionality thus doesn't work, but at
> least it makes it compile for me.

The MCSR_MASK is actually completely unnecessary -- it doesn't change
the result of testing bits that are within the mask.

Multiple patches have been posted for this already, including:
http://patchwork.ozlabs.org/patch/56135/

Someone just needs to apply it. :-)

-Scott
