Message-ID: <3D3D2E49.8000309@sysgo.de>
Date: Tue, 23 Jul 2002 12:22:01 +0200
From: Pavel Bartusek <pba@sysgo.de>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MDIO clock speed computation
References: <2702075D4DE2B043BF5EB82E9CFAD45B093B0D@mail1.mediatrix.com> <3D3C6233.3090007@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> The MII clock is not derived from the core speed, but rather the
> system/bus clock speed.  Up to this point, I don't believe there are
> any 8xx parts that are qualified to run beyond a 50 MHz CPU/bus
> speed, so the software is just fine.  If you are running something
> faster than a 50 MHz bus, you may want to look into this.


I thing that system clock and bus clock can be different (in terminology
of the MPC855T user manual)

MPC855T manual, section Clocks and Power Control:
"
GCLK1C/GCLK2C - Basic clocks supplied to the core, the data and
instruction caches, and MMUs.
GCLK1_50/GCLK2_50 - Optionally divided versions of GCLK1/GCLK2, which
are used to clock the GPCM and UPM in the memory controller and to
provide the CLKOUT output for the external bus.
.
.
.
 - General system clocks GCLK1C, GCLK2C, GCLK1, GCLK2
  - Memory controller and external bus clocks GCLK1_50, GCLK2_50
.
.
The MPC855T provides the capability to run the external bus and memory
controller at a lower frequency than the internal modules. This
capability is provided by the external bus frequency dividers. The
external bus clocks GCLK1_50 and GCLK2_50 are derived from GCLK1 and
GCLK2, as determined by the SCCR[EBDF].
"


MPC855T manual, MII_SPEED register:
"MII_SPEED controls the frequency of the MII management interface clock
(MDC) relative to system clock."

Jean-Denis Boyer wrote:

>> Since the divisor is 2 * MDCLOCK,
>> I would suggest something like:
>>
>>   (((bd->bi_intfreq + (2 * 2500000 - 1 )) / 2500000 / 2) & 0x3F) << 1;
>
OK. It is more correct.


--

----------------------------------------------------------------------
|                          Pavel Bartusek                            |
|                                                                    |
| Sysgo RTS GmbH,                     phone: +49 (0) 6136 9948-722   |
| Am Pfaffenstein 14                  fax:   +49 (0) 6136 9948-10    |
| D-55270 Klein-Winternheim           email: pba@sysgo.de            |
| Germany                                                            |
|                                                                    |
|       http://www.sysgo.de           http://www.elinos.com          |
|                                                                    |
----------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
