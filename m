Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 8391C67A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Feb 2005 11:20:11 +1100 (EST)
Message-ID: <42016E33.9070804@mvista.com>
Date: Wed, 02 Feb 2005 17:20:03 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Brian Waite <waite@skycomputers.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] fix locking bugs in mv64x60 code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[Original patch slightly edited by mgreer]

This patch fixes 2 SMP deadlocks. The first is that mv64x60_read() was 
returning before the unlock. The second was mv64x60_modify() locks the spin 
lock and calls mv64x60_read() and mv64x60_write() which also lock the same spin lock.

Please apply.

Signed-Off-By: Brian Waite <waite@skycomputers.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
