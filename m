Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0k4n4qtHzDvZQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 22:30:32 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pan Xinhui' <xinhui.pan@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "xen-devel-request@lists.xenproject.org"
 <xen-devel-request@lists.xenproject.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
CC: "kernellwp@gmail.com" <kernellwp@gmail.com>, "jgross@suse.com"
 <jgross@suse.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "mingo@redhat.com" <mingo@redhat.com>, "paulus@samba.org" <paulus@samba.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "paulmck@linux.vnet.ibm.com"
 <paulmck@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Subject: RE: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu
 preempted check
Date: Fri, 21 Oct 2016 11:27:55 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pan Xinhui
> Sent: 20 October 2016 22:28
> Commit ("x86, kvm: support vcpu preempted check") add one field "__u8
> preempted" into struct kvm_steal_time. This field tells if one vcpu is
> running or not.
>=20
> It is zero if 1) some old KVM deos not support this filed. 2) the vcpu is
> preempted. Other values means the vcpu has been preempted.
>=20
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  Documentation/virtual/kvm/msr.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/virtual/kvm/msr.txt b/Documentation/virtual/kv=
m/msr.txt
> index 2a71c8f..3376f13 100644
> --- a/Documentation/virtual/kvm/msr.txt
> +++ b/Documentation/virtual/kvm/msr.txt
> @@ -208,7 +208,8 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
>  		__u64 steal;
>  		__u32 version;
>  		__u32 flags;
> -		__u32 pad[12];
> +		__u8  preempted;
> +		__u32 pad[11];
>  	}

I think I'd be explicit about the 3 pad bytes you've left.

	David
