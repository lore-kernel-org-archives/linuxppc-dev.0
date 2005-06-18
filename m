Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.2.99]) by ozlabs.org (Postfix) with ESMTP id D09AA67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Jun 2005 08:15:36 +1000 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j5IMFQHT023825
	for <linuxppc-embedded@ozlabs.org>; Sun, 19 Jun 2005 00:15:26 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <42B49D04.7050303@246tNt.com>
Date: Sun, 19 Jun 2005 00:15:32 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
References: <Pine.OSF.4.05.10506161721010.24601-100000@da410.phys.au.dk>
	<42B1A214.404@varma-el.com>
	<528646bc05061610352d56cd49@mail.gmail.com>
	<42B1CB13.3060107@varma-el.com>
	<20050617033711.GA1362@xyzzy.farnsworth.org>
	<42B2A5C7.1040909@varma-el.com>
	<20050617140022.GA15877@xyzzy.farnsworth.org>
In-Reply-To: <20050617140022.GA15877@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200/Lite5200 and ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everyone

Following the obvious demand for it :

rsync://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.git
http://gitbits.246tNt.com/gitweb.cgi?p=linux-2.6-mpc52xx.git;a=summary

Hopefully the server is setup correctly ...
It's not _heavily_ tested but it seems to works fine in the few test I made.

What in there :
 - I2C patches that are already sent upstream but not yet in Linus tree
 - Change of the mpc52xx uart device name and device ids to a range in
   the low density serial port major. Also it's now named ttyPSC? so
   you need to update you kernel command line (else you won't see any
   console). Note that the ids and names choosed are NOT YET OFFICIAL,
   I just included it in this release because some people were seeing
   conflict with the other ids. So the name and ids may change ...
 - Some other patches that will soon be sent upstream, just waiting
   for you to test see if it has any negative impact.
 - FEC and BestComm rewrite from Dale, with some improvement. For eg,
   the FEC task now handle misaligment so the manual alignment code
   has been removed, ...


Why is not bestcomm upstream already :
 There are a lot of minor stuff I don't like currently about it. The
most big part are : it mixes phys and virt address without any care, and
the fec driver needs improvement for the phy handling and for the dma
activity handling. I started working on some of this issues but I got
reassigned to more pressing matters ... The result was never published
because for now the only thing it does well is break everything ;)
 If someone wish to clean all that before I come to it, he's welcome
to contact me for info/ideas I had while working on it.


What is gonna be added "soon" :
 I'd say PIO IDE. But several people sent me a different version, so
I'll look into them and test them but probably not before next week.



Sylvain

PS: Does any one knows how to change the commit text in git/cg when
committed ? I realized I put "ppc:" at someplaces and "ppc32:" at others
and it's not coherent ...
