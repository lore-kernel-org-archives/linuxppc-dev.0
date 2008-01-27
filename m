Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18332.28991.658933.763115@cargo.ozlabs.ibm.com>
Date: Sun, 27 Jan 2008 22:55:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: balbir@linux.vnet.ibm.com
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
In-Reply-To: <20080126071339.GA25328@balbir.in.ibm.com>
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
	<1200634493.7806.0.camel@concordia.ozlabs.ibm.com>
	<1200635099.7806.3.camel@concordia.ozlabs.ibm.com>
	<20080126071339.GA25328@balbir.in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Balbir Singh writes:

> Here's a better and more complete fix for the problem. Could you
> please see if it works for you? I tested it on a real NUMA box and it
> seemed to work fine there.

There are a couple of other changes in behaviour that your patch
introduces, and I'd like to understand them better before taking the
patch.  First, with your patch we don't set nodes online if they end
up having no memory in them because of the memory limit, whereas
previously we did.  Secondly, in the case where we don't have NUMA
information, we now set node 0 online after adding each LMB, whereas
previously we only set it online once.

If in fact these changes are benign, then your patch description
should mention them and explain why they are benign.

Paul.
