Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE7F91A007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 11:23:15 +1000 (EST)
Date: Tue, 20 May 2014 20:23:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Subject: Re: [6/6] powerpc/mpic: Remove duplicate MPIC_WANTS_RESET flag
Message-ID: <20140521012301.GA25236@home.buserror.net>
References: <1324585155-13453-7-git-send-email-Kyle.D.Moffett@boeing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1324585155-13453-7-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: Martyn Welch <martyn.welch@ge.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 22, 2011 at 03:19:14PM -0500, Kyle Moffett wrote:
> There are two separate flags controlling whether or not the MPIC is
> reset during initialization, which is completely unnecessary, and only
> one of them can be specified in the device tree.

Those flags didn't actually do exactly the same thing.  MPIC_WANTS_RESET
controlled whether Linux pushes the big MPIC reset bit.  MPIC_NO_RESET
did inhibit that before, but it also inhibited resetting individual
sources.  By turning on MPIC_NO_RESET on boards that didn't have it,
these sources are now being left in whatever state the bootloader left
them in, which is not desireable outside of special cases like AMP.

This also ended up hiding a bug in the Freescale MPIC error interrupt
support, where the cascade was being registered prior to the reset.

Martyn, I see you set MPIC_NO_RESET in ge_imp3a.c -- was this just
copy+paste or is there a reason to leave this enabled on that board?

-Scott
