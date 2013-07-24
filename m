Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C82B42C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 14:46:32 +1000 (EST)
Message-ID: <1374641175.3916.111.camel@pasglop>
Subject: Re: [PATCH] powerpc: VPHN topology change updates all siblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Date: Wed, 24 Jul 2013 14:46:15 +1000
In-Reply-To: <20130723123344.GA11611@linux.vnet.ibm.com>
References: <20130723123344.GA11611@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: stable@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Jan Stancek <jstancek@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-23 at 07:33 -0500, Robert Jennings wrote:
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
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> Cc: <stable@vger.kernel.org>

Patch breaks the UP build ...

Cheers,
Ben.
