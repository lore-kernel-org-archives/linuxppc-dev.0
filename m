Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 815A02BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 01:29:13 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <11BB7E60-193F-11D9-9299-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Oct 2004 11:31:05 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 8, 2004, at 7:16 AM, Robert P. J. Day wrote:

> now, is this the right place for configuring CPM SCC/SMC serial port 
> support?  sure, some people might say.  after all, it's serial port 
> stuff, it should be under "Serial drivers".  makes perfect sense, 
> right?

Not exactly.  At one point we decided to keep the CPM and other 
8xx/82xx/85xx
unique configuration options in a separate set of menus under 
arch/ppc/cpm*
as appropriate.  There may (usually will) be drivers and support unique 
to these
processors that will always simply continue to live there.  We decided 
to not
scatter the configuration options about, placing the sharable drivers 
in the
standard places, but the configuration local.  One reason for this is 
some of
these drivers may be shared by several Freescale processors, as they are
starting to use these peripheral blocks in more varied processors.  The 
basic
drivers are the same, but configuration options and support functions 
may
be different.  These support and configuration options should be 
collected
in a processor type specific place, and set configuration options the 
shared
drivers will use as necessary.

Once again I'll add the observation that people using these processors
have to know how the boards are configured and to select the proper
options.  There is lots of variation among the configurations and I'd 
rather
not build complex configuration menus that try to keep users from
hurting themselves.  The default configuration files are there for a 
reason,
let's use them to assist people (and keep them up to date).

If you are making changes to configuration options, it would be nice if
you would also at least regenerate all default configuration files 
affected
by this (as I do).  At least make an honest attempt at getting it 
correct.

Thanks.

	-- Dan
