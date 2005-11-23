Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id CE094687E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 03:43:33 +1100 (EST)
Message-ID: <19EE6EC66973A5408FBE4CB7772F6F0A2105B2@ltnmail.xyplex.com>
From: "Autran, Guillaume" <gautran@mrv.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>,
	"'n_tbinh@yahoo.com'" <n_tbinh@yahoo.com>
Date: Wed, 23 Nov 2005 11:39:05 -0500
MIME-Version: 1.0
Content-Type: text/plain
Subject: RE: Booting hangs after "Calibrating delay loop..."
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I remember there is some race condition before calling set_dec(..) in time.c
Basically, what happens is that the external decrementer is set way before
the interrupt gets enabled. When we get to enable the interrupt, the
decrementer value already reached 0 and wrapped arround (at least in our
case). 
The fix was to comment the line in:
arch/ppc/kernel/time.c:330: set_dec(tb_ticks_per_jiffy);

And move it to:
arch/ppc/syslib/m8xx_setup.c
inside m8xx_calibrate_decr() just before setting up the interrupt for the
decrementer.

In time.c, you may also need to initialize stamp = get_native_tbl(); as this
variable may not have been initialized since you are using an external
decrementer.

Try that...

Guillaume.
