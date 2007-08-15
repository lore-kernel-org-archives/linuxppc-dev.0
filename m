Return-Path: <ilpo.jarvinen@helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 791ACDDEB9
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 08:08:53 +1000 (EST)
Date: Thu, 16 Aug 2007 01:03:35 +0300 (EEST)
From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Invalid semicolon after if statement
Message-ID: <Pine.LNX.4.64.0708151644090.15670@kivilampi-30.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	boundary="-696243703-1395958106-1187185521=:15670"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-1395958106-1187185521=:15670
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0708160103031.21858@kivilampi-30.cs.helsinki.fi>


A similar fix to netfilter from Eric Dumazet inspired me to
look around a bit by using some grep/sed stuff as looking for
this kind of bugs seemed easy to automate. This is one of them
I found where it looks like this semicolon is not valid.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---

...Since I'm not familiar with these parts of the kernel, you might know 
better than I do if this is stuff is valid...

 arch/powerpc/mm/hash_utils_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f178957..a47151e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -795,7 +795,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 
 #ifdef CONFIG_PPC_MM_SLICES
 	/* We only prefault standard pages for now */
-	if (unlikely(get_slice_psize(mm, ea) != mm->context.user_psize));
+	if (unlikely(get_slice_psize(mm, ea) != mm->context.user_psize))
 		return;
 #endif
 
-- 
1.5.0.6
---696243703-1395958106-1187185521=:15670--
