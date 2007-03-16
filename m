Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17914.10184.723915.920726@cargo.ozlabs.ibm.com>
Date: Fri, 16 Mar 2007 16:14:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
In-Reply-To: <200703122254.27087.sr@denx.de>
References: <200703122254.27087.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese writes:

> This patch adds support for the PAGE_SIZE set equal to 64 KB on
> PPC32 platforms.

If I'm reading the patch right, with 64k pages you're using 8kB pgd
arrays and 256-byte pte arrays, so you're only using 1/256th of each
PTE page.  In fact each PTE page could map 512MB (assuming 8 byte
ptes), and the pgd array could be a tiny 8-entry thing, which we could
kmalloc.  I think that would use memory more efficiently.

Paul.
