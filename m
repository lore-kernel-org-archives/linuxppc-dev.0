Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 99525DDF30
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 09:33:14 +1100 (EST)
Date: Wed, 12 Mar 2008 16:33:00 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [BUG] 2.6.25-rc5-mm1 kernel panic with "Exception: 501 " on
	powerpc
Message-ID: <20080312223300.GE613@parisc-linux.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
	<47D7D2C9.4090001@linux.vnet.ibm.com>
	<20080312104645.34e58319.akpm@linux-foundation.org>
	<20080312175102.GC613@parisc-linux.org>
	<1205360769.7436.8.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1205360769.7436.8.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 13, 2008 at 09:26:09AM +1100, Michael Ellerman wrote:
> down() looks OK, but there's still a spin_lock_irq() in __down_common(),
> although I don't know if it makes sense for us to be in __down() at that
> stage.

The spin_lock_irq in __down_common is correct.  We're going to schedule(),
so we spin_unlock_irq() to save us passing the flags into the helper
function.  If we had interrupts disabled on entry, there's an Aieee
for that.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
