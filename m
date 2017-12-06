Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysZ0D2TRzzDsCS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 10:03:07 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: ppc32: semctl fails
References: <1512581010.8313.153.camel__41464.7176782184$1512581316$gmane$org@infinera.com>
Date: Wed, 06 Dec 2017 23:56:06 +0100
In-Reply-To: <1512581010.8313.153.camel__41464.7176782184$1512581316$gmane$org@infinera.com>
 (Joakim Tjernlund's message of "Wed, 6 Dec 2017 17:23:33 +0000")
Message-ID: <87lgif31q1.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Dez 06 2017, Joakim Tjernlund <Joakim.Tjernlund@infinera.com> wrote:

>     st = semctl(sem, 0, IPC_STAT, &arg);

This is not a valid use of IPC_STAT.  The fourth argument must be a
object of type union semun (not a pointer), with the .buf member
pointing to the struct semid_ds object.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
