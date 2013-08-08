Return-Path: <paulus@ozlabs.org>
Date: Thu, 8 Aug 2013 14:58:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 5/9] powerpc: Flush SLB/TLBs if we get SLB/TLB
 machine check errors on power7.
Message-ID: <20130808045815.GD12112@iris.ozlabs.ibm.com>
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093855.5389.21377.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130807093855.5389.21377.stgit@mars.in.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 07, 2013 at 03:08:55PM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> If we get a machine check exception due to SLB or TLB errors, then flush
> SLBs/TLBs and reload SLBs to recover. We do this in real mode before turning
> on MMU. Otherwise we would run into nested machine checks.
> 
> If we get a machine check when we are in guest, then just flush the
> SLBs and continue. This patch handles errors for power7. The next
> patch will handle errors for power8

I don't see anywhere in this patch or the next where we check whether
we are in fact running in hypervisor mode.  It is possible for us to
get machine check interrupts to the 0x200 vector when running under a
hypervisor, for example if the hypervisor doesn't support the FWNMI
facility (e.g. KVM) or if it does but we haven't done the
ibm,nmi-register call yet.

If we're not in hypervisor mode we should probably not do any of this
new stuff, but just handle it like we always have.

Paul.
