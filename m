Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8CD41A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 16:03:43 +1100 (AEDT)
Date: Tue, 31 Mar 2015 22:03:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] kernel/reboot.c: Add orderly_reboot for graceful
 reboot
Message-Id: <20150331220326.994661ba.akpm@linux-foundation.org>
In-Reply-To: <551B7978.8040502@linux.vnet.ibm.com>
References: <1427681733-25488-1-git-send-email-joel@jms.id.au>
 <551B7978.8040502@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, fabf@skynet.be,
 jk@ozlabs.org, linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 01 Apr 2015 10:22:08 +0530 Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> >  char poweroff_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/poweroff";
> > +char reboot_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/reboot";
> 
> Should not we declare one more REBOOT_CMD_PATH_LEN to make it cleaner.

It doesn't really seem necessary - they'll have the same value anyway.

But if you aren't going to implement the sysctl it isn't needed at all -
just do

static char reboot_cmd[] = "/sbin/reboot";
