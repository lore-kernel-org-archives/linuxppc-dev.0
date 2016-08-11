Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8qd33fR6zDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 11:07:51 +1000 (AEST)
Date: Thu, 11 Aug 2016 11:07:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>
Subject: Mailman and DKIM
Message-ID: <20160811110750.27f37f35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I have made Mailman work mostly with DKIM (and therefore DMARC).  The
one remaining trick is this: Mailman will "simplify" mail addresses in
Cc (and maybe From and To) headers in some circumstances - which breaks
DKIM signatures.

So, for an email address like:

	Name <address@example.com>

if the "Name" is missing, Mailman will remove the "<" and ">".  To get
around this, you can either always put a "Name", or lease out both the
"Name" and the "<>".

Sorry for the pain, hopefully most people can fix this in their address
books etc.

And to be clear, this only matters where the originating site uses
DMARC with a strict policy (which includes samba.org).

-- 
Cheers,
Stephen Rothwell
