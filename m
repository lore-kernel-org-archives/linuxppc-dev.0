Return-Path: <pratyush.anand@st.com>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
	[207.126.144.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 088FFB6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 22:26:35 +1000 (EST)
From: Pratyush Anand <pratyush.anand@st.com>
To: <linux-usb@vger.kernel.org>
Subject: [PATCH 14/14] arm/include/asm/io.h : added macros to read/write
	big/little endian register
Date: Tue, 30 Aug 2011 17:28:01 +0530
Message-ID: <335243c9467c0127206234819a94c9f72358fdf2.1314704558.git.pratyush.anand@st.com>
In-Reply-To: <cover.1314704557.git.pratyush.anand@st.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	vipin.kumar@st.com, shiraz.hashim@st.com, Amit.VIRDI@st.com,
	rajeev-dlh.kumar@st.com, mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are some peripheral(e.g dwc otg) whose registers can be configured to
work in either little or big endian mode. Therefor macros like out_be32,
in_be32, out_le32 and in_le32 have been added to support such peripherals.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 arch/arm/include/asm/io.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 815efa2..32282b4 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -297,6 +297,14 @@ extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 extern int devmem_is_allowed(unsigned long pfn);
 #endif
 
+/* Big Endian */
+#define out_be32(a, v) writel(__cpu_to_be32(v), a)
+#define in_be32(a) __be32_to_cpu(readl(a))
+
+/* Little endian */
+#define out_le32(a, v) writel(__cpu_to_le32(v), a)
+#define in_le32(a) __le32_to_cpu(readl(a))
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
-- 
1.7.2.2
