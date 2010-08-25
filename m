Return-Path: <ebiederm@xmission.com>
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	by ozlabs.org (Postfix) with ESMTP id 2B4B9B70DB
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Aug 2010 13:08:36 +1000 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Anton Blanchard <anton@samba.org>
References: <20100825002258.GD28360@kryten>
Date: Tue, 24 Aug 2010 17:37:57 -0700
In-Reply-To: <20100825002258.GD28360@kryten> (Anton Blanchard's message of
	"Wed, 25 Aug 2010 10:22:58 +1000")
Message-ID: <m139u37cii.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:

> On ppc64 the crashkernel region almost always overlaps an area of firmware.
> This works fine except when using the sysfs interface to reduce the kdump
> region. If we free the firmware area we are guaranteed to crash.

That is ppc64 bug.  firmware should not be in the reserved region.  Any
random kernel like thing can be put in to that region at any valid
address and the fact that shrinking the region frees your firmware means
that using that region could also stomp your firmware (which I assume
would be a bad thing).

So please fix the ppc64 reservation.

Eric
