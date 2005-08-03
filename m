Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id F28D567E25
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 00:27:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 3 Aug 2005 16:27:43 +0200
Message-ID: <8E342283C2100540AAC5D103097054776F8533@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC885ADS and 2.6.13-rc5 - nogo ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]=20

> The board does not hang - there's somithing with=20
> console since you don't see anything.  Try to change=20
> BCSR_ADDR from 0xf4500000 to 0xf80...0 - the newer=20
> version of the boards may have this changed.

Hrm... arc/ppc/mpc885ads.h already reads

  /* U-Boot maps BCSR to 0xff080000 */
  #define BCSR_ADDR   ((uint)0xff080000)

And that's the same setting that my 2.4-Kernel
uses, so it should work with 0xff080000.

However, BCSR_SIZE looks suspicious in this header:

  #define BCSR_SIZE   ((uint)32)

Shouldn't that read:

  #define BCSR_SIZE   ((uint)32 * 1024)

??!?

Regards,

  Peter
