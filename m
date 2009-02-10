Return-Path: <linasvepstas@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 6F02CDDDA7
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 04:14:12 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so258138yxb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 09:14:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4990EF8B.7060203@us.ibm.com>
References: <4990EF8B.7060203@us.ibm.com>
Date: Tue, 10 Feb 2009 11:14:10 -0600
Message-ID: <3ae3aa420902100914t572da49chf22b5fdda644033f@mail.gmail.com>
Subject: Re: [PATCH] Only disable/enable LSI interrupts in EEH
From: Linas Vepstas <linasvepstas@gmail.com>
To: Mike Mason <mmlnx@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com, paulus@samba.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/2/9 Mike Mason <mmlnx@us.ibm.com>:
> The EEH code disables and enables interrupts during the
> device recovery process.  This is unnecessary for MSI
> and MSI-X interrupts because they are effectively disabled
> by the DMA Stopped state when an EEH error occurs.  The current code is also
> incorrect for MSI-X interrupts.  It
> doesn't take into account that MSI-X interrupts are tracked
> in a different way than LSI/MSI interrupts.  This patch ensures only LSI
> interrupts are disabled/enabled.
>
> The patch also includes a couple minor formatting fixes.
>
>
> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>

Looks good to me.
Acked-by: Linas Vepstas <linasvepstas@gmail.com>

On a somewhat-related note: there was an issue (I forget
the details) where the kernel needed to shadow some sort
of MSI state so that it could be correctly, um, kept-track-of,
after an EEH reset (it didn't need to be restored, because
firmware did this(?)).  After some digging around and
discussion, we concluded that some generic PPC MSI
code needed to be altered to track this state, and/or
the main kernel MSI code needed to be changed to
(not?) track this state.  Mike Ellerman seemed to best
grasp this area ... was this ever fixed?

Or perhaps this is an alternate fix for that bug? It may
well have been that calling the MSI disable triggered
the problem, I don't remember now.

--linas
