Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ACE482C014F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 13:13:45 +1000 (EST)
Message-ID: <5175FC36.4060308@asianux.com>
Date: Tue, 23 Apr 2013 11:12:54 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] PowerPC: kernel: memory access violation when rtas_data_buf
 contents are more than 1026
References: <516F7A7D.60206@asianux.com> <1366677081.2886.7.camel@pasglop>
 <5175E85F.1040509@asianux.com>
In-Reply-To: <5175E85F.1040509@asianux.com>
Content-Type: text/plain; charset=UTF-8
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, Al Viro <viro@zeniv.linux.org.uk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


need set '\0' for 'local_buffer'.

SPLPAR_MAXLENGTH is 1026, RTAS_DATA_BUF_SIZE is 4096. so the contents of
rtas_data_buf may truncated in memcpy.

if contents are really truncated.
  the splpar_strlen is more than 1026. the next while loop checking will
  not find the end of buffer. that will cause memory access violation.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/powerpc/kernel/lparcfg.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index 801a757..d92f387 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -299,6 +299,7 @@ static void parse_system_parameter_string(struct seq_file *m)
 				__pa(rtas_data_buf),
 				RTAS_DATA_BUF_SIZE);
 	memcpy(local_buffer, rtas_data_buf, SPLPAR_MAXLENGTH);
+	local_buffer[SPLPAR_MAXLENGTH - 1] = '\0';
 	spin_unlock(&rtas_data_buf_lock);
 
 	if (call_status != 0) {
-- 
1.7.7.6
