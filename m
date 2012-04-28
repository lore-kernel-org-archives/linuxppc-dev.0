Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 59757B6FE2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 08:48:21 +1000 (EST)
Message-ID: <1335653288.20866.15.camel@pasglop>
Subject: Re: Regression in 32-bit ppc kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Sun, 29 Apr 2012 08:48:08 +1000
In-Reply-To: <m2y5pflnqk.fsf@igel.home>
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop> <4F98117C.7080309@lwfinger.net>
 <1335390257.21961.53.camel@pasglop> <4F9ABD67.3060704@lwfinger.net>
 <1335565573.20866.7.camel@pasglop> <4F9B3398.9060701@lwfinger.net>
 <1335573757.20866.12.camel@pasglop> <4F9C3252.7020508@lwfinger.net>
 <m2y5pflnqk.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-04-28 at 20:23 +0200, Andreas Schwab wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
> 
> > I have done a little more debugging. The problem is definitely coming from
> > drivers/tty/serial/pmac_zilog.c. I am getting ChanB interrupts while open,
> > which causes the following code segment to return IRQ_NONE:
> >
> >        if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
> >                if (!ZS_IS_OPEN(uap_a)) {
> 
> s/uap_a/uap_b/?

Good catch... Let's see if that fixes it for Larry...

Cheers,
Ben.
