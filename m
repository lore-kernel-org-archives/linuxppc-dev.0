Return-Path: <scottwood@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF136B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 06:23:30 +1100 (EST)
Date: Tue, 4 Jan 2011 13:23:17 -0600
From: Scott Wood <scottwood@freescale.com>
To: <Bruce_Leonard@selinc.com>
Subject: Re: Question about combining a PCI driver with an OF driver
Message-ID: <20110104132317.006ead39@udp111988uds.am.freescale.net>
In-Reply-To: <OF413F3FA8.B1C9F99A-ON8825780E.006706F6-8825780E.00683E0B@selinc.com>
References: <OF413F3FA8.B1C9F99A-ON8825780E.006706F6-8825780E.00683E0B@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Jan 2011 10:58:35 -0800
<Bruce_Leonard@selinc.com> wrote:

> Hi all,
> 
> I'm working on a project with an MPC8347 and three ethernet ports. Because 
> of end of life issues we've had to replace the part we're using for the 
> third ethernet port and we decided rather than rely on a vendor who would 
> pull a part out from under us every two to three years we would do our own 
> MAC in an FPGA.  In order to reduce driver work it was decided that we 
> would use the same hardware interface as the TSEC in the 8347 so we could 
> reuse the gianfar driver.

Making a faithful clone of any reasonably complex device strikes me as
more work than writing a new ethernet driver.

The last thing you want to end up doing is...

>  And for speed sake it would go on the PCI bus. 
> (So much for letting HW make decisions regarding SW :)   )

...hacking up the existing driver to deal with the quirks of the clone,
and having to maintain those hacks. :-)

> So now I'm stuck with hacking the gianfar driver to work on PCI.  However, 
> I think it would be a lot more elegant if I could wrap the gianfar driver 
> with a PCI interface.  After all the idea is sound, with a HW interface 
> that looks like the TSEC I should be able to reuse the gianfar driver. But 
> the gianfar driver is an open firmware driver registered with a call to 
> of_register_platform_driver() and depending on the order in which the 
> busses are walked the PCI bus may not be enumerated and available when the 
> onboard TSECS are detected and the gianfar driver claims them.

It shouldn't matter -- the way buses work in Linux, you should be able
to add a platform device at any time, and the driver will receive a
probe() callback.  The driver never actively searches for devices to
claim.

-Scott
