Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18082.46270.713491.488496@cargo.ozlabs.ibm.com>
Date: Sun, 22 Jul 2007 11:37:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] OProfile - Enable SPU switch notification to detect
	currently active SPU tasks - update
In-Reply-To: <20070720130241.176c50a5.akpm@linux-foundation.org>
References: <200707201424.07292.rrnelson@linux.vnet.ibm.com>
	<20070720130241.176c50a5.akpm@linux-foundation.org>
Cc: Maynard Johnson <maynardj@linux.vnet.ibm.com>,
	Philippe Elie <phil.el@wanadoo.fr>, linuxppc <linuxppc-dev@ozlabs.org>,
	Bob Nelson <rrnelson@linux.vnet.ibm.com>, Arnd Bergmann <arndb@de.ibm.com>,
	oprofile <oprofile-list@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> I still wonder about that barrier.  At the least it should be smp_mb(). 
> But aren't our set_bit() semantics _alone_ sufficient to make this barrier
> unneeded?

No, but our wake_up semantics certainly ought to be, if they aren't
already.  It's the wake_up which implies synchronization with other
tasks, not the set_bit.

Paul.
