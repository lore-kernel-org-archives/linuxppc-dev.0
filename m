Date: Mon, 15 Dec 2003 22:06:23 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: Ricardo Scop <scop@digitel.com.br>
Message-ID: <3921.031215@digitel.com.br>
To: "Qsyang" <yangqs@163.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	"slowforce@21cn.com" <slowforce@21cn.com>, "wd@denx.de" <wd@denx.de>
Subject: Re[2]: close to porting success.....
In-reply-To: <200312150217.UAA04849@lists.linuxppc.org>
References: <200312150217.UAA04849@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Qsyang,

Sunday, December 14, 2003, 11:21:08 PM, you wrote:

Q>      Thanks a million. My BDI2000 configuration file is quite simple
Q> because i try to keep a "clean" CPU environment when using BDI
Q> Debugger.The config file is printed below:

Q>      [INIT]
Q>      ; init core register
Q>      WSPR       149             0x2006000F      ;DER  : enable SYSIE for BDI flash progr.

Q>      WSPR       638             0xFF000000      ;IMMR : internal memory at 0xFF000000
Q>      WSPR       158             0x00000007      ;ICTRL: not serialized, no show cycles
Q>      ; init SIU register
Q>      WM32       0xFF000000      0x00200400      ;SIUMCR
Q>      WM32       0xFF000004      0xFFFFFF03      ;SYPCR  :enable bus monitor, disable software watchdog

Q>      [TARGET]
Q>      CPUTYPE        MPC800
Q>      CPUCLOCK    50000000       ;the CPU clock rate after processing the init list
Q>      ....................
Q>      ....................

Q> What's wrong in this file? I don't think anything mentioned here
Q> about UPM, so...?

So, mas guess was wrong :(. SDRAM initialization is done in uBoot...
and works well whilw running with a BDI2000.

Sorry, I'm out of ideas right now :(

Good luck,

-Scop.

>>MPC8xx's sdram initialization is related to UPM init and this is not
>>so simple. Copy the initialization code from BDI2000 to uboot
>>
>>>  I am porting U-boot-1.0.0 to my custom MPC8xx board and success is
>>> being expectted coming soon(maybe too conceited^&^). Now i have a
>>> question which describes below. So far it is working fine when i am
>>> using BDI2000 and runing 'BDI>go 0x02800100' in Telnet console,and
>>> then all the U-boot commands are working very well. But when i
>>> disconnected BDI and power on board directly ,U-Boot crasheed after
>>> relocation to RAM. FAQ say that SDRAM initialization is bad ,if
>>> this is the case why it is OK when using BDI to boot it. What's the
>>> difference between the two conditions? Maybe some hardware problem?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
