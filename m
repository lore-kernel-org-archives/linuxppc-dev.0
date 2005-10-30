Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.194])
	by ozlabs.org (Postfix) with ESMTP id A57AC6863B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 07:04:31 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id n28so282106nfc
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Oct 2005 12:04:29 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 30 Oct 2005 23:03:24 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510302203.25390.pantelis.antoniou@gmail.com>
Cc: Dan Malek <dan@embeddedalley.com>, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.14] mm: 8xx MM fix for
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Latest MMU changes caused 8xx to stop working. Flushing tlb of the faulting
address fixes the problem.

---
commit 978e2f36b1ae53e37ba27b3ab8f1c5ddbb8c8a10
tree 7dd0e403c240162b1925db0834d694f4b4a0e95e
parent ca02ea5aebcda886d1552c6af73ca96c02bf9fed
author Pantelis Antoniou <panto@pantathon> Sun, 30 Oct 2005 21:53:48 +0200
committer Pantelis Antoniou <panto@pantathon> Sun, 30 Oct 2005 21:53:48 +0200

 arch/ppc/mm/fault.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
--- a/arch/ppc/mm/fault.c
+++ b/arch/ppc/mm/fault.c
@@ -240,6 +240,19 @@ good_area:
 			goto bad_area;
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto bad_area;
+
+#ifdef CONFIG_8xx
+		{
+		/* 8xx is retarded; news at 11 */
+		pte_t *ptep = NULL;
+
+		if (get_pteptr(mm, address, &ptep) && pte_present(*ptep))
+			_tlbie(address);
+
+		if (ptep != NULL)
+			pte_unmap(ptep);
+		}
+#endif
 	}
 
 	/*
