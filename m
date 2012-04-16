Return-Path: <paulus@ozlabs.org>
Date: Mon, 16 Apr 2012 22:13:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 13/17] KVM: PPC: Allow book3s_hv guests to use SMT
 processor modes
Message-ID: <20120416121315.GA26814@bloggs.ozlabs.ibm.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
 <20110629102307.GN25406@bloggs.ozlabs.ibm.com>
 <056AF183-5218-457B-9501-B0FF5ED455E9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <056AF183-5218-457B-9501-B0FF5ED455E9@suse.de>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 16, 2012 at 11:45:44AM +0200, Alexander Graf wrote:

> While trying to trace down why some BookE systems were only able to
> do as many guest vcpus as there were host cpus available, we
> stumbled over this one. Is there any limitation on book3s_hv that
> would limit the available vcpus to configured host vcpus? Or could
> we just make this a static define like on x86?

There is no limitation.  I did it like that so that we would be able
to have a large number of vcpus on kernels configured for large
systems, while not using up large amounts of memory if the kernel is
configured for a small system.  The memory consumption is 8 bytes per
vcore in each struct kvm if book3s_hv is configured.

We can make it a fixed constant if you like, but then the question is
how do you choose that constant so as to allow us to have many vcpus
on large systems but still not waste too much memory on small systems.
Or it could be max(N, NR_CPUS) for a suitable N (e.g. 16 or 32).

Paul.
