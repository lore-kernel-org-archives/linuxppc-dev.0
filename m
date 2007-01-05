Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CA7E9DDE24
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 11:04:51 +1100 (EST)
Date: Thu, 4 Jan 2007 18:04:06 -0600
From: Olof Johansson <olof@lixom.net>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [BUG] flash failure with CONFIG_RTAS_FLASH=m
Message-ID: <20070104180406.6843ead3@localhost.localdomain>
In-Reply-To: <20070104234951.GJ6279@localdomain>
References: <20070104234951.GJ6279@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 4 Jan 2007 17:49:51 -0600 Nathan Lynch <ntl@pobox.com> wrote:

> The problem doesn't happen if CONFIG_RTAS_FLASH=y.
> 
> What's the best way to fix this?  Should rtas_firmware_flash_list be
> defined in some non-modular code and exported?

Makes sense to me.

You could allocate it dynamically really early (i.e. lmb_alloc) since
that's the only allocator that we can give limits to where in the
address range it can allocate. It seems to be overkill in this case
though, it's just a page worth of data.


-Olof
