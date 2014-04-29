Return-Path: <glikely@secretlab.ca>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF3291400B5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 00:00:59 +1000 (EST)
Received: by mail-ee0-f45.google.com with SMTP id d17so373071eek.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 07:00:54 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 00/21] FDT clean-ups and libfdt support
To: Rob Herring <robherring2@gmail.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Date: Tue, 29 Apr 2014 15:00:48 +0100
Message-Id: <20140429140048.7C9D0C40992@trevor.secretlab.ca>
Cc: linux-mips@linux-mips.org, Aurelien Jacquiot <a-jacquiot@ti.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linux@lists.openrisc.net,
 Jonas Bonn <jonas@southpole.se>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mark Salter <msalter@redhat.com>, linux-xtensa@linux-xtensa.org,
 James Hogan <james.hogan@imgtec.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Vineet Gupta <vgupta@synopsys.com>, Ralf Baechle <ralf@linux-mips.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 Apr 2014 20:18:00 -0500, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This is a series of clean-ups of architecture FDT code and converts the
> core FDT code over to using libfdt functions. This is in preparation
> to add FDT based address translation parsing functions for early
> console support. This series removes direct access to FDT data from all
> arches except powerpc.
> 
> The current MIPS lantiq and xlp DT code is buggy as built-in DTBs need
> to be copied out of init section. Patches 2 and 3 should be applied to
> 3.15.
> 
> Changes in v2 are relatively minor. There was a bug in the unflattening
> code where walking up the tree was not being handled correctly (thanks
> to Michal Simek). I re-worked things a bit to avoid globally adding
> libfdt include paths.
> 
> A branch is available here[1], and I plan to put into linux-next in a few
> days. Please test! I've compiled on arm, arm64, mips, microblaze, xtensa,
> and powerpc and booted on arm and arm64.

This is pretty great work. I'll read through them again and I may have a
comment or two, but in general you can add my tested by tag:

Tested-by: Grant Likely <grant.likely@linaro.org>

>  40 files changed, 280 insertions(+), 598 deletions(-)

I love the diffstat!

g.
