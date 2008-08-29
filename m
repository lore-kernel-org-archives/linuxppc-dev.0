Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC737DE22E
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 11:24:22 +1000 (EST)
Date: Thu, 28 Aug 2008 18:22:01 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] leds: make the default trigger name const
In-Reply-To: <20080728095309.GA31809@polina.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0808281818400.3610@t2.domain.actdsltmp>
References: <Pine.LNX.4.64.0807181339500.10116@t2.domain.actdsltmp>
	<1217019705-24244-1-git-send-email-tpiepho@freescale.com>
	<20080727020857.GM12191@secretlab.ca>
	<20080727231149.1b2508da.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0807271304350.26456@t2.domain.actdsltmp>
	<20080728095309.GA31809@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Richard Purdie <rpurdie@rpsys.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The default_trigger fields of struct gpio_led and thus struct led_classdev
are pretty much always assigned from a string literal, which means the
string can't be modified.  Which is fine, since there is no reason to
modify the string and in fact it never is.

But they should be marked const to prevent such code from being added, to
prevent warnings if -Wwrite-strings is used and when assigned from a
constant string other than a string literal (which produces a warning under
current kernel compiler flags), and for general good coding practices.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
Reposting this again.  It still applies to powerpc-next as of Aug 28 and I
don't think anyone had any problems with it.

  include/linux/leds.h |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index d41ccb5..d3a73f5 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -123,7 +123,7 @@ extern void ledtrig_ide_activity(void);
   */
  struct led_info {
  	const char	*name;
-	char		*default_trigger;
+	const char	*default_trigger;
  	int		flags;
  };

@@ -135,7 +135,7 @@ struct led_platform_data {
  /* For the leds-gpio driver */
  struct gpio_led {
  	const char *name;
-	char *default_trigger;
+	const char *default_trigger;
  	unsigned 	gpio;
  	u8 		active_low;
  };
-- 
1.5.4.3
