Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 43A7C2C00AD
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 23:33:52 +1000 (EST)
Message-ID: <1375968782.12551.47.camel@pasglop>
Subject: Re: [RFC PATCH 2/9] powerpc: handle machine check in Linux host.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 23:33:02 +1000
In-Reply-To: <52039AEC.8010006@linux.vnet.ibm.com>
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093815.5389.7668.stgit@mars.in.ibm.com>
 <20130808045143.GC12112@iris.ozlabs.ibm.com>
 <52039AEC.8010006@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-08 at 18:49 +0530, Mahesh Jagannath Salgaonkar wrote:
> But, I think I should depend on
> evt->disposition==MCE_DISPOSITION_RECOVERED and not play with MSR_RI
> and
> SRR1. I will fix my code.

If MSR:RI is 0, then you have clobbered SRR0/SRR1 beyond repair and
probably cannot recover.

Ben.
