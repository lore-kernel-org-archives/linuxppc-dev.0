Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
	[IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76C6BB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 17:35:07 +1000 (EST)
Date: Wed, 31 Aug 2011 09:35:00 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 14/14] arm/include/asm/io.h : added macros to
	read/write big/little endian register
Message-ID: <20110831073500.GB9353@linutronix.de>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<335243c9467c0127206234819a94c9f72358fdf2.1314704558.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <335243c9467c0127206234819a94c9f72358fdf2.1314704558.git.pratyush.anand@st.com>
Cc: viresh.kumar@st.com, vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	tmarri@apm.com, linux-usb@vger.kernel.org, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com, rajeev-dlh.kumar@st.com,
	mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Pratyush Anand | 2011-08-30 17:28:01 [+0530]:

>diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
>index 815efa2..32282b4 100644
>--- a/arch/arm/include/asm/io.h
>+++ b/arch/arm/include/asm/io.h
>@@ -297,6 +297,14 @@ extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
> extern int devmem_is_allowed(unsigned long pfn);
> #endif
> 
>+/* Big Endian */
>+#define out_be32(a, v) writel(__cpu_to_be32(v), a)
>+#define in_be32(a) __be32_to_cpu(readl(a))
>+
>+/* Little endian */
>+#define out_le32(a, v) writel(__cpu_to_le32(v), a)
>+#define in_le32(a) __le32_to_cpu(readl(a))

In LE-mode __le32_to_cpu() is NOP and you get a LE value.
In BE-mode readl() will swap a and le32_to_cpu will swap a again. So you
get a BE value. Is this what you want?

>+

Please split this patch out and get it accepterd by ARM community. USB
people won't merge this.

Sebastian
