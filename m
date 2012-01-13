Return-Path: <pku.leo@gmail.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D6BEB6F13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 20:36:58 +1100 (EST)
Received: by eekb45 with SMTP id b45so232916eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 01:36:52 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1326443147-26645-1-git-send-email-qiang.liu@freescale.com>
References: <1326443147-26645-1-git-send-email-qiang.liu@freescale.com>
Date: Fri, 13 Jan 2012 17:36:52 +0800
Message-ID: <CADRPPNQsVB-2jR0UaX6RB_4PCf9kt4UXvAXnxaVk=LsBcwGowg@mail.gmail.com>
Subject: Re: [PATCH][SDK v1.2] sata: I/O load balancing
From: Li Yang <leoli@freescale.com>
To: Qiang Liu <qiang.liu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jgarzik@pobox.com,
 linux-kernel@vger.kernel.org, Qiang Liu <b32616@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 13, 2012 at 4:25 PM, Qiang Liu <qiang.liu@freescale.com> wrote:
> From: Qiang Liu <b32616@freescale.com>
>
> Reduce interrupt singnals through reset Interrupt Coalescing Control Reg.
> Increase the threshold value of interrupt and timer will reduce the number
> of complete interrupt sharply. Improve the system performance effectively.

There is always a trade off of throughput and latency by using
interrupt coalescing.  It's not reasonable to assume that the
throughput is the only factor to be considered and set the coalescing
threshold and timeout to the max value by default.  Have you carried
out other benchmark like copying many small files?

It will be safer to make the coalescing runtime configurable like the
sata_mv driver, IMO.

- Leo
