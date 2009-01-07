Return-Path: <arnd@arndb.de>
Received: from mout-xforward.kundenserver.de (mout-xforward.kundenserver.de
	[212.227.17.6]) by ozlabs.org (Postfix) with ESMTP id 74E8E474C3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 06:02:12 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/cell: fix the prototype of create_vma_map
Date: Wed, 7 Jan 2009 20:01:51 +0100
References: <20090107105822.221c4395.sfr@canb.auug.org.au>
	<1231299299.14860.58.camel@pasglop>
	<20090107163657.4feddae0.sfr@canb.auug.org.au>
In-Reply-To: <20090107163657.4feddae0.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200901072001.52336.arnd@arndb.de>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 January 2009, Stephen Rothwell wrote:

> Also the value originally comes from a notifier callback
> (spu_active_notify) which is passed this value as an "unsigned long".

The data that gets passed down here is originally the u64 object_id
from struct spu_context, but it gets passed as an unsigned long
through the notifier chain. I think either way is fine, as it's
not possible to use spu notifiers on a 32 bit kernel and I wouldn't
want to change it more fundamentally.
If you like, you can change the whole call chain from spu_active_notify
to pass a u64, but it woulnd't make the code more correct.

Original patch
Acked-by: Arnd Bergmann <arnd@arndb.de>
