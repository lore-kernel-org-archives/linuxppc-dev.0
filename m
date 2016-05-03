Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzcrF6NMDzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 20:30:21 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 geert@linux-m68k.org, deller@gmx.de, benh@kernel.crashing.org, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 12/16] rtc: powerpc: provide rtc_class_ops directly
Date: Tue, 03 May 2016 12:29:21 +0200
Message-ID: <3723014.RkUgaFBZte@wuerfel>
In-Reply-To: <1462248309.12788.4.camel@ellerman.id.au>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
 <1461796470-1291527-13-git-send-email-arnd@arndb.de>
 <1462248309.12788.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 03 May 2016 14:05:09 Michael Ellerman wrote:
> On Thu, 2016-04-28 at 00:34 +0200, Arnd Bergmann wrote:
> 
> > The rtc-generic driver provides an architecture specific
> > wrapper on top of the generic rtc_class_ops abstraction,
> > and powerpc has another abstraction on top, which is a bit
> > silly.
> > 
> > This changes the powerpc rtc-generic device to provide its
> > rtc_class_ops directly, to reduce the number of layers
> > by one.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/powerpc/kernel/time.c | 29 ++++++++++++++++++++++++++++-
> >  drivers/rtc/rtc-generic.c  |  2 +-
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> If this hits linux-next it will go through my automated boot testing, which
> hopefully would be sufficient to catch any bugs in this patch, cross fingers.
> 
> I don't know jack about all the layers of RTC mess, so my ack is basically
> worthless here. But if you like you can have one anyway 
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks!

The main thing that could use testing here is for patch 12/16 to see if
/sbin/hwclock can still read and write the time on a machine that
uses one of the genrtc backends on powerpc, this includes
rtas_get_rtc_time, mpc8xx_get_rtc_time, maple_get_rtc_time,
ps3_get_rtc_time and pmac_get_rtc_time. Testing on a pSeries with rtas
should be sufficient, and if I made a mistake, it probably fails
spectacularly.

Just for reference, if anyone ever wants to clean this up further on
powerpc to remove all of the rtc handling from architecture code,
it has gotten easier after my series:

- The update_persistent_clock() and read_persistent_clock() callbacks
  are now unnecessary: as long as the RTC driver is built into the
  kernel, drivers/rtc/hctosys.c takes care of setting the initial
  time (otherwise user space has to do it), and the other users
  (ntp and suspend/resume) will work fine whenever an rtc driver
  is loaded. Obviously you will want to test the kernel better after
  removing the two functions.

- Once they are gone, the only users of the ppc_md.{get,set}_rtc_time
  callbacks are in the "const struct rtc_class_ops rtc_generic_ops".
  You can move them into the five files implementing those callbacks
  and call the functions directly to get rid of the function pointers.

- Lastly, after that is done, you basically have five independent
  rtc device drivers that can get moved to drivers/rtc and converted
  into regular platform drivers. Instead of registering the fake
  "rtc-generic" device, you then register the one that is actually
  there like arch/powerpc/sysdev/rtc_cmos_setup.c already does, or
  use the one that gets created from DT.

	Arnd
