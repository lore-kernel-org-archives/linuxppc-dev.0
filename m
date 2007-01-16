Return-Path: <andrea.galbusera@teamware.it>
Received: from smtp3.aruba.it (smtpd3.aruba.it [62.149.128.208])
	by ozlabs.org (Postfix) with SMTP id 16059DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Jan 2007 20:37:20 +1100 (EST)
Subject: Re: Ethernet fails on MPC5200 based target
From: Andrea Galbusera <andrea.galbusera@teamware.it>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <45A4FDAF.8020909@246tNt.com>
References: <1168439212.5271.70.camel@localhost.localdomain>
	<45A4FDAF.8020909@246tNt.com>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 09:20:15 +0100
Message-Id: <1168935615.22089.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sylvain,
some new elements in trying to solve my ethernet issue...

On Wed, 2007-01-10 at 15:52 +0100, Sylvain Munaut wrote:

> Maybe some things (like xlb pipelining, cache snooping, ...) is not properly
> setup in you platform support code ?

Following your suggestion, I started from here... Comparing the
unaffected kernel (from DENX) with yours I tryed commenting out the
following in mpc52xx_setup_cpu() :

  /* Disable XLB pipelining */
  /* (cfr errate 292. We could do this only just before ATA PIO
     transaction and re-enable it after ...) */
  out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);

In fact this gives much better results, but does not completely solve
the problem. Network packets corruption seems to be gone, but, after
massive pinging (about 1k ping packets) it comes back with about the
same frequency as before the change.

Not tested yet the impact of this change on ATA/IDE
functionality/performance, but, if I'm not wrong, disabling the XLB
pipelining was due to a hardware bug of the CPU (errata 292), which
should be solved in 5200B, the version that I use.

I can't figure out what is the impact of keeping XLB pipelining enabled
on the eth behavior. I'm sharing this results in the hope someone have
any other valuable suggestion

Regards,

-- 
  Andrea
