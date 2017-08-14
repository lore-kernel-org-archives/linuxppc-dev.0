Return-Path: <srs0=xyon=7q=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWVYJ53JHzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 08:25:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xWVYJ4RQSz8vN7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 08:25:24 +1000 (AEST)
Message-ID: <1502749503.4493.34.camel@kernel.crashing.org>
Subject: Re: [PATCH v6 14/17] powerpc: Add support for setting SPRN_TIDR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: mikey@neuling.org, stewart@linux.vnet.ibm.com, apopple@au1.ibm.com,
 hbabu@us.ibm.com, oohall@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 15 Aug 2017 08:25:03 +1000
In-Reply-To: <20170814200309.GD24096@us.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
 <87pobyqtzu.fsf@concordia.ellerman.id.au>
 <20170814200309.GD24096@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-14 at 13:03 -0700, Sukadev Bhattiprolu wrote:
> As Ben pointed out, we are going to be have limit the number of TIDs (to
> be within the size limits), so we won't be able to use task_pid_nr()? But
> if we assign the TIDs in the RX_WIN_OPEN ioctl, then only the FTW processes
> will need the TIDR value.

But you'll have to assign it for all present and future threads of that
process which is somewhat hard to do without races.

> Can we then assign new, globally-unique TID values for now and have the ioctl
> fail with -EAGAIN if all TIDs are in use? We can extend to per-process TID
> values, later?

Why would you want to do that ?

Ben.
