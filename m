Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04020a00b52536252755@[192.168.0.2]>
In-Reply-To: <38FF1565.99905655@chpc.utah.edu>
Date: Thu, 20 Apr 2000 17:48:14 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Mike DeSimone <Hot-Wire@mail.utexas.edu>
Subject: Re: MiniDin9 serial pin outs to talk to DB9 UPS?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The cable I've made basically connects as follows:
>
> UPS (DB9)                          PowerMac7500 (MiniDin9)
> pin 1             recieve data     pin 3             TxD-
> pin 2             transmit data    pin 5             RxD-
> pin 4             common           pin 4             Gnd/Shield

Assuming the UPS is speaking RS232, you forgot one necessary connection:
RxD+ and Gnd must be connected together on the Mac side.  TxD+ should be
left floating.

>The other UPS (DB9) pin outs are:
>
>pin 3: normally open on battery contact
>pin 5: normally open low battery alarm
>pin 6: plug and play sense for Windows 95
>pin 7: remote shutdown
>pin 8: normally closed on battery contact
>pin 9: unused

Not really a whole lot you can do with these pins without a pullup resistor.

>pin 1: SCLK(out)   ---- I'm assuming this is DTR
>pin 2: Sync(in)/SCLK(in) ---- I'm assuming this is CTS
>pin 6: TxD+
>pin 7: Wakeup/TxHS ---- I'm assuming this is DCD
>pin 8: RxD+

Your assumptions are correct, though I usually see HSKi (handshake in)
instead of CTS, HSKo (handshake out) instead of DTR, and GPI (general
purpose input) instead of DCD.  Functionally, it's all the same, though.

>pin 9: +5V (power to pod) ---- what's a 'pod'?

Apple's GeoPort Telecom Pod.  It was a little box that contained a DSP that
could be programmed to be a modem.  Unfortunately, they didn't expect 56K
modems to get so cheap so fast, so few people bought the pod because it was
so expensive, and couldn't be anything more than a 33.6K or so modem.

In the old days, those serial ports had 8 pins, and you couldn't power
anything from them.  Several third party devices used ADB taps for this
purpose, which was rather kludgy.

>I was told that the PC serial cable connects similarly sparsely except
>that pins 4 and 6 on the PC end are jumpered together. That seems to be
>a short between TxD+ and DTR.

PC ports are RS232, so that jumper is really jumpering DTR and DSR.  Not
needed for the Mac's ports.  Just turn hardware handshaking off.
### Mike DeSimone ### Hot-Wire@mail.utexas.edu ### ares.marsbase.mars ###

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
