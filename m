Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E9BB686D3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 09:24:19 +1100 (EST)
In-Reply-To: <20051108205259.A2870352B33@atlas.denx.de>
References: <20051108205259.A2870352B33@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9edbd784a9398cdd8c08c474b1b37e43@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 8 Nov 2005 17:30:27 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: fix swapping on 8xx? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 8, 2005, at 3:52 PM, Wolfgang Denk wrote:

> Please do not remove stuff that is needed and used to work (in 2.4).

I'm not proposing we remove anything :-)  It would just be nice
to eliminate the overhead of managing the PTEs if we don't
need such a feature.  The complexity of the TLB miss handler
just keeps growing to add/fix this stuff, and it really shouldn't
be in that code path.  All of this support should be pushed
into the error path, and if it was somewhat configurable we
wouldn't be in that path if not necessary.

Thanks.

	-- Dan
