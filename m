Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8582F1A06F8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 09:39:15 +1100 (AEDT)
Date: Tue, 31 Mar 2015 15:39:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 1/2] kernel/reboot.c: Add orderly_reboot for graceful
 reboot
Message-Id: <20150331153912.267c0b1af94b5f4964d791de@linux-foundation.org>
In-Reply-To: <1427681733-25488-1-git-send-email-joel@jms.id.au>
References: <1427681733-25488-1-git-send-email-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, fabf@skynet.be,
 jk@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 30 Mar 2015 12:45:32 +1030 Joel Stanley <joel@jms.id.au> wrote:

> The kernel has orderly_poweroff which allows the kernel to initiate a
> graceful shutdown of userspace, by running /sbin/poweroff. This adds
> orderly_reboot that will cause userspace to shut itself down by calling
> /sbin/reboot.
> 
> This will be used for shutdown initiated by a system controller on
> platforms that do not use ACPI.

gee.  There are a lot of callers of emergency_restart().  Why is the
BMC reboot special, and how many of the emergency_restart() callers
really be using orderly_reboot()?

We have /proc/sys/kernel/poweroff_cmd.  Should we have
/proc/sys/kernel/reboot_cmd as well?  If not,
kernel/reboot.c:reboot_cmd[] can be made static ;) 
