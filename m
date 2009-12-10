Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9B99EB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 17:09:29 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: MPC5200B XLB Configuration Issues, FEC RFIFO Events, ATA Crashes
References: <200912091529.13913.roman.fietze@telemotive.de>
	<20091209145748.GB3112@pengutronix.de>
In-Reply-To: <20091209145748.GB3112@pengutronix.de>
MIME-Version: 1.0
Message-ID: <200912100709.23126.roman.fietze@telemotive.de>
Date: Thu, 10 Dec 2009 07:09:23 +0100
Content-Type: Text/Plain;
  charset="iso-8859-15"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

On Wednesday 09 December 2009 15:57:48 Wolfram Sang wrote:

> Do you have a way to measure performance penalties?

Yes, I do. I am using an SCLPC test driver derived from a driver
written or posted by Grant Likely named mpc5200-localplus-test. This
gives me some useful output about the SCLPC BestComm FIFO read
throughput.

Additional to that I'm running I relatively dumb ATA stress test
writing large files to an ext3 that gives me the data rate, as well as
an NFS mount where I read data from.

I will now run all three tests in a few combinations, those that do
not crash my system with the old setup, adding NFS writes and ATA
reads.

I will post the numbers here as soon as I'm done, please give me 2 or
3 days, and as soon as I have the confidence they reflect the reality
at least somewhat.

> I know that stability comes before performance, still I am wondering
> as it looks to me that the most interesting features are simply
> switched off.

We are seeing the same problem in our device, but having a return rate
of almost 100% due to corrupt file systems that can not be repaired in
the field is no alternative.

But, something that never happened before, the system is now running
SCLPC read, ATA write and NFS read for more that 20 hours without any
crash. That's an argument.

Probably the XLB setup has to be done in the U-Boot anyway, and here
the configuration can be flexible enough to enable those positive
features on boards that use only component that do not conflict. The
only thing left is the the cache coherency switch in the kernel
config.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
