Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CCB5BB6FEB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 04:23:28 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression in 32-bit ppc kernel
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop> <4F98117C.7080309@lwfinger.net>
 <1335390257.21961.53.camel@pasglop> <4F9ABD67.3060704@lwfinger.net>
 <1335565573.20866.7.camel@pasglop> <4F9B3398.9060701@lwfinger.net>
 <1335573757.20866.12.camel@pasglop> <4F9C3252.7020508@lwfinger.net>
Date: Sat, 28 Apr 2012 20:23:15 +0200
In-Reply-To: <4F9C3252.7020508@lwfinger.net> (Larry Finger's message of "Sat,
 28 Apr 2012 13:09:22 -0500")
Message-ID: <m2y5pflnqk.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Larry Finger <Larry.Finger@lwfinger.net> writes:

> I have done a little more debugging. The problem is definitely coming from
> drivers/tty/serial/pmac_zilog.c. I am getting ChanB interrupts while open,
> which causes the following code segment to return IRQ_NONE:
>
>        if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
>                if (!ZS_IS_OPEN(uap_a)) {

s/uap_a/uap_b/?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
