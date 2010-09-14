Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id D960FB70AA
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2010 06:05:50 +1000 (EST)
Received: from mail45-tx2 (localhost.localdomain [127.0.0.1])	by
	mail45-tx2-R.bigfish.com (Postfix) with ESMTP id 5428916881DD	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 20:05:47 +0000 (UTC)
Received: from TX2EHSMHS019.bigfish.com (unknown [10.9.14.253])	by
	mail45-tx2.bigfish.com (Postfix) with ESMTP id D0FEB18C804E	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 20:05:46 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8EK5fsR013097	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 13:05:41 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8EKKoJF029803	for <linuxppc-dev@ozlabs.org>;
	Tue, 14 Sep 2010 15:20:50 -0500 (CDT)
Date: Tue, 14 Sep 2010 15:05:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] hvc_console: fix dropping of characters when output
	byte channel is full
Message-ID: <20100914150539.45c0672e@schlenkerla.am.freescale.net>
In-Reply-To: <20100914204410.71942cdc@lxorguk.ukuu.org.uk>
References: <1282329921-24394-1-git-send-email-timur@freescale.com>
	<20100914121721.c8671ed8.akpm@linux-foundation.org>
	<20100914204410.71942cdc@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, amit.shah@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Sep 2010 20:44:10 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Yes, hvc_push() reschedules.  It doesn't sit in a tight loop burning
> > electrons!
> > 
> > Can we do something safer&smarter here?
> 
> 
> Its a printk handler - better to lose the bytes than hang the box. I
> think the current code is probably right.

Losing the bytes is unacceptable.  Even if an hvc backend erroneously
returns zero on a permanent error, the timeout should prevent hanging
the box for too long.

Though I suspect the right answer for us may be "don't use the hvc
layer".

-Scott
