Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6AEB2B6F67
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 08:59:41 +1100 (EST)
Message-ID: <4ED7F8C6.8060000@freescale.com>
Date: Thu, 1 Dec 2011 15:59:34 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] i2c-mpc: use the cell-index property to enumerate the
 I2C adapters
References: <1322760781-31226-1-git-send-email-timur@freescale.com>
 <4ED7CA64.2080503@freescale.com> <4ED7E975.6090704@freescale.com>
 <4ED7F1AE.70806@freescale.com> <4ED7F5AA.2040909@freescale.com>
 <4ED7F72F.7050405@freescale.com>
 <CACxGe6sZgG5q6NKgsGaWLyTzWHXNGqHke9nQMyqzw0audS3=tw@mail.gmail.com>
In-Reply-To: <CACxGe6sZgG5q6NKgsGaWLyTzWHXNGqHke9nQMyqzw0audS3=tw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> It is better to walk the list of i2c adapters and look for one that
> has the matching node pointer.  It really isn't an expensive operation
> to do it that way.

That's what I was thinking.  I can't figure out how to walk the list, though.  i2c_get_adapter() takes an adapter number, but I don't think this is going to work:

unsigned int i = 0;
struct i2c_adapter adap = i2c_get_adapter(0);

while (adap) {
	if (adap->nr == nr)
		break;
	adap = i2c_get_adapter(++i);
}

-- 
Timur Tabi
Linux kernel developer at Freescale
