Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 29FFEB6F70
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2011 21:38:00 +1000 (EST)
Message-ID: <4E11A611.3010904@redhat.com>
Date: Mon, 04 Jul 2011 14:37:53 +0300
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
	<4E102ECE.1060004@redhat.com>
	<CBE84140-B1FC-48B6-A000-77CB58C5F928@suse.de>
	<4E1030E1.6070101@redhat.com>
	<77E6DEE3-F00A-46EA-B8AF-58BC62A8143D@suse.de>
	<4E103270.4040506@redhat.com>
	<40F62A22-6A47-4414-8FF9-0534568353DA@suse.de>
	<4E11A293.2010505@redhat.com>
	<BC4ECEFA-15A4-49A9-AE53-9635F3F6F996@suse.de>
In-Reply-To: <BC4ECEFA-15A4-49A9-AE53-9635F3F6F996@suse.de>
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

On 07/04/2011 02:36 PM, Alexander Graf wrote:
> >
> >  What intermediate steps?  We can't add fields to the structure before we get the extensibility infrastructure, but that's all.
>
> If we add it now without extensibility code, we will have a kernel that only knows the ioctl with the size as it is now. If we later add another field, the ioctl size changes which would render new user space running on that particular kernel to fail, because it doesn't have the "just truncate the ioctl param to the size" logic yet.

You're right.  So let's add the padding now, and only use the great new 
stuff after it's actually in.

Working ugly is better than broken pretty.

-- 
error compiling committee.c: too many arguments to function
