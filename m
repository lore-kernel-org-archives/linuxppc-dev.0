Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 959122C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 18:45:12 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 32444-05 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 25 Jul 2012 09:45:02 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [1/3][PATCH][upstream]Adding documentation for TDM
Date: Wed, 25 Jul 2012 09:44:13 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6FA8@saturn3.aculab.com>
In-Reply-To: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B7B35@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <1343040588-16002-2-git-send-email-b37400@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B6FA4@saturn3.aculab.com>
 <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B7B35@039-SN2MPN1-013.039d.mgd.msft.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Aggrwal Poonam-B10812" <B10812@freescale.com>,
 "Singh Sandeep-B37400" <B37400@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > For flexibility you need to allow for 8bit samples being converted
as:
> > 1) 8bit raw ulaw or alaw data (unchanged from line).
> > 2) 8bit raw data, bit reversed, any hdlc protocol
> >    is bit reversed from audio [1].
> > 3) 8bit audio, converted from alaw to ulaw
> > 4) 8bit audio, converted from ulaw to alaw
> > 5) 16bit linear converted to/from alaw or ulaw and on a per-timeslot
> > basis.
> I agree. That we only support very limited samples. But We can add
this
> in second step once the basic framework is in.
> Also right now the testing infrastructure we have, we won't be able to
> test all these scenarios.

You probably ought to make the application request a specific
format - and error the unsupported ones.
That would make it easier to add support for other formats
later.

I also suspect that this 'framework' isn't that general!
We (as a company) use the TDM interface blocks on the MSC8101
and MSC8013 Starecore DSPs as well as some bespoke FPGA logic
(which will do ulaw<->alaw convertion).
The 'framework' would almost certainly be inappropriate
for both out hardware and software.

	David
