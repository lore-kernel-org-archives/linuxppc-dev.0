Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 849EBB6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 10:51:33 +1100 (EST)
Message-ID: <1322437884.23348.30.camel@pasglop>
Subject: MPIC cleanup series
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <kyle@moffetthome.net>
Date: Mon, 28 Nov 2011 10:51:24 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kyle !

I can't reply to the patches themselves easily unfortunately as I
accidentally deleted them from my mailer :-)

Overall I really look your series. It doesn't quite apply cleanly
anymore so I'll as you for a new shoot after you address the comments
below, at which point, if you're fast enough, I'll stick it in -next :-)

Just a couple of comments on some of the patches:

 - 5/10: search for open-pic device-tree node if NULL

The idea is fine, however most callers ignore the device-type and only
compare on compatible, while you replace that with a match entry that
seems to require matching on both. This is likely to break stuff. The
"type" part of te march entry should be NULL I believe.

 - 9/10: cache the node

of_node_get() is your friend. 

 - 10/10: Makes me a bit nervous. It 'looks' right but I wouldn't bet on
Apple device-trees being sane vs. chaining. I would like a test that
doesn't do the cascade if the mpic is a primary to at least limit the
risk of messup.

Cheers,
Ben.
