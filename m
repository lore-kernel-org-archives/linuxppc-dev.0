Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kxfc6jVHzF3Ky
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 22:13:12 +1000 (AEST)
In-Reply-To: <1537878315-10783-1-git-send-email-srikar@linux.vnet.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@au1.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Harish <harisrir@linux.vnet.ibm.com>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Bringmann <mbringm@us.ibm.com>
Subject: Re: powerpc/numa: Use associativity if VPHN hcall is successful
Message-Id: <42Kxfc4WW0z9s4Z@ozlabs.org>
Date: Wed, 26 Sep 2018 22:13:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-09-25 at 12:25:15 UTC, Srikar Dronamraju wrote:
> Currently associativity is used to lookup node-id even if the preceding
> VPHN hcall failed. However this can cause CPU to be made part of the
> wrong node, (most likely to be node 0). This is because VPHN is not
> enabled on kvm guests.
> 
> With 2ea6263 ("powerpc/topology: Get topology for shared processors at
> boot"), associativity is used to set to the wrong node. Hence KVM guest
> topology is broken.
> 
> For example : A 4 node KVM guest before would have reported.
> 
> [root@localhost ~]#  numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3
> node 0 size: 1746 MB
> node 0 free: 1604 MB
> node 1 cpus: 4 5 6 7
> node 1 size: 2044 MB
> node 1 free: 1765 MB
> node 2 cpus: 8 9 10 11
> node 2 size: 2044 MB
> node 2 free: 1837 MB
> node 3 cpus: 12 13 14 15
> node 3 size: 2044 MB
> node 3 free: 1903 MB
> node distances:
> node   0   1   2   3
>   0:  10  40  40  40
>   1:  40  10  40  40
>   2:  40  40  10  40
>   3:  40  40  40  10
> 
> would now report
> 
> [root@localhost ~]# numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> node 0 size: 1746 MB
> node 0 free: 1244 MB
> node 1 cpus:
> node 1 size: 2044 MB
> node 1 free: 2032 MB
> node 2 cpus: 1
> node 2 size: 2044 MB
> node 2 free: 2028 MB
> node 3 cpus:
> node 3 size: 2044 MB
> node 3 free: 2032 MB
> node distances:
> node   0   1   2   3
>   0:  10  40  40  40
>   1:  40  10  40  40
>   2:  40  40  10  40
>   3:  40  40  40  10
> 
> Fix this by skipping associativity lookup if the VPHN hcall failed.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2483ef056f6e42f61cd266452e2841

cheers
