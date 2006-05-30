Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 747AD67AC5
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 06:39:37 +1000 (EST)
Date: Tue, 30 May 2006 13:41:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: mostrows@watson.ibm.com
Subject: Re: [PATCH] Provide mechanism for editing builtin command-line in
	zImage binary.
Message-ID: <20060530204151.GA31567@mag.az.mvista.com>
References: <11489544631499-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11489544631499-git-send-email-mostrows@watson.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 29, 2006 at 10:01:03PM -0400, mostrows@watson.ibm.com wrote:
> zImage will store the builtin command-line in a dedicated section, allowing
> it to be easily identified and edited with user-space tools.
>
> zImage will set /chosen/bootargs to the stored builtin command-line setting,
> if /chosen/bootargs is empty (emulating the behavior in prom_init.c).
> 
> Use of this mechanism avoids the need to modify firmware or rely on a
> bootloader to customize kernel arguments (and overall system
> behavior).  The command line can be edited as needed when a zImage is
> copied to a TFTP staging area for download by firmware.

Why do this?  Why not get rid of storing the cmdline in the zImage altogether?  

We already have equivalent functionality by storing it in the dt's
/chosen/bootargs so why this unnecessary complexity?

Add some code to edit the /chosen/bootargs at zImage runtime (just like
arch/ppc used to) and we're covered.  AFAICT, we're already adding a tool
to tack on flat dt's to an already existing zImage so you're not doing
anything we can't--or won't--do already.

Agree?

Mark
