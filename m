Return-Path: <paulus@ozlabs.org>
Date: Thu, 4 Apr 2013 15:42:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 6/11] Update CPU Maps
Message-ID: <20130404044240.GG19443@drongo>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509E04.9000709@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51509E04.9000709@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 25, 2013 at 01:57:08PM -0500, Nathan Fontenot wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> Platform events such as partition migration or the new PRRN firmware
> feature can cause the NUMA characteristics of a CPU to change, and these
> changes will be reflected in the device tree nodes for the affected
> CPUs.
> 
> This patch registers a handler for Open Firmware device tree updates
> and reconfigures the CPU and node maps whenever the associativity
> changes. Currently, this is accomplished by marking the affected CPUs in
> the cpu_associativity_changes_mask and allowing
> arch_update_cpu_topology() to retrieve the new associativity information
> using hcall_vphn().
> 
> Protecting the NUMA cpu maps from concurrent access during an update
> operation will be addressed in a subsequent patch in this series.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

[snip]

> +	if (firmware_has_feature(OV5_PRRN)) {

Shouldn't this be FW_FEATURE_PRRN?  How well has this patch been
tested? :-/

Paul.
