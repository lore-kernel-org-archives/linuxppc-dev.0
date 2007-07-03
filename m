Return-Path: <jim.houston@ccur.com>
Received: from mail.ccur.com (mail.ccur.com [66.10.65.12])
	by ozlabs.org (Postfix) with ESMTP id 7DA7EDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 10:44:06 +1000 (EST)
Subject: Re: idr_get_new_above() limitation?
From: Jim Houston <jim.houston@ccur.com>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200707021919.27251.hnguyen@linux.vnet.ibm.com>
References: <200707021919.27251.hnguyen@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 02 Jul 2007 20:31:40 -0400
Message-Id: <1183422700.3130.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: jim.houston@ccur.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-02 at 19:19 +0200, Hoang-Nam Nguyen wrote:

> i=3fffffff token=3fffffff t=000000003fffffff
> i=40000000 token=40000000 t=0000000000000000
> Invalid object 0000000000000000. Expected 40000000
> 
> That means token 0x40000000 seems to be the "upper boundary" of idr_find().
> However the behaviour is not consistent in that it was returned by
> idr_get_new_above().

Hi Nam,

Yes this is a bug.  Thanks for the great test module.

The problem is in idr_get_new_above_int() in the loop which
adds new layers to the top of the radix tree.  It is failing
the "layers < (MAX_LEVEL - 1)" test.  It doesn't allocate the
new layer but still calls sub_alloc() which relies on having
the new layer properly constructed.  I believe that it is
allocating the slot which corresponds to id = 0.

I believe this is an off by one error in calculating the
MAX_LEVEL value.  I will do a more careful review and post 
a fix in the next day or so.  I have been in Ottawa for OLS.
I'm flying home tomorrow.

Jim Houston - Concurrent Computer Corp.
