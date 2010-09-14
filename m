Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id 77FF8B6F0D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2010 05:38:15 +1000 (EST)
Received: from mail199-va3 (localhost.localdomain [127.0.0.1])	by
	mail199-va3-R.bigfish.com (Postfix) with ESMTP id 0528B14C0314	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 19:23:07 +0000 (UTC)
Received: from VA3EHSMHS022.bigfish.com (unknown [10.7.14.254])	by
	mail199-va3.bigfish.com (Postfix) with ESMTP id 4603624819C	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 19:22:44 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8EJMcEP024747	for <linuxppc-dev@ozlabs.org>;
	Tue, 14 Sep 2010 12:22:38 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8EJZCho014261	for <linuxppc-dev@ozlabs.org>;
	Tue, 14 Sep 2010 14:35:12 -0500 (CDT)
Date: Tue, 14 Sep 2010 14:22:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hvc_console: fix dropping of characters when output
	byte channel is full
Message-ID: <20100914142236.64547ec3@schlenkerla.am.freescale.net>
In-Reply-To: <20100914121721.c8671ed8.akpm@linux-foundation.org>
References: <1282329921-24394-1-git-send-email-timur@freescale.com>
	<20100914121721.c8671ed8.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: amit.shah@redhat.com, linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	Timur Tabi <timur@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Sep 2010 12:17:21 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 20 Aug 2010 13:45:21 -0500
> Timur Tabi <timur@freescale.com> wrote:
> 
> > hvc_console_print() calls the HVC client driver's put_chars() callback
> > to write some characters to the console.  If the callback returns 0, that
> > indicates that no characters were written (perhaps the output buffer is
> > full), but hvc_console_print() treats that as an error and discards the
> > rest of the buffer.
> > 
> > So change hvc_console_print() to just loop and call put_chars() again if it
> > returns a 0 return code.
> 
> Seems rather dangerous.  The upper layer will sit there chewing 100%
> CPU for as long as the lower layer is congested.

This is just for printk(), not user output.  This is exactly what
printk() has always done for real serial ports.

> > This change makes hvc_console_print() behave more like hvc_push(), which
> > does check for a 0 return code and re-schedules itself.
> 
> Yes, hvc_push() reschedules.

hvc_push() is not relevant to kernel console output.

hvc_console_write() currently does not reschedule anything.  It just
drops characters when busy.

-Scott
