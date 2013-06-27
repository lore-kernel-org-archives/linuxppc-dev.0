Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8BC1D2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 19:43:25 +1000 (EST)
Message-ID: <1372326166.18612.42.camel@pasglop>
Subject: Re: [PATCH 3/8] vfio: add external user support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 27 Jun 2013 19:42:46 +1000
In-Reply-To: <20130627165929.3828c261c957845a549ad95b@canb.auug.org.au>
References: <1372309356-28320-1-git-send-email-aik@ozlabs.ru>
 <1372309356-28320-4-git-send-email-aik@ozlabs.ru>
 <20130627165929.3828c261c957845a549ad95b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-06-27 at 16:59 +1000, Stephen Rothwell wrote:
> > +/* Allows an external user (for example, KVM) to unlock an IOMMU
> group */
> > +static void vfio_group_del_external_user(struct file *filep)
> > +{
> > +     struct vfio_group *group = filep->private_data;
> > +
> > +     BUG_ON(filep->f_op != &vfio_group_fops);
> 
> We usually reserve BUG_ON for situations where there is no way to
> continue running or continuing will corrupt the running kernel.  Maybe
> WARN_ON() and return?

Not even that. This is a user space provided "fd", we shouldn't oops the
kernel because we passed a wrong argument, just return -EINVAL or
something like that (add a return code).

Ben.
