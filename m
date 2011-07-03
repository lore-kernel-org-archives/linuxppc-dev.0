Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 98D52B6F00
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jul 2011 18:15:26 +1000 (EST)
Message-ID: <4E102516.1040805@redhat.com>
Date: Sun, 03 Jul 2011 11:15:18 +0300
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
In-Reply-To: <2EDDAC02-4BDC-4007-82E1-2C6D732C24D5@suse.de>
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

On 06/30/2011 07:33 PM, Alexander Graf wrote:
> On 30.06.2011, at 18:00, Avi Kivity<avi@redhat.com>  wrote:
>
> >  On 06/30/2011 06:22 PM, Alexander Graf wrote:
> >>>  Regarding that.  There's another option - the ioctl code embeds the structure size.  So if we extend the ioctl parsing to pad up (or truncate down) from the user's size to our size, and similarly in the other direction, we can get away from this ugliness.
> >>>
> >>>  Some years ago I posted a generic helper that did this (and also kmalloc'ed and kfree'd the data itself), but it wasn't received favourably.  Maybe I should try again (and we can possibly use it in kvm even if it is rejected for general use, though that's against our principles of pushing all generic infrastructure to the wider kernel).
> >>
> >>
> >>  That does sound interesting, but requires a lot more thought to be put into the actual code, as we basically need to read out the feature bitmap, then provide a minimum size for the chosen features and then decide if they fit in.
> >
> >
> >  Why? just put the things you want in the structure.
> >
> >  old userspace ->  new kernel: we auto-zero the parts userspace left out, and zero means old behaviour, so everthing works
> >  new userspace ->  old kernel: truncate.  Userspace shouldn't have used any new features (KVM_CAP), and we can -EINVAL if the truncated section contains a nonzero bit.
>
> Yup, which requires knowledge in the code on what actually fits :). Logic we don't have today.

I don't follow.  What knowledge is required?  Please give an example.

-- 
error compiling committee.c: too many arguments to function
