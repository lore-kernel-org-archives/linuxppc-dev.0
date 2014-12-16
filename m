Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 216BC1A04E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 05:06:07 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 093DC1400DE
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:06:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 17 Dec 2014 04:06:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D68B32BB0054
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:06:02 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBGI62ak37552330
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:06:02 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBGI62vw021933
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 05:06:02 +1100
Subject: [PATCH v2 2/3] pstore: Add pstore type id for firmware partition
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Dec 2014 23:35:49 +0530
Message-ID: <20141216180549.7778.16696.stgit@localhost.localdomain>
In-Reply-To: <20141216180442.7778.38272.stgit@localhost.localdomain>
References: <20141216180442.7778.38272.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a pstore type id to be used for opal specific
nvram partitions.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 fs/pstore/inode.c      |    3 +++
 include/linux/pstore.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5041660..8e0c009 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -359,6 +359,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
 	case PSTORE_TYPE_PPC_COMMON:
 		sprintf(name, "powerpc-common-%s-%lld", psname, id);
 		break;
+	case PSTORE_TYPE_PPC_OPAL:
+		sprintf(name, "powerpc-opal-%s-%lld", psname, id);
+		break;
 	case PSTORE_TYPE_UNKNOWN:
 		sprintf(name, "unknown-%s-%lld", psname, id);
 		break;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index ece0c6b..af44980 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -39,6 +39,7 @@ enum pstore_type_id {
 	PSTORE_TYPE_PPC_RTAS	= 4,
 	PSTORE_TYPE_PPC_OF	= 5,
 	PSTORE_TYPE_PPC_COMMON	= 6,
+	PSTORE_TYPE_PPC_OPAL	= 7,
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 
