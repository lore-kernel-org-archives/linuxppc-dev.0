Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Wed, 26 Nov 2008 15:41:48 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: too few bogoMips on MPC8313E-RDB ?
In-Reply-To: <492D5B38.3080709@aimvalley.nl>
Message-ID: <Pine.LNX.4.64.0811261538270.9133@vixen.sonytel.be>
References: <492D1CA5.2090007@aimvalley.nl>
	<20081126102042.GA11397@mail.gnudd.com>
	<492D5B38.3080709@aimvalley.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 26 Nov 2008, Norbert van Bolhuis wrote:
> Thanks for the answer, but that's not it.
> 
> I checked the jiffies variable, it increases about 250 times
> per second.
> So the (mpc83xx_defconfig) kernel perception (#define CONFIG_HZ 250) is OK.
> 
> It must be something else, I still think 83.20 BogoMIPS
> can't be correct for a MPC8313 running at 333 MHz.

On PPC, BogoMIPS depends on the decrementer frequency, not on the CPU clock.

Check `timebase' in /proc/cpuinfo, which is e.g. 79.8 MHz on a PS3 (while the
actual Cell processor runs at 3.2 GHz). That's why the PS3 gets only 159
BogoMIPS.

> Alessandro Rubini wrote:
> > > This is what a linux-2.6.x reports (for the MPC8313E running at 333 MHz):
> > > Calibrating delay loop... 83.20 BogoMIPS (lpj=166400)
> > >
> > > Which can't be correct.
> > >
> > > A MPC870 (running at 133 mhz) has ~ 131.07 BogoMIPS
> > 
> > Actaully, one-instruction-per-clock leads to BogoMIPS = MHz.
> > 
> > Your "loop per jiffies" value shows you make 332800 instructions per
> > jiffy (a loop is two instructions: increment and jump).
> > 
> > So most liker your timer tick runs at 1000 Hz but Linux is thinking
> > it's at 250Hz (332800 * 250 = 83.20 millions).
> > 
> > > Of course it's only a benchmark figure.
> > 
> > No, it's not a benchmark figure. It's the metric by which udelay() is
> > calculated. So your udelays (and mdelays) will be 4 times shorter than
> > required, and some hardware may be misbehaving as a result.
> > 
> > Hope this help
> > /alessandro, who however is not runing a powerPC these times

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
