Return-Path: <john.bonesio@xilinx.com>
Received: from outbound10-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 89B0FDE1B2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Apr 2008 08:59:53 +1000 (EST)
From: John Bonesio <john.bonesio@xilinx.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: XLlTemac  soft lockup BUG
Date: Wed, 16 Apr 2008 15:59:47 -0700
References: <16711066.post@talk.nabble.com>
	<42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail>
	<16734685.post@talk.nabble.com>
In-Reply-To: <16734685.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <20080416225949.92427BD8076@mail18-sin.bigfish.com>
Cc: khollan <khollan@daktronics.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kevin,

Does xlltemac_main.c have
    #define MARVELL_88E1111_PHY
in it? If not, try setting that.

It's odd that sometimes it works. Does your system meet timing?

We've found that when the PHY is being poked, it can take a while before the PHY settles down and starts working. If the code tries to start using the PHY too soon, then the PHY never seems to get to a good state. So, you might experiement with different values in the udelay() call in _XLlTemac_SetOperatingSpeed().

If you really think there's something wrong in the fifo code, you can enable debug (#define DEBUG) in the following files:
drivers/xilinx_common/xdebug.h
drivers/xilinx_common/xstreamer.h

Perhaps that will shed some light on the problem.

- John


On Wednesday 16 April 2008 15:08, khollan wrote:
> 
> Hugo Villeneuve-3 wrote:
> > 
> > Hi,
> > we had a similar error message, which was caused by us selecting the wrong
> > PHY type in the kernel configuration menu (latest linux-2.6-xlnx-git
> > tree). In fact, we had to modify the lltemac driver to support our PHY
> > (BCM5466). Once we did that, the error message went away.
> > 
> > Hugo V.
> > 
> I tried out all 3 configurations and it didn't seem to help.  We are using
> the Marvell Phy on our prototype.  The weird thing is it seems to work
> perfectly every once in awhile, but not very often.  I seem to have tracked
> the problem to the FifoRecvHandler tasklet function in xlltemac_main.c it
> gets stuck in this while loop:
> while (XLlFifo_RxOccupancy(&lp->Fifo) != 0) {
> the XLlFifo_RxOccupancy always reads the same value.
> Any ideas?
> 
> Thanks
> Kevin
> -- 
> View this message in context: http://www.nabble.com/XLlTemac--soft-lockup-BUG-tp16711066p16734685.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
