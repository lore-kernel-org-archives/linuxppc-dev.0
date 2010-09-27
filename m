Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Mon, 27 Sep 2010 11:04:34 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] 476: Set CCR2[DSTI] to prevent isync from flushing
	shadow TLB
Message-ID: <20100927150434.GA2888@zod.rchland.ibm.com>
References: <1285351297-9999-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1285351297-9999-2-git-send-email-shaggy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285351297-9999-2-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 24, 2010 at 01:01:36PM -0500, Dave Kleikamp wrote:
>When the DSTI (Disable Shadow TLB Invalidate) bit is set in the CCR2
>register, the isync command does not flush the shadow TLB (iTLB & dTLB).
>
>However, since the shadow TLB does not contain context information, we
>want the shadow TLB flushed in situations where we are switching context.
>In those situations, we explicitly clear the DSTI bit before performing
>isync, and set it again afterward.  We also need to do the same when we
>perform isync after explicitly flushing the TLB.
>
>Th setting of the DSTI bit is dependent on
>CONFIG_PPC_47x_DISABLE_SHADOW_TLB_INVALIDATE.  When we are confident that
>the feature works as expected, the option can probably be removed.

You're defaulting it to 'y' in the Kconfig.  Technically someone could
turn it off I guess, but practice mostly shows that nobody mucks with
the defaults.  Do you want it to default 'n' for now if you aren't
confident in it just quite yet?

(Linus also has some kind of gripe with new options being default 'y',
but I don't recall all the details and I doubt he'd care about something
in low-level PPC code.)

josh
