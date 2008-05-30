Return-Path: <ben@somanetworks.com>
Received: from mail.somanetworks.com (ldap.somanetworks.com [216.126.67.42])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.somanetworks.com",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 690F6DE944
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 08:22:52 +1000 (EST)
Received: from odo.yyz.somanetworks.com (HELO [10.11.11.50])
	(ben@[10.11.11.50]) (envelope-sender <ben@somanetworks.com>)
	by mail.somanetworks.com (qmail-ldap-1.03) with RC4-MD5 encrypted SMTP
	for <linuxppc-dev@ozlabs.org>; 30 May 2008 22:16:08 -0000
Message-ID: <48407CA8.3030301@somanetworks.com>
Date: Fri, 30 May 2008 18:16:08 -0400
From: Ben Gamsa <ben@somanetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Problems changing ethernet phy settings with LXT973 (and 8555)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm not sure if this is the right place to post, but it's one of the few
places that seems relevant (the other I think would be linuxppc-embedded).

Our board is using an 8555 with an LXT973 dual-phy chip hooked up to TSEC0
and TSEC1.

We're currently using 2.6.20 but I don't see any major changes in the 2.6.25
release in the area of the phy driver.  We're using the gianfar driver, with
the generic phy driver.  When the phy driver writes to BMCR to turn off
auto-negotiation and set the speed and duplex, it appears that none of the
writes except the RESET bit take effect.  Reading back the register
immediately shows the RESET bit set, but none of the other changes (later
the RESET bit is cleared, but again, none of the changes are visible).

One possibility was that the LXT973 was wired up to come up in hardware
control mode, where it's supposed to ignore all writes (I'm not sure if
there is supposed to be an exception for the RESET bit or not in this case),
but that appears not to be the case.

I was wondering if anyone has any idea as to what might be the source of
this problem, or if anyone has any suggestions as to avenues of investigation
to track it down.

-- 
Ben Gamsa             ben@somanetworks.com
SOMA Networks, Inc.   312 Adelaide St. W. Suite 600 Toronto, Ontario, M5V1R2
