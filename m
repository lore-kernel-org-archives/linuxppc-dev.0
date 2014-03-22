Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143]) by ozlabs.org (Postfix) with ESMTP id 23EF32C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Mar 2014 08:41:38 +1100 (EST)
Message-ID: <1395523881.2143.58.camel@dabdike.int.hansenpartnership.com>
Subject: Re: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an
 actual Kconfig
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Laura Abbott <lauraa@codeaurora.org>
Date: Sat, 22 Mar 2014 14:31:21 -0700
In-Reply-To: <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-scsi@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 linux390@de.ibm.com, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux-ia64@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-03-22 at 11:13 -0700, Laura Abbott wrote:
> Rather than have architectures #define ARCH_HAS_SG_CHAIN in an architecture
> specific scatterlist.h, make it a proper Kconfig option and use that
> instead. At same time, remove the header files are are now mostly
> useless and just include asm-generic/scatterlist.h.

Well, the transformation looks fine.  Perhaps part of the reason for the
lack of response is that there's no compelling reason in the change log
above for doing this.  The usual reason for eliminating ARCH_HAS is that
it's hiding something that would be better expressed a different way
(that's actually intuitive to grep) or that it's expressing something
that should be configurable.  Neither of these reasons apply in this
case, because SG_CHAIN definitely is a property of the architecture not
the config space and it's not really hiding anything.

Perhaps now might be the time to ask which are the remaining
architectures that cannot do SG chaining and then we can fix them and
pull the whole thing out.

James
