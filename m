Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 02AD42C009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 20:50:26 +1100 (EST)
Message-ID: <1386755416.15730.12.camel@pasglop>
Subject: Re: [PATCH 1/3] powerpc: mm: make _PAGE_NUMA take effect
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu ping fan <kernelfans@gmail.com>
Date: Wed, 11 Dec 2013 20:50:16 +1100
In-Reply-To: <CAFgQCTtd1v+ANEy899_Tk2UmYsAL1Lxe8t6WuMxFvjXk5rtn_Q@mail.gmail.com>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1386140348-7854-2-git-send-email-pingfank@linux.vnet.ibm.com>
 <87a9gfva9n.fsf@linux.vnet.ibm.com>
 <CAFgQCTtd1v+ANEy899_Tk2UmYsAL1Lxe8t6WuMxFvjXk5rtn_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-12-11 at 16:50 +0800, Liu ping fan wrote:
> > why ? , All the hash routines do check for _PAGE_PRESENT via access
> > variable.
> >
> Going through __hash_page_4K(4k on 4k HW), I do not find such check.
> Am I wrong? Or I will send out a patch to fix that.

We pass a bitmask of flags to check which are tested by doing an "andc"
of the PTE on that mask and checking if anything is left...

Ben.
