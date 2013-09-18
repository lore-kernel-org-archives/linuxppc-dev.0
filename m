Return-Path: <carlos.crisostomo@sacnet.es>
Received: from jupiter.redparsec.com (jupiter.redparsec.com [82.98.162.152])
 by ozlabs.org (Postfix) with ESMTP id 803112C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 23:36:58 +1000 (EST)
Received: from [192.168.101.37] (unknown [109.235.20.18])
 (Authenticated sender: tco833c)
 by jupiter.redparsec.com (Postfix) with ESMTP id CFEDE41E801E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 14:58:07 +0200 (CEST)
Message-ID: <5239A5C1.2000809@sacnet.es>
Date: Wed, 18 Sep 2013 15:08:17 +0200
From: =?ISO-8859-1?Q?Carlos_Cris=F3stomo?= <carlos.crisostomo@sacnet.es>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: mpc52xx_uart.c : Possible bug with TTY_OVERRUN and clear error
 condition?
Content-Type: multipart/alternative;
 boundary="------------030203060105080103010607"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030203060105080103010607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

First of all, sorry for my english (I'm spanish).

At our company, we work in various projects in control systems and 
automation in industrial environment, mostly with embedded custom linux 
distributions with Freescale PowerPC processors (MPC5200b, MPC5125, 
P1022, MPC8536E...).

In one of our systems, we have a MPC5125 connected with an ARM Cortex 
processor by serial port (ttyPSCX) using the standard mpc52xx_uart.c 
driver. Suddently we have encountered a situation in serial 
communicationes where
all the incoming serial traffic has a '\0' in the end of each serial 
transmission.

Looking at the driver in our custom 2.6.33.7 kernel, the insertion of 
the '\0' is in line 1308, on the Overrun condition(TTY_OVERRUN), but 
looking at the code, this flag is never cleared (as they arein the line 
1297 in "clear error condition")until there is some
other error condition like TTY_BREAK, TTY_PARITY, TTY_FRAME.

We have resolved thisissue adding a clear error condition after the 
overrun increment in port->icount.overrun++; but perhaps this is not the 
best solution(dirty hack).

It has been discuted in 
http://linuxppc.10917.n7.nabble.com/mpc52xx-uart-c-Port-Overruns-td53175.html 
for kernel 2.6.24too.

Maybe we can send you a patch for the next commit, or can anyone 
evaluate it for the next release? As we can see, this is happening in 
the latest release of the Linus kernel treetoo (3.11).

Thank you.

Regards,
--
Carlos Crisóstomo Vals
Operating System Design Director
Product Development

Arteche Smart-Grid
Sistemas Avanzados de Control S.A.
Colquide 6, Portal 2,
28230 Las Rozas - Madrid - Spain
carlos_DOT_crisostomo_AT_sacnet_DOT_es

www.sacnet.es
www.arteche.com

--------------030203060105080103010607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <font size="-1"><font size="-1"><font size="-1">First of all, sorry
          for my english (I'm spanish)<font size="-1">.</font></font><font
          size="-1"><br>
          <br>
          At our company<font size="-1">, <font size="-1">w</font></font>e
          work <font size="-1">in var<font size="-1">ious projects <font
                size="-1">in control systems and automation in <font
                  size="-1">industrial environment, <font size="-1">mostly
                    with <font size="-1">embedded custom linux
                      distributions</font></font> with Freescale PowerPC
                  processo<font size="-1">rs</font></font></font></font></font>
          (MPC5200b, MPC5125, <font size="-1">P1022, MPC8536E<font
              size="-1">...)</font></font></font>.<br>
        <br>
        <font size="-1">In o<font size="-1">ne o<font size="-1">f our
              systems<font size="-1">, we have a MPC5125 connecte<font
                  size="-1">d with an ARM <font size="-1">Cortex
                    processo<font size="-1">r by serial port (ttyPSC<font
                        size="-1">X) using the standard mpc52xx_uart.c
                        driver. <font size="-1">Sudd<font size="-1">en<font
                              size="-1">tly <font size="-1">we have
                                encountered a situation in <font
                                  size="-1">serial communi<font
                                    size="-1">cationes whe<font
                                      size="-1">re<br>
                                      <font size="-1">all the incoming
                                        serial traffic has a '\0' <font
                                          size="-1">in the end of <font
                                            size="-1">each</font> serial
                                          transmission.<br>
                                          <br>
                                          <font size="-1">Looking at the
                                            <font size="-1">driver in <font
                                                size="-1">our custom
                                                2.6.33.7 kernel</font>,
                                              the insertion o<font
                                                size="-1">f the '\<font
                                                  size="-1">0' <font
                                                    size="-1">is in line
                                                    1308, <font
                                                      size="-1">on the
                                                      Overrun condition<font
                                                        size="-1">
                                                        (TTY_OVERRUN),
                                                        but looking at
                                                        the code, this
                                                        flag is never
                                                        cleared (as they
                                                        are<font
                                                          size="-1"> <font
                                                          size="-1">in
                                                          the line 1297</font>
                                                          in "clear
                                                          error
                                                          condition")<font
                                                          size="-1">
                                                          until the<font
                                                          size="-1">re
                                                          is some<br>
                                                          <font
                                                          size="-1">other

                                                          error
                                                          condition like
                                                          TTY_BREAK<font
                                                          size="-1">, <font
                                                          size="-1">TTY_PAR<font
                                                          size="-1">ITY,
                                                          TTY_FRAME<font
                                                          size="-1">.<br>
                                                          <br>
                                                          <font
                                                          size="-1">We
                                                          have resolved
                                                          this<font
                                                          size="-1">
                                                          issue adding a
                                                          clear error
                                                          condition
                                                          after the
                                                          overrun <font
                                                          size="-1">increment

                                                          in
                                                          port-&gt;ico<font
                                                          size="-1">unt.ov<font
                                                          size="-1">errun++;

                                                          but p<font
                                                          size="-1">erha<font
                                                          size="-1">ps
                                                          this <font
                                                          size="-1">is
                                                          not the <font
                                                          size="-1">best
                                                          solution<font
                                                          size="-1"><font
                                                          size="-1"> (<font
                                                          size="-1">dirty
                                                          hack).</font></font><font
                                                          size="-1"><font
                                                          size="-1"></font></font><br>
                                                          <br>
                                                          It has <font
                                                          size="-1">been
                                                          discuted in <a
class="moz-txt-link-freetext"
href="http://linuxppc.10917.n7.nabble.com/mpc52xx-uart-c-Port-Overruns-td53175.html">http://linuxppc.10917.n7.nabble.com/mpc52xx-uart-c-Port-Overruns-td53175.html</a>
                                                          for kernel
                                                          2.6.24<font
                                                          size="-1">
                                                          too.</font></font><br>
                                                          <br>
                                                          </font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font></font>Maybe

        <font size="-1">we can send you a patch for the next commit<font
            size="-1">, o<font size="-1">r can <font size="-1">anyone</font>
              <font size="-1">evaluate it for the <font size="-1">next
                  release? As we can see, this is happe<font size="-1">ning
                    <font size="-1">in <font size="-1">the latest <font
                          size="-1">release of the Linus kernel tree<font
                            size="-1"> too (3.11).</font><br>
                          <br>
                        </font></font></font></font></font></font></font></font></font>Thank

        you<font size="-1"><font size="-1"><font size="-1">.<br>
              <br>
              <font size="-1">Regards,<br>
              </font> </font></font></font></font></font>
    <div class="moz-signature">--<br>
      <font size="2"><font face="Verdana">Carlos Cri<font size="2">s&oacute;stomo
            Vals<br>
            <font size="2">Opera<font size="2">ting System <font
                  size="2">Design Director<br>
                  <font size="2">Product Development<br>
                    <br>
                    <font size="2">Arteche Smart-<font size="2">Grid<br>
                        <font size="2">Sistemas Avanzados de Control
                          S.A.<br>
                          <font size="2">Colquide 6, Portal 2,<br>
                            <font size="2">282<font size="2">30 Las
                                Rozas - Madrid - Spain<br>
                                carlos<font size="2">_DOT_</font>crisostomo<font
                                  size="2"><font size="2">_</font>AT<font
                                    size="2">_</font></font>sacne<font
                                  size="2">t<font size="2">_DOT_</font>es</font><br>
                                <br>
                                <font size="2"><a class="moz-txt-link-abbreviated" href="http://www.sacnet.es">www.sacnet.es</a><br>
                                  <font size="2">www.<font size="2">arteche.com</font></font><br>
                                </font></font></font></font></font></font></font></font></font></font></font></font></font></font><font
        size="2"><font face="Verdana"></font></font></div>
  </body>
</html>

--------------030203060105080103010607--
