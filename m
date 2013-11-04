Return-Path: <paulus@ozlabs.org>
Date: Mon, 4 Nov 2013 13:28:35 +1100
From: Paul Mackerras <paulus@samba.org>
To: Tom <tommusta@gmail.com>
Subject: Re: [V2 PATCH 1/3] powerpc: Enable emulate_step In Little Endian Mode
Message-ID: <20131104022835.GA32010@drongo>
References: <1383244738-5986-1-git-send-email-tommusta@gmail.com>
 <1383244738-5986-2-git-send-email-tommusta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383244738-5986-2-git-send-email-tommusta@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 31, 2013 at 01:38:56PM -0500, Tom wrote:
> From: Tom Musta <tommusta@gmail.com>
> 
> This patch modifies the endian chicken switch in the single step

"Chicken switch" is IBM jargon, perhaps best avoided where possible in
commit messages.

> emulation code (emulate_step()).  The old (big endian) code bailed
> early if a load or store instruction was to be emulated in little
> endian mode.
> 
> The new code modifies the check and only bails in a cross-endian
> situation (LE mode in a kernel compiled for BE and vice verse).

The patch adds #ifdefs inside code, which is generally frowned upon
in kernel code as it can make the code flow harder to see.  Perhaps
you could do something like

	if ((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE))

as an alternative that wouldn't require an #ifdef.  Or, define a
symbol that is 0 in a BE kernel and MSR_LE in a LE kernel, and compare
to that.

Paul.
