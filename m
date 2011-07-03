Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 77393B6EDF
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jul 2011 18:56:53 +1000 (EST)
Message-ID: <4E102ECE.1060004@redhat.com>
Date: Sun, 03 Jul 2011 11:56:46 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
	<4E0C9077.2060608@suse.de> <4E0C9339.2080601@redhat.com>
	<4E0C94A0.3090301@suse.de> <4E0C9D98.5000904@redhat.com>
	<2EDDAC02-4BDC-4007-82E1-2C6D732C24D5@suse.de>
	<4E102516.1040805@redhat.com>
	<70A08140-B592-4B2F-985B-D8E5C78C743B@suse.de>
In-Reply-To: <70A08140-B592-4B2F-985B-D8E5C78C743B@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2011 11:34 AM, Alexander Graf wrote:
> >>
> >>  Yup, which requires knowledge in the code on what actually fits :). Logic we don't have today.
> >
> >  I don't follow.  What knowledge is required?  Please give an example.
>
> Sure. Let's take an easy example Currently we have for get_pvinfo:
>

<snip>

> The padding would not be there with your idea. An updated version could look like this:
>
>          /* for KVM_PPC_GET_PVINFO */
>          struct kvm_ppc_pvinfo {
>                  /* out */
>                  __u32 flags;
>                  __u32 hcall[4];
>                  __u64 features;  /* only there with PVINFO_FLAGS_FEATURES */
>          };
>
> Now, your idea was to not use copy_from/to_user directly, but instead some wrapper that could pad with zeros on read or truncate on write. So instead we would essentially get:
>
>          int kvm_vm_ioctl_get_pvinfo(struct kvm_ppc_pvinfo *pvinfo, int *required_size)
>          {
>                  [...]
> 		if (pvinfo_flags&  PVINFO_FLAGS_FEATURES) {
>                          *required_size = 16;
>                  } else {
>                          *required_size = 8;
>                  }
>                  [...]
>          }


Why?  Kernel code would only consider the full structure.


>          case KVM_PPC_GET_PVINFO: {
>                  struct kvm_ppc_pvinfo pvinfo;
>                  int required_size = 0;
>                  memset(&pvinfo, 0, sizeof(pvinfo));
>                  r = kvm_vm_ioctl_get_pvinfo(&pvinfo,&required_size);
>                  if (copy_to_user(argp,&pvinfo, required_size) {
>                          r = -EFAULT;
>                          goto out;
>                  }

required_size would come from the size encoded in the ioctl number, no 
need to calculate it separately.

>                  break;
>          }
>
> Otherwise we might write over data the user expected. And that logic that tells to copy_to_user how much data it actually takes to put all the information in is not there today and would have to be added. You can even verify that required_size with the ioctl passed size to make 100% sure user space is sane, but I'd claim that a feature bitmap is plenty of information to ensure that we're not doing something stupid.

I don't see why we have to caclulate something, then verify it against 
the correct answer.

-- 
error compiling committee.c: too many arguments to function
