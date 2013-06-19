Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
In-Reply-To: <1371522772.22681.140.camel@ul30vt.home>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-4-git-send-email-aik@ozlabs.ru>
 <1371422343.21896.143.camel@pasglop> <1371438800.22681.38.camel@ul30vt.home>
 <1371441361.21896.152.camel@pasglop> <1371522772.22681.140.camel@ul30vt.home>
Date: Wed, 19 Jun 2013 13:05:43 +0930
Message-ID: <87txkun568.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alex Williamson <alex.williamson@redhat.com> writes:
> On Mon, 2013-06-17 at 13:56 +1000, Benjamin Herrenschmidt wrote:
>> On Sun, 2013-06-16 at 21:13 -0600, Alex Williamson wrote:
>> 
>> > IOMMU groups themselves don't provide security, they're accessed by
>> > interfaces like VFIO, which provide the security.  Given a brief look, I
>> > agree, this looks like a possible backdoor.  The typical VFIO way to
>> > handle this would be to pass a VFIO file descriptor here to prove that
>> > the process has access to the IOMMU group.  This is how /dev/vfio/vfio
>> > gains the ability to setup an IOMMU domain an do mappings with the
>> > SET_CONTAINER ioctl using a group fd.  Thanks,
>> 
>> How do you envision that in the kernel ? IE. I'm in KVM code, gets that
>> vfio fd, what do I do with it ?
>> 
>> Basically, KVM needs to know that the user is allowed to use that iommu
>> group. I don't think we want KVM however to call into VFIO directly
>> right ?
>
> Right, we don't want to create dependencies across modules.  I don't
> have a vision for how this should work.  This is effectively a complete
> side-band to vfio, so we're really just dealing in the iommu group
> space.  Maybe there needs to be some kind of registration of ownership
> for the group using some kind of token.  It would need to include some
> kind of notification when that ownership ends.  That might also be a
> convenient tag to toggle driver probing off for devices in the group.
> Other ideas?  Thanks,

It's actually not that bad.

eg. 

struct vfio_container *vfio_container_from_file(struct file *filp)
{
        if (filp->f_op != &vfio_device_fops)
                return ERR_PTR(-EINVAL);

        /* OK it really is a vfio fd, return the data. */
        ....
}
EXPORT_SYMBOL_GPL(vfio_container_from_file);

...

inside KVM_CREATE_SPAPR_TCE_IOMMU:

        struct file *vfio_filp;
        struct vfio_container *(lookup)(struct file *filp);

        vfio_filp = fget(create_tce_iommu.fd);
        if (!vfio)
                ret = -EBADF;
        lookup = symbol_get(vfio_container_from_file);
        if (!lookup)
                ret = -EINVAL;
        else {
                container = lookup(vfio_filp);
                if (IS_ERR(container))
                        ret = PTR_ERR(container);
                else
                        ...
                symbol_put(vfio_container_from_file);
        }

symbol_get() won't try to load a module; it'll just fail.  This is what
you want, since they must have vfio in the kernel to get a valid fd...

Hope that helps,
Rusty.
                
