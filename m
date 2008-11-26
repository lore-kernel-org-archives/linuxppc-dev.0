Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (mail2.gnudd.com [213.203.150.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDFF0DDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Nov 2008 21:33:31 +1100 (EST)
Date: Wed, 26 Nov 2008 11:20:42 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: nvbolhuis@aimvalley.nl
Subject: Re: too few bogoMips on MPC8313E-RDB ?
Message-ID: <20081126102042.GA11397@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <492D1CA5.2090007@aimvalley.nl>
References: <492D1CA5.2090007@aimvalley.nl> 
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> This is what a linux-2.6.x reports (for the MPC8313E running at 333 MHz):
> Calibrating delay loop... 83.20 BogoMIPS (lpj=166400)
> 
> Which can't be correct.
> 
> A MPC870 (running at 133 mhz) has ~ 131.07 BogoMIPS

Actaully, one-instruction-per-clock leads to BogoMIPS = MHz.

Your "loop per jiffies" value shows you make 332800 instructions per
jiffy (a loop is two instructions: increment and jump).

So most liker your timer tick runs at 1000 Hz but Linux is thinking
it's at 250Hz (332800 * 250 = 83.20 millions).

> Of course it's only a benchmark figure.

No, it's not a benchmark figure. It's the metric by which udelay() is
calculated. So your udelays (and mdelays) will be 4 times shorter than
required, and some hardware may be misbehaving as a result.

Hope this help
/alessandro, who however is not runing a powerPC these times
