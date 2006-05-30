Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 542B767A3F
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:36:59 +1000 (EST)
Date: Mon, 29 May 2006 23:36:26 -0500
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Fix buglet with MMU hash management
Message-ID: <20060530043626.GC5101@pb15.lixom.net>
References: <1148962460.15722.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148962460.15722.19.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 30, 2006 at 02:14:19PM +1000, Benjamin Herrenschmidt wrote:

> This fixes by allowing the updating of the protection bits in the native
> hash handling to also set (but not clear) the "C" bit, and, in order to
> also improve performances in the general case, by always setting that
> bit on newly inserted hash PTE so that writeback really never happens.

Good catch!

However, you'll have a writeback on the R bit too, you should set that
together with C.


-Olof
