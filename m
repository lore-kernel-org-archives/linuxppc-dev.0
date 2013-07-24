Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id CE0A12C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 01:27:32 +1000 (EST)
Date: Wed, 24 Jul 2013 08:28:43 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Jan Stancek <jstancek@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: VPHN topology change updates all siblings
Message-ID: <20130724152843.GA16151@kroah.com>
References: <20130724150005.GB13737@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130724150005.GB13737@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 24, 2013 at 10:00:05AM -0500, Robert Jennings wrote:
> When an associativity level change is found for one thread, the
> siblings threads need to be updated as well.  This is done today
> for PRRN in stage_topology_update() but is missing for VPHN in
> update_cpu_associativity_changes_mask().
> 
> All threads should be updated to move to the new node.  Without this
> patch, a single thread may be flagged for a topology change, leaving it
> in a different node from its siblings, which is incorrect.  This causes
> problems for the scheduler where overlapping scheduler groups are created
> and a loop is formed in those groups.
> 
> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> ---
> cpu_sibling_mask is now defined for UP which fixes that build break.
> ---
>  arch/powerpc/include/asm/smp.h |  4 +++
>  arch/powerpc/mm/numa.c         | 59 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 48 insertions(+), 15 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
