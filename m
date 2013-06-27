Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C2022C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 20:48:43 +1000 (EST)
Received: by mail-pa0-f43.google.com with SMTP id hz11so884864pad.16
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 03:48:41 -0700 (PDT)
Message-ID: <51CC1881.5060500@ozlabs.ru>
Date: Thu, 27 Jun 2013 20:48:33 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/8] vfio: add external user support
References: <1372309356-28320-1-git-send-email-aik@ozlabs.ru>
 <1372309356-28320-4-git-send-email-aik@ozlabs.ru>
 <20130627165929.3828c261c957845a549ad95b@canb.auug.org.au>
 <1372326166.18612.42.camel@pasglop>
In-Reply-To: <1372326166.18612.42.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
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

On 06/27/2013 07:42 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-06-27 at 16:59 +1000, Stephen Rothwell wrote:
>>> +/* Allows an external user (for example, KVM) to unlock an IOMMU
>> group */
>>> +static void vfio_group_del_external_user(struct file *filep)
>>> +{
>>> +     struct vfio_group *group = filep->private_data;
>>> +
>>> +     BUG_ON(filep->f_op != &vfio_group_fops);
>>
>> We usually reserve BUG_ON for situations where there is no way to
>> continue running or continuing will corrupt the running kernel.  Maybe
>> WARN_ON() and return?
> 
> Not even that. This is a user space provided "fd", we shouldn't oops the
> kernel because we passed a wrong argument, just return -EINVAL or
> something like that (add a return code).

I'll change to WARN_ON but...
This is going to be called on KVM exit on a file pointer previously
verified for correctness. If it is a wrong file*, then something went
terribly wrong.


-- 
Alexey
