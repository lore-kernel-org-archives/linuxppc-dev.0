Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 919D8687B1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 01:28:02 +1100 (EST)
Date: Fri, 18 Nov 2005 07:08:45 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>, Paul Mackerras <paulus@samba.org>
Message-ID: <20051118090845.GB12765@logos.cnet>
References: <437B2051.5030408@ru.mvista.com> <20051117135810.GB9753@logos.cnet>
	<437DE07E.6080005@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437DE07E.6080005@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Nov 18, 2005 at 05:09:02PM +0300, Vitaly Bordug wrote:
> Marcelo,
> Thanks for review, will fix.
> 
> Guess the proper place for setbits/clrbits should be asm-ppc/io.h?

Yes, think so.

Paul, you're OK with the following definitions on asm-ppc/io.h?

+/* access ports */
+#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) |  (_v))
+#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) |  (_v))
+#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & ~(_v))
