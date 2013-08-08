Return-Path: <paulus@ozlabs.org>
Date: Thu, 8 Aug 2013 15:14:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 7/9] powerpc: Decode and save machine check event.
Message-ID: <20130808051422.GE12112@iris.ozlabs.ibm.com>
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093913.5389.80206.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130807093913.5389.80206.stgit@mars.in.ibm.com>
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

On Wed, Aug 07, 2013 at 03:09:13PM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Now that we handle machine check in linux, the MCE decoding should also
> take place in linux host. This info is crucial to log before we go down
> in case we can not handle the machine check errors. This patch decodes
> and populates a machine check event which contain high level meaning full
> MCE information.

A couple of things worry me about this patch:

First, there is the fact that we can only do get_mce_event() once for
a given machine check.  You call it in kvmppc_realmode_mc_power7(),
which is fine, but if it is not something we recognize and can handle
we will proceed to exit the guest and jump to machine_check_fwnmi,
which will then proceed to machine_check_common() and then
opal_machine_check(), where you have added another call to
get_mce_event(), which will probably underflow your little per-cpu
stack of machine check events.

Secondly, we shouldn't call save_mce_event() if we're not in
hypervisor mode, since per-cpu variables are not in general accessible
in real mode when running under a hypervisor with a limited real-mode
area (RMA).

Paul.
