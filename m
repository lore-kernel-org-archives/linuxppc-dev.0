Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A29C61A0D82
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Dec 2014 22:58:57 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 62FF51400E9
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2014 22:58:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 24 Dec 2014 21:58:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 330512CE8054
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2014 22:58:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBOBwrI24128866
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2014 22:58:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBOBwrjN007028
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2014 22:58:53 +1100
Subject: [PATCH v3 2/3] pstore: Add pstore type id for firmware partition
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Wed, 24 Dec 2014 17:28:43 +0530
Message-ID: <20141224115842.25731.94235.stgit@localhost.localdomain>
In-Reply-To: <20141224115729.25731.20371.stgit@localhost.localdomain>
References: <20141224115729.25731.20371.stgit@localhost.localdomain>
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
 
