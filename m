Return-Path: <ebiederm@xmission.com>
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	by ozlabs.org (Postfix) with ESMTP id AD8FFDDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 08:52:52 +1000 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Vivek Goyal <vgoyal@redhat.com>
References: <20080727234529.GM6175@verge.net.au>
	<20080728015117.GA12055@verge.net.au>
	<20080728024526.GB3334@verge.net.au>
	<20080728034007.GA30450@verge.net.au>
	<20080728211025.GA9985@redhat.com>
Date: Mon, 28 Jul 2008 15:47:41 -0700
In-Reply-To: <20080728211025.GA9985@redhat.com> (Vivek Goyal's message of
	"Mon, 28 Jul 2008 17:10:25 -0400")
Message-ID: <m1vdypfwxe.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH 1/5] Move elfcorehdr_addr out of vmcore.c (Was: Re:
	[patch] crashdump: fix undefined reference to `elfcorehdr_addr')
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	Paul Mundt <lethal@linux-sh.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Terry Loftin <terry.loftin@hp.com>, Simon Horman <horms@verge.net.au>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vivek Goyal <vgoyal@redhat.com> writes:

> Hi All,
>
> How does following series of patches look like. I have moved
> elfcorehdr_addr out of vmcore.c and pushed it to arch dependent section 
> of crash dump to make sure that it can be worked with even when
> CONFIG_PROC_VMCORE is disabled and CONFIG_CRASH_DUMP is enabled.
>
> I tested it on x86_64. Compile tested it on i386 and ppc64. ia64 and
> sh versions are completely untested.

Given the current state of the code:
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

To process a kernel crash dump we pass the kernel elfcorehdr option, so testing
to see if it was passed seems reasonable.

In general I think this method of handling the problems with kdump is
too brittle to live, but in the case of iommus we certainly need to do something
different, and unfortunately iommus were not common on x86 when the original code
was merged so we have not handled them well.

Eric
