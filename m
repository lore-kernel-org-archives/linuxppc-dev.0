In-Reply-To: <l03130300b2c736ad27de@[141.213.6.249]>
Date: Sun, 17 Jan 1999 13:57:11 +0100
To: linuxppc-dev@lists.linuxppc.org, mukesh agrawal <agrawal@ais.org>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PowerBook battery test
Message-Id: <19990117135711.016083@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 17, 1999, mukesh agrawal <agrawal@ais.org> wrote:

>here's what i get on my Powerbook 2400. The battery monitor CSM
indicates that
>	1. battery is fully charged (8 bars)
>	2. power in plugged in
>	3. battery is not charging
>
>Having fun with your batteries !
>
>Global battery status: 0x01, power: 0x5b
> [charger connected]
>1 batteries :
><1> 12.399994V
>     exp: 0s, min: -1s, max: -1s, timeUntilCharge: -1s
>     info - fl:0xa0, warn_level:0, resrv:0, bat_level:255
>       [battery installed]
>       [charger connected]
>
>
>Now calling PMU...
>
>0x68 (1) : r:3,s:03 -> 01 5b 35 00 00 00 00 00 00 00 00 00 00 00 00
>0x6b (1) : r:3,s:08 -> e5 00 b6 35 1a 61 00 00 00 00 00 00 00 00 00
>0x6f (1) : r:3,s:04 -> 05 53 52 00 00 00 00 00 00 00 00 00 00 00 00
>Trying to interpret 0x6f command:
> 00 [battery present]
> 01 [charger connected]
> 01 [battery charging]

It looks like the PMU reacts quite differently on the 2400, we'll
probably have to setup different code for 2400/3400/3500 and new G3 "Series". 

The 6f command seems to be returning something different. I get 10 bytes
of response, you get only 4 and the flags interpretation looks wrong.
(Could you try removing the battery and/or the charger and see what
happens with those flags).

So we definitely need a way to make the difference between those
different kinds of PowerBooks. (There are some issues with the backlight
too). I was thinking about using the presence of o-hare to recognize and
older model, this is a little bit "hackish" but should work.

I have added backlight control commands to /dev/pmu, I'll add some
battery status commands too, but I would like to make them independant of
the kind of machine.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
