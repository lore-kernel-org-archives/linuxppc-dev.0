Message-Id: <200303051037.AA02365@kishinami.cs.fujitsu.co.jp>
From: KISHINAMI Masaya <kishinami@cs.fujitsu.co.jp>
Date: Wed, 05 Mar 2003 19:37:15 +0900
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405GP Networking issue
In-Reply-To: <5.1.0.14.2.20030228104732.02da48d0@mail.ebshome.net>
References: <5.1.0.14.2.20030228104732.02da48d0@mail.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Eugene.

Thank you for your advice.

--- On Sat, 1 Mar 2003 04:08:33 +0900 Eugene Surovegin<ebs@ebshome.net> -san wrote:

>
>At 04:27 AM 2/28/2003, KISHINAMI Masaya wrote:
>>We are debugging a custom board designed based on the 405GP
>>(200MHz) and have a problem not being sent ECHO REPLY ping
>>packet from custom board to our PC via repeater hub on the
>>heavy traffic under 10Mbps and half duplex condition.
>>We used the latest version of ibm_ocp LAN device driver at
>>that time from kernel 2.4.21-pre3 and ported it to work on
>>the kernel 2.4.18 because it costs many time to boot our
>>custom board on the latest one. The board works fine unless
>>not be such a case.
>
>
>>    - Logic analyzer captured the same ping packet which was
>>      already been captured by LAN analyzer between PHY(Intel
>>      LXT971A) and EMAC. It shows ECHO REQUEST was reached just
>>      before the EMAC.
>
>
>If other obvious _software_ errors were eliminated (like incorrect
>duplex/speed settings etc) you can check _hardware_ related problems:
>
>Please, check the quality of the clock between PHY and EMAC (MII clock).
>We had some problems with this Intel PHY and IBM 440GP when PHY generated
>clock was _slightly_ out of spec for IBM CPU.
>
We have already been checked the quality of the clock and it
was good. However we'll check again. Today, we tried to duplicate
the ping lost case by another custom board designed based on 405GP
and no ping lost occurred on the same line loading condition what
we investigated before. The difference is hardware design (wiring
etc.) and SW(OS, LAN device driver etc.). Each custom board is
designed for another product. Therefor we'll check the difference
at the point of hardware(waveform etc.) and SW(configuration of
EMAC/PHY/MAL and so on).


>You can try to increase MII drive strength in LXT971A Digital Config
>register (26), write 0x0800 to it.
>
>Make sure that your design uses _crystal_ based oscillator for PHY
>clock, not PLL based. This is _general_ observation regarding PHY clock
>in any designs (not just 4xx based)
>

Fortunately, we have designed the same way what you've adviced.
Datasheet said don't use PLL. Before, 100Mbps transfer mode which
clock line is 25MHz was succeded. While the 10Mbps is 2.5MHz.
Therefore we think there is no matter about quality of clock.
Anyway we'll investigate again.

Regards, Kishinami

-----
KISHINAMI Masaya
Fujitsu Limited (Japan)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
