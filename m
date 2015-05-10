Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC3A21A0017
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 07:01:11 +1000 (AEST)
Date: Sun, 10 May 2015 19:18:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [PATCH] drivers/tty/hvc/hvc_tile.c: properly return -EAGAIN
Message-ID: <20150510171844.GA20715@kroah.com>
References: <1430845888-22164-1-git-send-email-cmetcalf@ezchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430845888-22164-1-git-send-email-cmetcalf@ezchip.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jslaby@suse.cz>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 05, 2015 at 01:11:28PM -0400, Chris Metcalf wrote:
> We were returning zero if no bytes could be written to the Tilera
> hypervisor console device, but this causes the output to be truncated.
> By returning -EAGAIN the tty hvc driver will come back and try again,
> which gives the semantics we want, and avoids dropping console output.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
> ---
> I have queued this in the tile tree as a tile-specific device, but
> if someone would prefer to pick it up for a tty or tty/hvc tree,
> that's fine too; just let me know.

Sounds good to me, feel free to add:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

if you want it :)
