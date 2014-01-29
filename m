Return-Path: <greg@kroah.com>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B1EE12C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 08:19:38 +1100 (EST)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CC7AF20B5C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 16:13:08 -0500 (EST)
Date: Wed, 29 Jan 2014 10:45:44 -0800
From: Greg KH <greg@kroah.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] Fix compile error of pgtable-ppc64.h
Message-ID: <20140129184544.GA23204@kroah.com>
References: <1390911762-5659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390911762-5659-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390911762-5659-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 28, 2014 at 05:52:42PM +0530, Aneesh Kumar K.V wrote:
> From: Li Zhong <zhong@linux.vnet.ibm.com>
> 
> It seems that forward declaration couldn't work well with typedef, use
> struct spinlock directly to avoiding following build errors:
> 
> In file included from include/linux/spinlock.h:81,
>                  from include/linux/seqlock.h:35,
>                  from include/linux/time.h:5,
>                  from include/uapi/linux/timex.h:56,
>                  from include/linux/timex.h:56,
>                  from include/linux/sched.h:17,
>                  from arch/powerpc/kernel/asm-offsets.c:17:
> include/linux/spinlock_types.h:76: error: redefinition of typedef 'spinlock_t'
> /root/linux-next/arch/powerpc/include/asm/pgtable-ppc64.h:563: note: previous declaration of 'spinlock_t' was here
> 
> build fix for upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
> for 3.13 stable series

I don't understand, why is this needed?  Is there a corrisponding patch
upstream that already does this?  What went wrong with a "normal"
backport of the patch to 3.13?

confused,

greg k-h
