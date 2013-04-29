Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-da0-x22f.google.com (mail-da0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B3672C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 00:07:02 +1000 (EST)
Received: by mail-da0-f47.google.com with SMTP id p1so2933877dad.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 07:06:57 -0700 (PDT)
Date: Mon, 29 Apr 2013 07:06:55 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Fix missing doorbell IPIs during nap power saving
Message-ID: <20130429140655.GA18950@kroah.com>
References: <1367223460-4931-1-git-send-email-imunsie@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367223460-4931-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 29, 2013 at 06:17:40PM +1000, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> If a doorbell IPI comes in while a thread is in nap power saving, the
> doorbell interrupt won't be replayed by the hardware since it is edge
> sensitive. Currently we are not replaying these interrupts in software,
> which can cause threads to miss IPIs that come in during power saving
> and eventually will result in an RCU warning from rcu_sched that it has
> detected a stalled CPU.
> 
> This patch fixes the issue by testing if a doorbell caused the thread to
> come out of power saving and sets the corresponding bit in the paca to
> indicate a doorbell happened, which will then be handled by the existing
> interrupt replay code.
> 
> This is not an issue with other interrupts that can wake a thread
> (external, decrementer) as they are level sensitive and will continue to
> be asserted by the hardware.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
