Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C2C4DDE2C
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 19:39:02 +1100 (EST)
Date: Thu, 6 Dec 2007 01:16:28 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
Message-ID: <20071206081628.GA15868@parisc-linux.org>
References: <20071205064116.D849BDE10A@ozlabs.org>
	<1196911347.7033.15.camel@pasglop>
	<20071206063940.GA16474@kroah.com>
	<1196927934.7033.39.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196927934.7033.39.camel@pasglop>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 06, 2007 at 06:58:54PM +1100, Benjamin Herrenschmidt wrote:
> I was just hoping somebody had a better idea, like a way to add a new
> format specifier to printk without losing gcc type checking :-)

It's been discussed before.  Some of the solutions discussed:

 - Add something like PRI_RES which can be concatenated into a printk.
   Ugly.
 - Patch gcc to allow user-definable types.  I think OpenBSD has a patch
   for this.  Then we have to get that patch propagated to all the
   people who compile the kernel.  Unappetising.
 - Disable gcc's printk checking, teach sparse to typecheck printk.
   Most people don't run sparse yet.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
