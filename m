Return-Path: <david-b@pacbell.net>
Received: from smtp102.sbc.mail.gq1.yahoo.com (smtp102.sbc.mail.gq1.yahoo.com
	[67.195.15.61]) by ozlabs.org (Postfix) with SMTP id 5E2211007D3
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 17:43:07 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/4] gpiolib: Introduce chip addition/removal notifier
Date: Mon, 25 Jan 2010 22:34:29 -0800
References: <20100125180957.GA5380@oksana.dev.rtsoft.ru>
	<20100125181100.GA13805@oksana.dev.rtsoft.ru>
In-Reply-To: <20100125181100.GA13805@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201001252234.30169.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 25 January 2010, Anton Vorontsov wrote:
> 
> +config GPIOLIB_NOTIFIER
> +       bool
> +       help
> +         This symbol is selected by subsystems that need to handle GPIO
> +         chips addition and removal. E.g., this is used for the
> +         OpenFirmware bindings.
> +

I'm no huge fan of notifiers, but I suppose they have their place.

However ... I don't see a lot of win to making this optional.  Just
inline the little two blocking_notifier_call_chain() calls directly,
making this a *LOT* simpler.

- Dave
