Return-Path: <greg@kroah.com>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBE78DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 17:46:23 +1000 (EST)
Date: Tue, 14 Aug 2007 00:29:18 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [patch 07/12] powerpc: Fix size check for hugetlbfs
Message-ID: <20070814072918.GG15025@kroah.com>
References: <20070814072244.882283903@mini.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070814072813.GA15025@kroah.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, Paul Mackerras <paulus@samba.org>,
	Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>,
	Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

My "slices" address space management code that was added in 2.6.22
implementation of get_unmapped_area() doesn't properly check that the
size is a multiple of the requested page size. This allows userland to
create VMAs that aren't a multiple of the huge page size with hugetlbfs
(since hugetlbfs entirely relies on get_unmapped_area() to do that
checking) which leads to a kernel BUG() when such areas are torn down.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/powerpc/mm/slice.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -405,6 +405,8 @@ unsigned long slice_get_unmapped_area(un
 
 	if (len > mm->task_size)
 		return -ENOMEM;
+	if (len & ((1ul << pshift) - 1))
+		return -EINVAL;
 	if (fixed && (addr & ((1ul << pshift) - 1)))
 		return -EINVAL;
 	if (fixed && addr > (mm->task_size - len))

-- 
