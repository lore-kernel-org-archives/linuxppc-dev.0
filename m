Return-Path: <robert.richter@amd.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42AC3B6FAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 19:29:00 +1000 (EST)
Date: Tue, 24 May 2011 11:27:47 +0200
From: Robert Richter <robert.richter@amd.com>
To: Eric B Munson <emunson@mgebm.net>
Subject: Re: [PATCH] oprofile, powerpc: Handle events that raise an exception
	without overflowing
Message-ID: <20110524092747.GS20052@erda.amd.com>
References: <1306160560-5309-1-git-send-email-emunson@mgebm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1306160560-5309-1-git-send-email-emunson@mgebm.net>
Cc: "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>,
	"paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23.05.11 10:22:40, Eric B Munson wrote:
> Commit 0837e3242c73566fc1c0196b4ec61779c25ffc93 fixes a situation on POWER7
> where events can roll back if a specualtive event doesn't actually complete.
> This can raise a performance monitor exception.  We need to catch this to ensure
> that we reset the PMC.  In all cases the PMC will be less than 256 cycles from
> overflow.
> 
> This patch lifts Anton's fix for the problem in perf and applies it to oprofile
> as well.
> 
> Signed-off-by: Eric B Munson <emunson@mgebm.net>
> Cc: <stable@kernel.org> # as far back as it applies cleanly
> ---
>  arch/powerpc/oprofile/op_model_power4.c |   24 +++++++++++++++++++++++-
>  1 files changed, 23 insertions(+), 1 deletions(-)

I applied the fix to oprofile/urgent.

Thanks Eric,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
