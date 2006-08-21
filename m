Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 7DE0467C30
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 07:26:08 +1000 (EST)
Date: Mon, 21 Aug 2006 16:25:55 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fix gettimeofday vs. update_gtod race
Message-ID: <20060821212555.GC9828@localdomain>
References: <20060811204105.GK3233@localdomain>
	<1155772134.11312.119.camel@localhost.localdomain>
	<20060817001807.GB354@localdomain>
	<1155774477.11312.137.camel@localhost.localdomain>
	<20060817204712.GD354@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060817204712.GD354@localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2006-08-16 at 19:18 -0500, Nathan Lynch wrote:
> > 
> > > No?  I didn't find anything about mftb having synchronizing
> > > behavior.  How should we ensure that temp_varp is assigned before
> > > reading the timebase?
> > 
> > I sync an isync would be enough.
> 
> I see, thanks.

Actually, after checking Book 2 and discussing with some other folks
I'm not so sure -- isync "may complete before storage accesses
associated with instructions preceding the isync instruction have been
performed."
