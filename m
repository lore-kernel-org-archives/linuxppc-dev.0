Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A503BC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 14:54:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D364F20674
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 14:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D364F20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dr144ztpzDqLk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 00:54:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.179.66; helo=19.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 19.mo4.mail-out.ovh.net (19.mo4.mail-out.ovh.net [87.98.179.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dqym2VnQzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 00:52:44 +1000 (AEST)
Received: from player795.ha.ovh.net (unknown [10.109.146.173])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id DB5CB1E08D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 16:13:03 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 63177485F25E;
 Tue,  9 Apr 2019 14:12:54 +0000 (UTC)
Subject: Re: [PATCH v4 16/17] KVM: introduce a KVM_DESTROY_DEVICE ioctl
To: kvm-ppc@vger.kernel.org
References: <20190320083751.27001-1-clg@kaod.org>
 <20190320083751.27001-17-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ee87fc98-42bb-cd5b-4934-6ada074874a3@kaod.org>
Date: Tue, 9 Apr 2019 16:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190320083751.27001-17-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12136919523503737806
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/20/19 9:37 AM, Cédric Le Goater wrote:
> The 'destroy' method is currently used to destroy all devices when the
> VM is destroyed after the vCPUs have been freed.
> 
> This new KVM ioctl exposes the same KVM device method. It acts as a
> software reset of the VM to 'destroy' selected devices when necessary
> and perform the required cleanups on the vCPUs. Called with the
> kvm->lock.
> 
> The 'destroy' method could be improved by returning an error code.

I am working on a new approach for the interrupt device switching 
that I will send as a replacement of patch 16 and 17.  This is for 
discussion and a v5 will be needed at the end.

C.  

 


> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> 
>  Changes since v3 :
> 
>  - Removed temporary TODO comment in kvm_ioctl_destroy_device()
>    regarding kvm_put_kvm()
>  
>  Changes since v2 :
> 
>  - checked that device is owned by VM
>  
>  include/uapi/linux/kvm.h          |  7 ++++++
>  virt/kvm/kvm_main.c               | 41 +++++++++++++++++++++++++++++++
>  Documentation/virtual/kvm/api.txt | 20 +++++++++++++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 52bf74a1616e..d78fafa54274 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1183,6 +1183,11 @@ struct kvm_create_device {
>  	__u32	flags;	/* in: KVM_CREATE_DEVICE_xxx */
>  };
>  
> +struct kvm_destroy_device {
> +	__u32	fd;	/* in: device handle */
> +	__u32	flags;	/* in: unused */
> +};
> +
>  struct kvm_device_attr {
>  	__u32	flags;		/* no flags currently defined */
>  	__u32	group;		/* device-defined */
> @@ -1331,6 +1336,8 @@ struct kvm_s390_ucas_mapping {
>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
>  
> +#define KVM_DESTROY_DEVICE	  _IOWR(KVMIO,  0xf0, struct kvm_destroy_device)
> +
>  /*
>   * ioctls for vcpu fds
>   */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5e2fa5c7dd1a..9601c2ddecc5 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3032,6 +3032,33 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
>  	return 0;
>  }
>  
> +static int kvm_ioctl_destroy_device(struct kvm *kvm,
> +				    struct kvm_destroy_device *dd)
> +{
> +	struct fd f;
> +	struct kvm_device *dev;
> +
> +	f = fdget(dd->fd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	dev = kvm_device_from_filp(f.file);
> +	fdput(f);
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	if (dev->kvm != kvm)
> +		return -EPERM;
> +
> +	mutex_lock(&kvm->lock);
> +	list_del(&dev->vm_node);
> +	dev->ops->destroy(dev);
> +	mutex_unlock(&kvm->lock);
> +
> +	return 0;
> +}
> +
>  static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>  {
>  	switch (arg) {
> @@ -3276,6 +3303,20 @@ static long kvm_vm_ioctl(struct file *filp,
>  		r = 0;
>  		break;
>  	}
> +	case KVM_DESTROY_DEVICE: {
> +		struct kvm_destroy_device dd;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&dd, argp, sizeof(dd)))
> +			goto out;
> +
> +		r = kvm_ioctl_destroy_device(kvm, &dd);
> +		if (r)
> +			goto out;
> +
> +		r = 0;
> +		break;
> +	}
>  	case KVM_CHECK_EXTENSION:
>  		r = kvm_vm_ioctl_check_extension_generic(kvm, arg);
>  		break;
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 8022ecce2c47..abe8433adf4f 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3874,6 +3874,26 @@ number of valid entries in the 'entries' array, which is then filled.
>  'index' and 'flags' fields in 'struct kvm_cpuid_entry2' are currently reserved,
>  userspace should not expect to get any particular value there.
>  
> +4.119 KVM_DESTROY_DEVICE
> +
> +Capability: KVM_CAP_DEVICE_CTRL
> +Type: vm ioctl
> +Parameters: struct kvm_destroy_device (in)
> +Returns: 0 on success, -1 on error
> +Errors:
> +  ENODEV: The device type is unknown or unsupported
> +  EPERM: The device does not belong to the VM
> +
> +  Other error conditions may be defined by individual device types or
> +  have their standard meanings.
> +
> +Destroys an emulated device in the kernel.
> +
> +struct kvm_destroy_device {
> +	__u32	fd;	/* in: device handle */
> +	__u32	flags;	/* unused */
> +};
> +
>  5. The kvm_run structure
>  ------------------------
>  
> 

