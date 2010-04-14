Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 375ACB7D15
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Apr 2010 12:57:16 +1000 (EST)
Subject: Re: Possible bug with mutex adaptative spinning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1271212509.13059.135.camel@pasglop>
References: <1271212509.13059.135.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Apr 2010 12:56:07 +1000
Message-ID: <1271213767.13059.137.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-14 at 12:35 +1000, Benjamin Herrenschmidt wrote:
> Hi Peter !
> 
> I -may- have found a bug with mutex adaptative spinning. We hit it when
> torture testing CPU unplug.

 .../...

In fact, I wonder if there's another potential problem:

If the owner is actually running, it may do so for a very long time. It
looks to me that everybody trying to take the mutex will thus spin and
never get out of the spin loop until the owner stops running.

That sounds very wrong to me :-)

Shouldn't you at least remove the test for !owner when testing
need_resched() in __mutex_lock_common() ?

Cheers,
Ben.
