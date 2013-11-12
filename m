Return-Path: <paulus@ozlabs.org>
Date: Wed, 13 Nov 2013 08:03:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc: book3s: PR: Enable Little Endian PR guest
Message-ID: <20131112210329.GA4319@iris.ozlabs.ibm.com>
References: <1384178898-24673-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <059527B7-DB8B-4A91-AE3B-3ACA834EEFA4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <059527B7-DB8B-4A91-AE3B-3ACA834EEFA4@suse.de>
Cc: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 12, 2013 at 07:37:24AM -0500, Alexander Graf wrote:
> 
> 
> Am 11.11.2013 um 09:08 schrieb "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>:
> 
> > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > 
> > This patch make sure we inherit the LE bit correctly in different case
> > so that we can run Little Endian distro in PR mode
> > 
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> This is not how real hardware works, is it? Could you please point me to the bits in the ISA that indicate that we should preserve the LE bit anywhere? :)

No, it isn't.  What we should really be doing depends a bit on what
CPU we're emulating.  Older CPUs had an ILE bit in the MSR that got
copied to LE on interrupt.  Recent POWER CPUs moved the ILE bit to the
LPCR, so for them we should have an emulated LPCR (and implement
H_SET_MODE for pseries guests so they can control LPCR[ILE]).
Embedded CPUs of course don't have an LE bit, or an ILE bit, since
they control endianness on a per-page basis.

Paul.
