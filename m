Return-Path: <paulus@ozlabs.org>
Date: Mon, 10 Mar 2014 21:50:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] Revert "KVM: PPC: Book3S HV: Add new state for
 transactional memory"
Message-ID: <20140310105028.GA5934@iris.ozlabs.ibm.com>
References: <1394102170-22126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394102170-22126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 06, 2014 at 04:06:09PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This reverts commit 7b490411c37f7ab7965cbdfe5e3ec28eadb6db5b which cause
> the below crash in the host.

OK, I understand now what happened, which is this: when I sent out
that patch, I inadvertently included a hunk of extra code as a result
of not cleaning up a rebase properly.  The next patch in the series
removed the extraneous hunk, but Alex didn't apply the next patch.

We can either do this revert, or apply a patch removing the extra
hunk, but one or the other should go in for 3.14 since it's quite
broken as it is (that is, HV-mode KVM on powerpc is broken).

Paolo, do you have a preference about revert vs. fix?  Are you happy
to take what Aneesh sent (in which case please add my acked-by and
perhaps edit the commentary to say how the problem arose), or do you
want a freshly-prepared patch, and if so against which branch?

Thanks,
Paul.
