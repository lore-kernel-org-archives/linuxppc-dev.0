Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14944B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 20:43:13 +1000 (EST)
Received: by gxk1 with SMTP id 1so2039716gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 02 Sep 2011 03:43:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110831073500.GB9353@linutronix.de>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<335243c9467c0127206234819a94c9f72358fdf2.1314704558.git.pratyush.anand@st.com>
	<20110831073500.GB9353@linutronix.de>
Date: Fri, 2 Sep 2011 16:13:10 +0530
Message-ID: <CAHM4w1k56SgXXvDm0f8-P_LOsmYgG4_RjBVD3T9ws+BNk+U_+Q@mail.gmail.com>
Subject: Re: [PATCH 14/14] arm/include/asm/io.h : added macros to read/write
	big/little endian register
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	linux-usb@vger.kernel.org, vipin.kumar@st.com,
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

On Wed, Aug 31, 2011 at 1:05 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Pratyush Anand | 2011-08-30 17:28:01 [+0530]:
>
>>diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
>>index 815efa2..32282b4 100644
>>--- a/arch/arm/include/asm/io.h
>>+++ b/arch/arm/include/asm/io.h
>>@@ -297,6 +297,14 @@ extern int valid_mmap_phys_addr_range(unsigned long =
pfn, size_t size);
>> extern int devmem_is_allowed(unsigned long pfn);
>> #endif
>>
>>+/* Big Endian */
>>+#define out_be32(a, v) writel(__cpu_to_be32(v), a)
>>+#define in_be32(a) __be32_to_cpu(readl(a))
>>+
>>+/* Little endian */
>>+#define out_le32(a, v) writel(__cpu_to_le32(v), a)
>>+#define in_le32(a) __le32_to_cpu(readl(a))
>
> In LE-mode __le32_to_cpu() is NOP and you get a LE value.
> In BE-mode readl() will swap a and le32_to_cpu will swap a again. So you
> get a BE value. Is this what you want?
>

There can be some peripheral like dwc-otg, whose registers will be
either in LE or in BE
depending on the RTL configuration selected by a implementor.
Software always expects a LE value when it will call "in_" and will
provide a LE value when "out_".
It expects beacuse , it wants to do same bit wise operation for both
configurations.



>>+
>
> Please split this patch out and get it accepterd by ARM community. USB
> people won't merge this.
>

Ok, will send it to ARM mailing list.

Regards
Pratyush

> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
