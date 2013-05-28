Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC9962C0301
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 10:30:04 +1000 (EST)
To: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: Re: SATA hang on 8315E triggered by heavy flash write?
From: Anthony Foiani <tkil@scrye.com>
References: <1369172643.1374.15@scott-Lenovo-G560>
 <gppwj3ayu.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1DFA93@039-SN2MPN1-013.039d.mgd.msft.net>
 <g8v362qg8.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E0FFA@039-SN2MPN1-013.039d.mgd.msft.net>
 <g4ndt3f5q.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E567D@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Mon, 27 May 2013 18:29:57 -0600
In-Reply-To: <ED492CCEAF882048BC2237DE806547C90B1E567D@039-SN2MPN1-013.039d.mgd.msft.net>
 (Xie Shaohui-B's message of "Mon\, 27 May 2013 07\:50\:17 +0000")
Message-ID: <g7gik2bga.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shaohio --

Once again, thanks for the reply.

Xie Shaohui-B21989 <B21989@freescale.com> writes:

> it seems [recovery or lack of recovery is] not due to speed limiting
> code, 1.5Gbps is still used to recover link.

Right, I noticed this in my later email on this topic.

> for the speed limit issue, I checked 3.4.rc7 kernel, there seems a
> place can be used to limit the speed for 8315:
>
> 	if (!of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc8315-sata")) {
> 		temp = ioread32(csr_base + TRANSCFG);
> 		temp = temp & 0xffffffe0;
> 		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base + TRANSCFG);
> 	} else {
> 		/* the speed limitation code for 8315 may can be put here.
> 		* just move the original code which wrapped by "#ifdef CONFIG_MPC8315_DS" here.
> 		* please let me know if you will give a try. */
> 	}

It's not clear that all uses of the MPC8315 SATA controller have this
problem.  It obviously occured on the 8315DS, but apparently that
board never made it to production; it might or might not happen on the
8315ERDB; and it clearly happens on my vendor's board.

Given this lack of knowledge, Scott Wood was very hesitant to
implement any far-reaching changes, because we could not pin down
exactly what had to be tested.

My original patch:

  http://article.gmane.org/gmane.linux.ports.ppc.embedded/58710

did the speed limiting directly in the sata_fsl code; Jeff Garzik
mentioned that there was some existing infrastructure for this, and I
inferred that he would prefer that I use it.

So that's what my final patch does, and it's keyed off a single OF
value.

There's a small chance that I'll have the opportunity to move the
project to 3.9 (especially if that release gets declared
long-term-stable).  Even then, I unfortunately won't have the
bandwidth to pursue getting any of these approaches into mainline.
The best I can do is get them onto the lists so that others might be
able to benefit later.

Either way, thanks again.  I'll try to put together a package for my
vendor to test with; once I have demonstrated that there is a problem
with their hardware, they have been gracious about accepting that
result and pursuing it with Freescale if necessary.

Thanks again for your help!

Best regards,
Anthony Foiani
