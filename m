Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXRFb4GgWzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 15:59:31 +1100 (AEDT)
Date: Tue, 28 Feb 2017 15:59:27 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: dan.carpenter@oracle.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: Prevent double-free on HPT resize commit path
Message-ID: <20170228045927.GB25371@fergus.ozlabs.ibm.com>
References: <20170215034004.9255-1-david@gibson.dropbear.id.au>
 <20170228005655.GK17615@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170228005655.GK17615@umbus.fritz.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 28, 2017 at 11:56:55AM +1100, David Gibson wrote:
> On Wed, Feb 15, 2017 at 02:40:04PM +1100, David Gibson wrote:
> > resize_hpt_release(), called once the HPT resize of a KVM guest is
> > completed (successfully or unsuccessfully) free()s the state structure for
> > the resize.  It is currently not safe to call with a NULL pointer.
> > 
> > However, one of the error paths in kvm_vm_ioctl_resize_hpt_commit() can
> > invoke it with a NULL pointer.  This will occur if userspace improperly
> > invokes KVM_PPC_RESIZE_HPT_COMMIT without previously calling
> > KVM_PPC_RESIZE_HPT_PREPARE, or if it calls COMMIT twice without an
> > intervening PREPARE.
> > 
> > To fix this potential crash bug - and maybe others like it, make it safe
> > (and a no-op) to call resize_hpt_release() with a NULL resize pointer.
> > 
> > Found by Dan Carpenter with a static checker.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Ping,
> 
> Paul have you taken this one?

Yes, thanks, it's in Linus' tree now.

Paul.
