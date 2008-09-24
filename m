Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by ozlabs.org (Postfix) with SMTP id B2652DDF85
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 04:59:07 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] USB: driver for Freescale QUICC Engine USB
	=?iso-8859-1?q?Host=09Controller?=
Date: Wed, 24 Sep 2008 11:59:03 -0700
References: <20080918151659.GA20140@oksana.dev.rtsoft.ru>
	<20080923225730.GB13617@oksana.dev.rtsoft.ru>
	<48DA1544.5010307@ru.mvista.com>
In-Reply-To: <48DA1544.5010307@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809241159.04427.david-b@pacbell.net>
Cc: leoli@freescale.com, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 24 September 2008, Sergei Shtylyov wrote:
> 
> >>   ... then the root hub emulation is completely pointless.
> >>     
> >
> > It isn't. We always should emulate the root hub. The root hub
> > is part and parcel of any USB Host. Even the one-port one.
> 
>    Hm, maybe that's what USB core thinks (because UHCI/OHCI/EHCI all 
> have it) but e.g. MUSB doesn't have the root hub registers...

Only the OHCI registers have bit positions matching what the USB
spec says for hub status bits.  Everything else, including musb_hdrc,
has the relevant status encoded in other bits.


> I looked at the core and figured that USB core seems to use the root hub 
> interface for port PM, etc. and expects it to bee present, so it seems 
> unavoidable indeed... :-/

Or more fundamentally:  for enumeration.  "Unavoidable" is correct.  ;)
