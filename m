Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3E6DDDED9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 08:52:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18935.34966.533224.549662@cargo.ozlabs.ibm.com>
Date: Wed, 29 Apr 2009 08:52:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tim Abbott <tabbott@MIT.EDU>
Subject: Re: [PATCH v2 12/15] powerpc: Use macros for .data.page_aligned
	section.
In-Reply-To: <1240938062-3264-13-git-send-email-tabbott@mit.edu>
References: <1240938062-3264-1-git-send-email-tabbott@mit.edu>
	<1240938062-3264-2-git-send-email-tabbott@mit.edu>
	<1240938062-3264-3-git-send-email-tabbott@mit.edu>
	<1240938062-3264-4-git-send-email-tabbott@mit.edu>
	<1240938062-3264-5-git-send-email-tabbott@mit.edu>
	<1240938062-3264-6-git-send-email-tabbott@mit.edu>
	<1240938062-3264-7-git-send-email-tabbott@mit.edu>
	<1240938062-3264-8-git-send-email-tabbott@mit.edu>
	<1240938062-3264-9-git-send-email-tabbott@mit.edu>
	<1240938062-3264-10-git-send-email-tabbott@mit.edu>
	<1240938062-3264-11-git-send-email-tabbott@mit.edu>
	<1240938062-3264-12-git-send-email-tabbott@mit.edu>
	<1240938062-3264-13-git-send-email-tabbott@mit.edu>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Sam Ravnborg <sam@ravnborg.org>,
	Jeff Arnold <jbarnold@mit.edu>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waseem Daher <wdaher@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tim Abbott writes:

> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index ad06d5c..841910a 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -74,7 +74,7 @@ static int vdso_ready;
>  static union {
>  	struct vdso_data	data;
>  	u8			page[PAGE_SIZE];
> -} vdso_data_store __attribute__((__section__(".data.page_aligned")));
> +} vdso_data_store __page_aligned_data
                                        ^
Surely we need a semicolon here? -------|

Paul.
