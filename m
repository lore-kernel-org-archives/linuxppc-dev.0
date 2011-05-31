Return-Path: <paulus@ozlabs.org>
Date: Tue, 31 May 2011 22:35:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2 0/12] Hypervisor-mode KVM on POWER7
Message-ID: <20110531123521.GL2505@brick.ozlabs.ibm.com>
References: <20110531064028.GA2533@brick.ozlabs.ibm.com>
	<B84695B5-5DD2-4962-AADB-A0B29009FF13@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B84695B5-5DD2-4962-AADB-A0B29009FF13@suse.de>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 31, 2011 at 12:40:31PM +0200, Alexander Graf wrote:

> Thinking about the testability of this a bit more ... how much
> effort would it be to get this code running on a 970MP with SLOF?
> There should only be a few POWER7 specific pieces, right?

Do you have a 970MP that has a usable hypervisor mode, i.e. not an
Apple machine?  The 970s in Apple machines have the HV hard-wired to
1, which means they do have a hypervisor mode but it isn't any use.

If you do have such a machine, then we would have to look at some
details like the instruction sequence for the partition switch, and
make sure we don't try to use SMT4 mode.  Also, I believe we will have
to flush the TLB on partition switches, since Power processors prior
to POWER7 didn't tag the TLB entries with the partition ID.

So it should be quite feasible if you have a non-Apple machine.
I will check whether the 970MP machines that Terrasoft were
distributing would be suitable.  We have one of them in the lab.

Regards,
Paul.
