Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 339EC140110
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 22:55:38 +1000 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Mon, 5 May 2014 13:55:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 28961219004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 13:55:23 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s45CtVbm61734956
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 12:55:31 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s45CtU0j015921
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 06:55:31 -0600
Message-ID: <53678A66.4040506@linux.vnet.ibm.com>
Date: Mon, 05 May 2014 14:56:06 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: memcpy optimization for 64bit LE
References: <20140430091054.4de84c9b@kryten>
In-Reply-To: <20140430091054.4de84c9b@kryten>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard wrote:
> Unaligned stores take alignment exceptions on POWER7 running in little-endian.
> This is a dumb little-endian base memcpy that prevents unaligned stores.
> Once booted the feature fixup code switches over to the VMX copy loops
> (which are already endian safe).
> 
> The question is what we do before that switch over. The base 64bit
> memcpy takes alignment exceptions on POWER7 so we can't use it as is.
> Fixing the causes of alignment exception would slow it down, because
> we'd need to ensure all loads and stores are aligned either through
> rotate tricks or bytewise loads and stores. Either would be bad for
> all other 64bit platforms.
> 
> [ I simplified the loop a bit - Anton ]
Got it.

The 3 instructions that you have removed were modifying r5 for no reason,
as the last instruction was always resetting r5 to its initial value.

Philippe
