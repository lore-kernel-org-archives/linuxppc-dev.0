Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A379B6F07
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2010 05:17:28 +1000 (EST)
Date: Tue, 14 Sep 2010 12:17:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] hvc_console: fix dropping of characters when output
	byte channel is full
Message-Id: <20100914121721.c8671ed8.akpm@linux-foundation.org>
In-Reply-To: <1282329921-24394-1-git-send-email-timur@freescale.com>
References: <1282329921-24394-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: amit.shah@redhat.com, linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 Aug 2010 13:45:21 -0500
Timur Tabi <timur@freescale.com> wrote:

> hvc_console_print() calls the HVC client driver's put_chars() callback
> to write some characters to the console.  If the callback returns 0, that
> indicates that no characters were written (perhaps the output buffer is
> full), but hvc_console_print() treats that as an error and discards the
> rest of the buffer.
> 
> So change hvc_console_print() to just loop and call put_chars() again if it
> returns a 0 return code.

Seems rather dangerous.  The upper layer will sit there chewing 100%
CPU for as long as the lower layer is congested.

> This change makes hvc_console_print() behave more like hvc_push(), which
> does check for a 0 return code and re-schedules itself.

Yes, hvc_push() reschedules.  It doesn't sit in a tight loop burning
electrons!

Can we do something safer&smarter here?
