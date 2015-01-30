Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8EF61A123D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 02:15:21 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B863C14017D
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 02:15:21 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 31 Jan 2015 01:15:21 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5DB082BB0051
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 02:15:18 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0UFF9MF43319326
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 02:15:18 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0UFEh8r020077
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 02:14:44 +1100
Subject: [PATCH v4 2/3] pstore: Add pstore type id for PPC64 opal nvram
 partition
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 30 Jan 2015 20:44:25 +0530
Message-ID: <20150130151425.13976.76015.stgit@localhost.localdomain>
In-Reply-To: <20150130151247.13976.88337.stgit@localhost.localdomain>
References: <20150130151247.13976.88337.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a new PPC64 partition type to be used for opal
specific nvram partition. A new partition type is needed as none
of the existing type matches this partition type.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>
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
 
