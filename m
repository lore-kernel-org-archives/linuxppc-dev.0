Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDRgl2dmbzDrD7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 12:24:03 +1100 (AEDT)
Date: Sat, 14 Oct 2017 12:23:37 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Greg Kurz <groug@kaod.org>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
Message-ID: <20171014012337.GB26120@fergus.ozlabs.ibm.com>
References: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 11:56:25PM +0200, Greg Kurz wrote:
> The following program causes a kernel oops:
> 
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <linux/kvm.h>
> 
> main()
> {
>     int fd = open("/dev/kvm", O_RDWR);
>     ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_PPC_HTM);
> }
> 
> This happens because when using the global KVM fd with
> KVM_CHECK_EXTENSION, kvm_vm_ioctl_check_extension() gets
> called with a NULL kvm argument, which gets dereferenced
> in is_kvmppc_hv_enabled(). Spotted while reading the code.
> 
> Let's use the hv_enabled fallback variable, like everywhere
> else in this function.
> 
> Fixes: 23528bb21ee2 ("KVM: PPC: Introduce KVM_CAP_PPC_HTM")
> Cc: stable@vger.kernel.org # v4.7+
> Signed-off-by: Greg Kurz <groug@kaod.org>

Thanks, applied to my kvm-ppc-fixes branch.

Paul.
