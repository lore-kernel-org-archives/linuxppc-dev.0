Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 May 2014 10:41:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
Message-ID: <20140506004133.GA12595@iris.ozlabs.ibm.com>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <536773C2.1070502@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 05, 2014 at 01:19:30PM +0200, Alexander Graf wrote:
> On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
> >+#ifdef CONFIG_PPC_BOOK3S_64
> >+	return vcpu->arch.fault_dar;
> 
> How about PA6T and G5s?

G5 sets DAR on an alignment interrupt.

As for PA6T, I don't know for sure, but if it doesn't, ordinary
alignment interrupts wouldn't be handled properly, since the code in
arch/powerpc/kernel/align.c assumes DAR contains the address being
accessed on all PowerPC CPUs.

Did PA Semi ever publish a user manual for the PA6T, I wonder?

Paul.
