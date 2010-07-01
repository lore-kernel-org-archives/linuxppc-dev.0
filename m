Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 6AED8B6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 17:29:11 +1000 (EST)
Message-ID: <4C2C43C0.4000400@redhat.com>
Date: Thu, 01 Jul 2010 10:29:04 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
In-Reply-To: <1277903926-12786-1-git-send-email-agraf@suse.de>
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

On 06/30/2010 04:18 PM, Alexander Graf wrote:
> Book3s suffered from my really bad shadow MMU implementation so far. So
> I finally got around to implement a combined hash and list mechanism that
> allows for much faster lookup of mapped pages.
>
> To show that it really is faster, I tried to run simple process spawning
> code inside the guest with and without these patches:
>
> [without]
>
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello>  /dev/null; done
>
> real    0m20.235s
> user    0m10.418s
> sys     0m9.766s
>
> [with]
>
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello>  /dev/null; done
>
> real    0m14.659s
> user    0m8.967s
> sys     0m5.688s
>
> So as you can see, performance improved significantly.
>
> v2 ->  v3:
>
>    - use hlist
>    - use global slab cache
>
>    

Looks good.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
