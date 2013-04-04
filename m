Return-Path: <paulus@ozlabs.org>
Date: Thu, 4 Apr 2013 14:09:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/11] Expose pseries devicetree_update()
Message-ID: <20130404030905.GB19443@drongo>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509CBA.9010101@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51509CBA.9010101@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 25, 2013 at 01:51:38PM -0500, Nathan Fontenot wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> Newer firmware on Power systems can transparently reassign platform resources
> (CPU and Memory) in use. For instance, if a processor or memory unit is
> predicted to fail, the platform may transparently move the processing to an
> equivalent unused processor or the memory state to an equivalent unused
> memory unit. However, reassigning resources across NUMA boundaries may alter
> the performance of the partition. When such reassignment is necessary, the
> Platform Resource Reassignment Notification (PRRN) option provides a
> mechanism to inform the Linux kernel of changes to the NUMA affinity of
> its platform resources.
> 
> When rtasd receives a PRRN event, it needs to make a series of RTAS
> calls (ibm,update-nodes and ibm,update-properties) to retrieve the
> updated device tree information. These calls are already handled in the
> pseries_devtree_update() routine used in partition migration.
> 
> This patch simply exposes pseries_devicetree_update() so it can be
> called by rtasd. pseries_devicetree_update() and supporting functions
> are also modified to take a 32-bit 'scope' parameter. This parameter is
> required by the ibm,update-nodes/ibm,update-properties RTAS calls, and
> the appropriate value is contained within the RTAS event for PRRN
> notifications. In pseries_devicetree_update() it was previously
> hard-coded to 1, the scope value for partition migration.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
