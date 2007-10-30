Return-Path: <SRS0=3mnK=PY=gmail.com=stefan.roese@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 57CC3DE1CD
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 22:21:48 +1100 (EST)
From: Stefan Roese <stefan.roese@gmail.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: Bootup support for watchdog with short timeout
	(touch_nmi_watchdog()?)
Date: Tue, 30 Oct 2007 12:16:14 +0100
References: <200710291522.27311.stefan.roese@gmail.com>
	<20071029194503.GB27646@csclub.uwaterloo.ca>
	<20071029215454.0d644ca7@vader.jdub.homelinux.org>
In-Reply-To: <20071029215454.0d644ca7@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710301216.15033.stefan.roese@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[added linuxppc-dev since it's PPC relevant too]

On Tuesday 30 October 2007, Josh Boyer wrote:
> On Mon, 29 Oct 2007 15:45:03 -0400
>
> lsorense@csclub.uwaterloo.ca (Lennart Sorensen) wrote:
> > On Mon, Oct 29, 2007 at 03:22:27PM +0100, Stefan Roese wrote:
> > > I'm trying to implement support for a board specific watchdog on a
> > > PPC440EPx board with a very short timeout. In this case, the watchdog
> > > has to be "kicked" at least every 100ms, even while booting and the
> > > real watchdog driver not running yet. While looking for trigger places
> > > in the kernel source, I noticed the already existing
> > > "touch_nmi_watchdog()" function, which seems to be doing what I need.
> > > Even if the name not exactly matches my hardware setup.
> > >
> > > My question now is, is it recommended to use this
> > > touch_nmi_watchdog() "infrastructure" for my PPC custom specific
> > > watchdog during bootup? And if yes, should it perhaps be renamed to a
> > > more generic name, like "touch_watchdog"?
> > >
> > > Please advise. Thanks.
> >
> > No idea really.  Who would design a watchdog with such a short trigger
> > time?  That doesn't seem to be useful in any way.

It definitely is useful in our case, since its a requirement for 
this "critical" project. It's not needed to have such a short trigger time 
while booting, but unfortunately this external watchdog only supports one 
fixed timeout.

> To some degree, it's configurable.

No, I'm afraid it's not configurable in this case.

> But the generic question still 
> stands.  It seems like a decent idea to me.  Making touch_watchdog (or
> whatever it winds up being called) nice across arches might be fun.

I already have it running on my system using a quick hack (see patch below) in 
include/asm-ppc/nmi.h (yes, still arch/ppc for now :-( ). But for a clean 
implementation, that has chances for upstream merge (in arch/powerpc later), 
I would really like to hear if I should move on further this way. 

My impression is, that changing the name from touch_nmi_watchdog() to 
something like touch_watchdog(), and therefore touching lots of files, makes 
it more unlikely that this resulting patch will get accepted. But 
implementing this bootup watchdog support in asm-ppc(asm-powerpc)/nmi.h 
header seems also not totally correct, since it's not really an NMI in this 
case.

Any thoughts on this?

Thanks.

Best regards,
Stefan

diff --git a/include/asm-ppc/nmi.h b/include/asm-ppc/nmi.h
new file mode 100644
index 0000000..f18862b
--- /dev/null
+++ b/include/asm-ppc/nmi.h
@@ -0,0 +1,16 @@
+/*
+ *  linux/include/asm-ppc/nmi.h
+ */
+#ifndef ASM_NMI_H
+#define ASM_NMI_H
+
+#ifdef BOARD_WATCHDOG_FUNC
+#define touch_nmi_watchdog	BOARD_WATCHDOG_FUNC
+#else
+static inline void touch_nmi_watchdog(void)
+{
+	touch_softlockup_watchdog();
+}
+#endif
+
+#endif /* ASM_NMI_H */
