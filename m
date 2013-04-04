Return-Path: <paulus@ozlabs.org>
Date: Thu, 4 Apr 2013 15:46:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 7/11] Use stop machine to update cpu maps
Message-ID: <20130404044654.GH19443@drongo>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509E3C.2030008@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51509E3C.2030008@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 25, 2013 at 01:58:04PM -0500, Nathan Fontenot wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> The new PRRN firmware feature allows CPU and memory resources to be
> transparently reassigned across NUMA boundaries. When this happens, the
> kernel must update the node maps to reflect the new affinity
> information.
> 
> Although the NUMA maps can be protected by locking primitives during the
> update itself, this is insufficient to prevent concurrent accesses to these
> structures. Since cpumask_of_node() hands out a pointer to these
> structures, they can still be modified outside of the lock. Furthermore,
> tracking down each usage of these pointers and adding locks would be quite
> invasive and difficult to maintain.
> 
> Situations like these are best handled using stop_machine(). Since the NUMA
> affinity updates are exceptionally rare events, this approach has the
> benefit of not adding any overhead while accessing the NUMA maps during
> normal operation.

I notice you do one stop_machine() call for every cpu whose affinity
has changed.  Couldn't we update the affinity for them all in one
stop_machine call?  Given that stopping the whole machine can be quite
slow, wouldn't it be better to do one call rather than potentially
many?

Paul.
