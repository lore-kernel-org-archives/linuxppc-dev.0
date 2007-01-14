Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3EE9ADDE2C
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 10:27:39 +1100 (EST)
Date: Sun, 14 Jan 2007 17:20:13 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] atomic_dec_if_positive sign extension fix
Message-ID: <20070114172013.57329bbf@localhost.localdomain>
In-Reply-To: <17834.47158.581922.62728@cargo.ozlabs.ibm.com>
References: <20070114225502.GA21471@austin.ibm.com>
	<17834.47158.581922.62728@cargo.ozlabs.ibm.com>
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

On Mon, 15 Jan 2007 10:09:42 +1100 Paul Mackerras <paulus@samba.org> wrote:

> NAK: Good fix for 64-bit, but it will break 32-bit.  I think a better
> fix would be to use a cmpwi after the lwarx, and use addi rather than
> addic..

Good point, I forgot about that when I suggested extsw to Rob.

Seems like spinlock.h solves the same problem by using a
__DO_SIGN_EXTEND define instead. Should we keep logic common as much as
possible and use the same method in atomic.h?


-Olof
