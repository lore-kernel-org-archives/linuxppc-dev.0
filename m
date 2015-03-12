Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-la0-x233.google.com (mail-la0-x233.google.com
 [IPv6:2a00:1450:4010:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B2B71A0394
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 10:09:26 +1100 (AEDT)
Received: by lams18 with SMTP id s18so19232790lam.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 16:09:21 -0700 (PDT)
Received: from morgan.rasmusvillemoes.dk (ip-21-165.bnaa.dk. [84.238.21.165])
 by mx.google.com with ESMTPSA id k3sm47607lah.40.2015.03.12.16.09.20
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Thu, 12 Mar 2015 16:09:20 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: linuxppc-dev@lists.ozlabs.org
Subject: new decimal conversion - seeking testers
Date: Fri, 13 Mar 2015 00:09:19 +0100
Message-ID: <87fv99x17k.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've proposed a new implementation of decimal conversion for
lib/vsprintf.c; see
<http://thread.gmane.org/gmane.linux.kernel/1892035/focus=1905478>.
Benchmarking so far shows 25-50% (depending on distribution of input
numbers) improvement on x86_64 and 10-30% on various 32 bit platforms.

Since the new code plays a little endianness game I would really
appreciate it if someone here would run the test and verification code
on ppc.

The code is on github, https://github.com/Villemoes/dec, and it should
be as simple as

   git clone https://github.com/Villemoes/dec.git
   cd dec
   make
   ./test   # benchmark
   ./verify # correctness

though I can't blame you if you want to inspect the code before
compiling and running something some stranger asks you to download :-)
See also the README file.

If 'make' doesn't work out-of-the-box, I'd also like to hear from you.

Thanks,
Rasmus
