Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A7C7AB7D47
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Jun 2010 23:12:31 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20100607203957.23695.97675.sendpatchset@squad5-lp1.lab.bos.redhat.com>
References: <20100607203957.23695.97675.sendpatchset@squad5-lp1.lab.bos.redhat.com>
To: Steve Best <sfbest@us.ibm.com>
Subject: Re: [PATCH] powerpc: Fix integer constant warning
Date: Tue, 08 Jun 2010 14:12:26 +0100
Message-ID: <9000.1276002746@redhat.com>
Sender: dhowells@redhat.com
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steve Best <sfbest@us.ibm.com> wrote:

> -#define KERNELBASE (0xc000000000000000)
> +#define KERNELBASE (0xc000000000000000ULL)

Is this the right fix?  The code producing the warning is subtracting
0xc000000000000000 from a 32-bit number:

	naca = ntohl(*((u_int32_t*) &inbuf[0x0C])) - KERNELBASE;

which seems distinctly odd.

David
