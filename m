Message-Id: <5.1.0.14.2.20030228104732.02da48d0@mail.ebshome.net>
Date: Fri, 28 Feb 2003 11:08:33 -0800
To: KISHINAMI Masaya <kishinami@cs.fujitsu.co.jp>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: 405GP Networking issue
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200302281227.AA02348@kishinami.cs.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 04:27 AM 2/28/2003, KISHINAMI Masaya wrote:
>We are debugging a custom board designed based on the 405GP
>(200MHz) and have a problem not being sent ECHO REPLY ping
>packet from custom board to our PC via repeater hub on the
>heavy traffic under 10Mbps and half duplex condition.
>We used the latest version of ibm_ocp LAN device driver at
>that time from kernel 2.4.21-pre3 and ported it to work on
>the kernel 2.4.18 because it costs many time to boot our
>custom board on the latest one. The board works fine unless
>not be such a case.


>    - Logic analyzer captured the same ping packet which was
>      already been captured by LAN analyzer between PHY(Intel
>      LXT971A) and EMAC. It shows ECHO REQUEST was reached just
>      before the EMAC.


If other obvious _software_ errors were eliminated (like incorrect
duplex/speed settings etc) you can check _hardware_ related problems:

Please, check the quality of the clock between PHY and EMAC (MII clock).
We had some problems with this Intel PHY and IBM 440GP when PHY generated
clock was _slightly_ out of spec for IBM CPU.

You can try to increase MII drive strength in LXT971A Digital Config
register (26), write 0x0800 to it.

Make sure that your design uses _crystal_ based oscillator for PHY
clock, not PLL based. This is _general_ observation regarding PHY clock
in any designs (not just 4xx based)

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
