Date: Tue, 6 Apr 2004 15:02:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tolunay Orkun <listmember@orkun.us>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question on RTC options (CONFIG_RTC, CONFIG_GEN_RTC, CONFIG_PPC_RTC)
Message-ID: <20040406220221.GG31152@smtp.west.cox.net>
References: <15133.216.110.51.8.1081278001.squirrel@www.orkun.us> <20040406200057.GB31152@smtp.west.cox.net> <19625.216.110.51.8.1081285199.squirrel@www.orkun.us> <20040406211439.GD31152@smtp.west.cox.net> <20701.216.110.51.8.1081286606.squirrel@www.orkun.us> <20040406213226.GE31152@smtp.west.cox.net> <22219.216.110.51.8.1081288263.squirrel@www.orkun.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22219.216.110.51.8.1081288263.squirrel@www.orkun.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 06, 2004 at 04:51:03PM -0500, Tolunay Orkun wrote:

> > On Tue, Apr 06, 2004 at 04:23:26PM -0500, Tolunay Orkun wrote:
> >
> > The generic driver makes use of the ppc_md.*_rtc_time hooks, so that's
> > the right place to start.  See include/asm-ppc/genrtc.h for the
> > PPC-specific portions of the genrtc driver, and these bits are what have
> > to return the right values for your board/rtc chip.
>
> Thanks. I will look to implement these functions.
>
> Do you happen know what it would take to use the DS1307 driver from LM
> Sensors package? Has anyone used LMSensors with PPC Linux?

LM Sensors implies i2c, which means you'd have to use that, or add a few
more hooks to genrtc (a probe is required for i2c, but not others, maybe
others) to get it working w/ that driver.  But you'd still be using the
main i2c subsystem, which I think you've said is too heavy.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
