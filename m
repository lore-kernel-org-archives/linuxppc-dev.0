Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 6279867BC6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 01:43:52 +1000 (EST)
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D5D2488@rennsmail02.eu.thmulti.com>
References: <1CFEB358338412458B21FAA0D78FE86D5D2488@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <21947D16-8490-416A-9093-32AB9CB5DDDB@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: multicast for 8260 for 2.6.13
Date: Thu, 20 Jul 2006 11:44:11 -0400
To: "Harnois Anne-Sophie" <anne-sophie.harnois@thomson.net>
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


On Jul 20, 2006, at 10:45 AM, Harnois Anne-Sophie wrote:

> In the file arch/ppc/8260_io/fcc_enet.c, set_multicast_list  
> function is
> commented out and I can't figure out why.

Read the mailing list archives.

> I checked the code, removed the comments and tried it, and multicast
> seemed to work properly.

Sorry, but that code will never work on a 82xx.

> What am I missing?
> Could someone explain me why this is commented out?

Because it was copied from the 8xx many years ago when
I ported the driver, and the 82xx lacks the CRC generator
support.  You can enable promiscuous mode, which is
what I suspect you did, and then the Linux IP stack will
do the multicast filtering.

By the way, this driver is obsolete and you should be
using the version in drivers/net/fs_enet.


Thanks.

	-- Dan
