Return-Path: <eli@dev.mellanox.co.il>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
 [74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 81AE7B6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 19:47:36 +1100 (EST)
Received: by wyg36 with SMTP id 36so6109036wyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 01:47:31 -0700 (PDT)
Date: Mon, 10 Oct 2011 10:47:26 +0200
From: Eli Cohen <eli@dev.mellanox.co.il>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] mlx4_en: fix transmit of packages when blue frame is
 enabled
Message-ID: <20111010084726.GM2681@mtldesk30>
References: <1318145118.29415.371.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6D8AE78@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE78@saturn3.aculab.com>
Cc: Yevgeny Petrilin <yevgenyp@mellanox.co.il>, Eli Cohen <eli@mellanox.co.il>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2011 at 09:40:17AM +0100, David Laight wrote:
> 
> Actually memory barriers shouldn't really be added to
> any of these 'accessor' functions.
> (Or, at least, ones without barriers should be provided.)
> 
> The driver may want to to a series of writes, then a
> single barrier, before a final write of a command (etc).
> 
> in_le32() from io.h is specially horrid!
> 
> 	David
> 
The driver would like to control if and when we want to put a memory
barrier. We really don't want it to be done under the hood. In this
respect we prefer raw functions which are still available to all
platforms.
