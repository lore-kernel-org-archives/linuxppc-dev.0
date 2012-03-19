Return-Path: <memorylost@tin.it>
Received: from smtp1web.tin.it (smtp1web.tin.it [212.216.176.195])
 by ozlabs.org (Postfix) with ESMTP id 17A04B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 00:50:58 +1100 (EST)
Message-ID: <1362b34c116.memorylost@tin.it>
Date: Mon, 19 Mar 2012 14:45:39 +0100 (CET)
From: "memorylost@tin.it" <memorylost@tin.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: mpc5125 shared uart-spi driver
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_121009_20870813.1332164739392"
Reply-To: "memorylost@tin.it" <memorylost@tin.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_121009_20870813.1332164739392
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,
I am developing on a custom mpc5125 board.

The hardware people designed the board so that the console serial port (PSC1 as ttyPSC0) is "shared" with a 74HC595 shift register (!!),
which drivers some leds.
In other words: when I want to drive the leds I have to "switch" the port in spi mode, do the spi transfer, then return to uart serial mode.
A strobe pin allows not to disturb leds when uart mode is active.

This configuration surely will cause some glitches on the serial port, but finally it is not a big problem, since I use the serial console only as a debug help.
Uart works at 115200 bps, spi works at 10 MHz.

So I am trying to find a "nice and elegant" way to do this by (eventually) tweaking the spi driver : my first idea is
declaring in the dts file uart and spi on the same address, but "tweak" spi so that it does probe and then
puts the port as it was before probing (uart mode).
Then I should modify the spi driver so that before doing transfers it puts the port in spi mode, and after transfers
it puts back to uart.

Kernel is 2.6.29 .

Any suggestions are welcome...

Thanks,
regards

Lucio Dona'

 
------=_Part_121009_20870813.1332164739392
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,<br>I am developing on a custom mpc5125 board.<br><br>The hardware p=
eople designed the board so that the console serial port (PSC1 as ttyPSC0) =
is "shared" with a 74HC595 shift register (!!),<br>which drivers some leds.=
<br>In other words: when I want to drive the leds I have to "switch" the po=
rt in spi mode, do the spi transfer, then return to uart serial mode.<br>A =
strobe pin allows not to disturb leds when uart mode is active.<br><br>This=
 configuration surely will cause some glitches on the serial port, but fina=
lly it is not a big problem, since I use the serial console only as a debug=
 help.<br>Uart works at 115200 bps, spi works at 10 MHz.<br><br>So I am try=
ing to find a "nice and elegant" way to do this by (eventually) tweaking th=
e spi driver : my first idea is<br>declaring in the dts file uart and spi o=
n the same address, but "tweak" spi so that it does probe and then<br>puts =
the port as it was before probing (uart mode).<br>Then I should modify the =
spi driver so that before doing transfers it puts the port in spi mode, and=
 after transfers<br>it puts back to uart.<br><br>Kernel is 2.6.29 .<br><br>=
Any suggestions are welcome...<br><br>Thanks,<br>regards<br><br>Lucio Dona'=
<br><br>
------=_Part_121009_20870813.1332164739392--
