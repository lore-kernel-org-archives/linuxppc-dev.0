Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 9A8461007DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Aug 2010 18:25:08 +1000 (EST)
Message-ID: <4C5A755C.9010600@redhat.com>
Date: Thu, 05 Aug 2010 11:25:00 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 00/27] KVM PPC PV framework v3
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  On 07/29/2010 03:47 PM, Alexander Graf wrote:
> On PPC we run PR=0 (kernel mode) code in PR=1 (user mode) and don't use the
> hypervisor extensions.
>
> While that is all great to show that virtualization is possible, there are
> quite some cases where the emulation overhead of privileged instructions is
> killing performance.
>
> This patchset tackles exactly that issue. It introduces a paravirtual framework
> using which KVM and Linux share a page to exchange register state with. That
> way we don't have to switch to the hypervisor just to change a value of a
> privileged register.
>
> To prove my point, I ran the same test I did for the MMU optimizations against
> the PV framework. Here are the results:
>
> [without]
>
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello>  /dev/null; done
>
> real    0m14.659s
> user    0m8.967s
> sys     0m5.688s
>
> [with]
>
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello>  /dev/null; done
>
> real    0m7.557s
> user    0m4.121s
> sys     0m3.426s
>
>
> So this is a significant performance improvement! I'm quite happy how fast this
> whole thing becomes :)
>
> I tried to take all comments I've heard from people so far about such a PV
> framework into account. In case you told me something before that is a no-go
> and I still did it, please just tell me again.
>
> To make use of this whole thing you also need patches to qemu and openbios. I
> have them in my queue, but want to see this set upstream first before I start
> sending patches to the other projects.
>
> Now go and have fun with fast VMs on PPC! Get yourself a G5 on ebay and start
> experiencing the power yourself. - heh
>

Applied this and your follow on 7-part series, thanks.

-- 
error compiling committee.c: too many arguments to function
