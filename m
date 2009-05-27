Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 16F02DE02E
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 13:12:34 +1000 (EST)
Received: by qyk34 with SMTP id 34so7131975qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 20:12:32 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <9e4733910905261801p130f50afie2c50d5723192d44@mail.gmail.com>
References: <20090527002530.16740.62502.stgit@terra>
	<ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
	<9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
	<ed82fe3e0905261753v1cb9c901i3b66cd903e4adda6@mail.gmail.com>
	<9e4733910905261801p130f50afie2c50d5723192d44@mail.gmail.com>
Date: Tue, 26 May 2009 22:12:32 -0500
Message-ID: <ed82fe3e0905262012r58f8a750lab9cb1bf3b9a989@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
From: Timur Tabi <timur@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 8:01 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> Then why did you need to make your routine that calls cpu_relax()?

That gets called only if delay == 0.  udelay(0) is a no-op, so if the
caller specifies no delay, then I need to manually call cpu_relax().

> I don't know what goes on in the guts of HMT_low() and cpu_relax(),
> when you guys decide which one I should use let me know and I can
> adjust the patch.

Grant, I don't see any reason why "udelay(50)" is unacceptable.

-- 
Timur Tabi
Linux kernel developer at Freescale
