Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 97DD2DDFAE
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 03:09:16 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH v5] MPC5121 TLB errata workaround
Date: Mon, 16 Mar 2009 17:09:14 +0100
References: <200903161652.09747.david.jander@protonic.nl>
In-Reply-To: <200903161652.09747.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903161709.14682.david.jander@protonic.nl>
Cc: Paul Mackerras <paulus@samba.org>, gunnar@genesi-usa.com,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


In this patch, I placed the LRW table in SPRG6 like before, but Kumar's code 
seems a little more compact, so I decided to use that one and fix it ;-)

It's a pity we seem to have one register short in the handler, so we need to 
load SPRN_SRR1 twice :-(

Allthough the code-path now has 1 instruction less than my previous version 
most of the time (and 2 instructions more when way is not adjusted), 
benchmark results are barely affected by this:

1.- mplayer: Total time: 50.392s (50.316s previous patch)

2.- prboom timedemo: 20.1 fps (19.9 fps previous patch)

3.- memcpy speed: 179 MByte/s (180 Mbyte/s previous patch)

Conclusion: difference not measurable between v4 and v5.

Best regards,

-- 
David Jander
Protonic Holland.
