Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS7Px3y7zzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 15:51:49 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id a123so13362933pgc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:51:49 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 21 Feb 2017 15:51:42 +1100
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 03/10] powerpc/mm/hash: Move kernel context to the
 starting of context range
Message-ID: <20170221045142.GC21059@balbir.ozlabs.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487498837-12017-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487498837-12017-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 19, 2017 at 03:37:10PM +0530, Aneesh Kumar K.V wrote:
> With current kernel, we use the top 4 context for the kernel. Kernel VSIDs are built
> using these top context values and effective segemnt ID. In the following patches,
> we want to increase the max effective address to 512TB. We achieve that by
> increasing the effective segments IDs there by increasing virtual address range.
> 
> We will be switching to a 68bit virtual address in the following patch. But for
> platforms like  p4 and p5, which only support a 65 bit va, we want to limit the
> virtual addrress to a 65 bit value. We do that by limiting the context bits to 16
> instead of 19. That means we will have different max context values on different
> platforms.
> 
> To make this simpler. we move the kernel context to the starting of the range.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
