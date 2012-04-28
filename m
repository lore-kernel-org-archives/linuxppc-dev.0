Return-Path: <larry.finger@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1B47B6FEB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 04:09:33 +1000 (EST)
Received: by iakh37 with SMTP id h37so2813907iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 11:09:30 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4F9C3252.7020508@lwfinger.net>
Date: Sat, 28 Apr 2012 13:09:22 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression in 32-bit ppc kernel
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop> <4F98117C.7080309@lwfinger.net>
 <1335390257.21961.53.camel@pasglop> <4F9ABD67.3060704@lwfinger.net>
 <1335565573.20866.7.camel@pasglop> <4F9B3398.9060701@lwfinger.net>
 <1335573757.20866.12.camel@pasglop>
In-Reply-To: <1335573757.20866.12.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2012 07:42 PM, Benjamin Herrenschmidt wrote:
>
> Ok, so you do have a serial port, probably two even :-) One of them is
> connected to the infra red transceiver and the other one is probably
> connected to the internal modem.
>
> (The modem itself might not use it, some of these machines use an
> i2s/i2c modem, some use a usb modem, but the serial port is wired to the
> connector regardless).

I have done a little more debugging. The problem is definitely coming from 
drivers/tty/serial/pmac_zilog.c. I am getting ChanB interrupts while open, which 
causes the following code segment to return IRQ_NONE:

        if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
                if (!ZS_IS_OPEN(uap_a)) {
                        pmz_debug("ChanB interrupt while open !\n");
                        goto skip_b;
                }
                write_zsreg(uap_b, R0, RES_H_IUS);
                zssync(uap_b);
                if (r3 & CHBEXT)

When this section is entered, r3 == 0x2 (CHBTxIP).

Larry
