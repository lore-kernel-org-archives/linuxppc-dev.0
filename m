Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B4526DDFE9
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 00:23:23 +1000 (EST)
Date: Thu, 3 May 2007 09:24:41 -0500
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powerpc: dart iommu suspend
Message-ID: <20070503142441.GA31110@lixom.net>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178195106.13233.108.camel@johannes.berg>
	<1178195312.13233.111.camel@johannes.berg>
	<1178195447.6353.40.camel@localhost.localdomain>
	<1178196492.8233.1.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178196492.8233.1.camel@johannes.berg>
From: olof@lixom.net (Olof Johansson)
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 02:48:11PM +0200, Johannes Berg wrote:
> On Thu, 2007-05-03 at 22:30 +1000, Benjamin Herrenschmidt wrote:
> > That would make it "just work" with the normal code path.
> 
> We still need the iommu restore hook to invalidate the entries, so that
> API I add there is needed anyway. Who actually saves the code doesn't
> really matter at that point. The save hook isn't strictly necessary then
> but I guess it should be there for symmetry anyway.
> 
> Maybe somebody can offer opinions on other iommus?

The PWRficient iommu shouldn't need any special considerations here, our
in-memory table is kept in regular coherent memory, so as long as that
is saved and restored (and hooks to clear out old cached TLB entries, etc
are called), everything should just work. No need to copy things around.

So yes, we'd still need the hooks, at least the restore one. And as you
say, keeping the save one there for symmetry makes sense.

I don't know what's happened to the IBM bloa^WPAPR platforms the last
year and a half, but last I looked at them you would essentially need
to scan out all entries from firmware by hand and save them away. So
they'd need both save and restore hooks.


-Olof
