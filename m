Message-ID: <40E48E1D.4080404@iti.fi>
Date: Fri, 02 Jul 2004 01:20:13 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Cc: Wolfgang Denk <wd@denx.de>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 PCI not working
References: <20040701091858.A3564C109F@atlas.denx.de>	 <40E3F73A.60607@iti.fi> <1088685514.6235.78.camel@lucy.pep-kaufbeuren.de>
In-Reply-To: <1088685514.6235.78.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Nickl wrote:

>On Thu, 2004-07-01 at 13:36, Kate Alhola wrote:
>
>
>>>I've updated the table to include  the  settings  for  the  Rev.  4.0
>>>board, too, and to list ALL jumpers on the board.
>>>
>>>
>>>
>>>
>>>
>>>>OK. Please see http://www.denx.de/twiki/bin/view/DULG/CoralPInstallation
>>>>
>>>>
>
>Great documentation, thanks!
>
>
>
>>I have Rev 3.0 board with analog switch type EL4331. To get it working
>>even in bypassed mode
>>it needs PD ( Power down ) input in pin 14 to grounded ( connect example
>>to pin 10 ).
>>
>>
>
>The Rev 5.0 board has J251 "PDN EN" (apparently documented nowhere
>except for the DULG) for that purpose. When set, Pin 14 is grounded.
>
>But it didn't help much. I took random shots at the CORALVO[RGB] signals
>on the extension connector, and even there, the red and green channels
>are only half the amplitude as the blue channel with a typical
>grey-on-black linux startup screen. The picture also looks dim-blueish.
>
>
It is wery strange, symproms are exactly sama than with this analog
switch problem
with 3.0 board........

>I think I'll try the board in a Windows box in the next step ...
>
>
>
You can try it in normal PC Linux box also. So did i when i tested
driver before denx driver.

>>With this modification my board works.  I am running Embedded QT but it
>>looks a like that
>>#define QT_QWS_REVERSE_BYTE_ENDIANNESS in
>>qt-embedded-free-3.3.2/src/kernel/qgfxraster_qws.cpp was not enough to get
>>colours right. Needs just more hacking code for fixing endianes problem.
>>
>>
>
>We're running qte 3.1.1 on the Asilient chip (cpu is MPC8245),
>and we didn't have to hack Qt for this, hmm ...
>
>
There is generic problem in these Fujitsu Display cobntrollers chips
that their
byte ordering (endianism) does not match with powerPC. So when used
in 32 bit pixels the R, G and B bytes does not match normal way used by
linux Frame buffer devices. Most of  chips allow configuration for little or
big endian based on CPU but CoralP does not and this conversion must be
done by software. For this reason we are offering two display controller
solutions, CoralP and Rage Mobility M1.  There is some good things in
COralP and at the moment it is only chip specified for
extended temperature range.



Kate

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
