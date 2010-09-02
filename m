Return-Path: <macro@linux-mips.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [78.24.191.182])
	by ozlabs.org (Postfix) with ESMTP id 179A1B7197
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 01:26:45 +1000 (EST)
Received: from localhost.localdomain ([127.0.0.1]:49015 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1491020Ab0IBPUe (ORCPT
	<rfc822;linuxppc-dev@lists.ozlabs.org>);
	Thu, 2 Sep 2010 17:20:34 +0200
Date: Thu, 2 Sep 2010 16:20:34 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: ERR_PTR pattern in phylib
In-Reply-To: <AANLkTimjVZTNeLdm4qptU1MqREODLASdGGanUyxqxfub@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1009021617500.410@eddie.linux-mips.org>
References: <AANLkTimjVZTNeLdm4qptU1MqREODLASdGGanUyxqxfub@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev <netdev@vger.kernel.org>, Andy Fleming <afleming@freescale.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Sep 2010, Grant Likely wrote:

> I've been looking at the phylib code, and specifically at the use of
> the ERR_PTR() pattern.  I'm personally not a big fan of ERR_PTR()
> because the compiler cannot type check the result and it runs
> completely counter to the pattern "if (!ptr)" than is common for
> testing a pointer return value.

 Arguably using a union here would make things cleaner and any reasonable 
ABI will place small unions used as arguments or return values in 
registers, but I'm not sure if the cost of the rewrite is worth the 
benefit.  Probably not, but feel free to propose a change.

  Maciej
