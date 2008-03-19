Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 97781DE15C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 09:31:47 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 19 Mar 2008 23:31:45 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <556445368AFA1C438794ABDA8901891C084C2113@USA0300MS03.na.xerox.net>
Message-ID: <20080319223145.249840@gmx.net>
MIME-Version: 1.0
References: <556445368AFA1C438794ABDA8901891C084C2113@USA0300MS03.na.xerox.net>
Subject: Re: 7448/2.6.20 problems (double boots or hangs)
To: "Leisner, Martin" <Martin.Leisner@xerox.com>, linuxppc-dev@ozlabs.org
Cc: Nathan.Lund@xerox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 19 Mar 2008 17:52:16 -0400
> Von: "Leisner, Martin" <Martin.Leisner@xerox.com>
> An: linuxppc-dev@ozlabs.org
> CC: "Lund, Nathan \\(Nathan.Lund@usa.xerox.com\\)" <Nathan.Lund@xerox.com>
> Betreff: 7448/2.6.20 problems (double boots or hangs)

> My taiga board is now dead -- on our development board (with a taiga
> kernel
> and a custom modified dts) we see either
> 
> 
> 1) it hangs at the same point ("PID has table entries")
>    or
> 2) it boots but it seems to restart the boot process after the "PID hash
> table entries line"
I observed the same behavior on my AmigaOne, if the PAGE_COHERENT flag was
set for page mappings by CPU_FTR_NEED_COHERENT. The 7448 CPU doesn't need
CPU_FTR_NEED_COHERENT to be set (no CPU bug that needs to be worked
around), but there is no define for the 7448 in arch/powerpc/cputable.h in
kernel v2.6.20 (but it's in v2.6.22!). Thus I guess it is detected as a
744[0|5|7], which have this flag set.
On the other side my hardware is _very_ buggy, so it's unlikely that this
could be the problem on your hardware.

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
