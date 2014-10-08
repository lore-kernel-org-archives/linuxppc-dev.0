Return-Path: <pc@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B4891A003D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 23:27:23 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Wed, 8 Oct 2014 06:27:19 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2F5616E8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 08:16:01 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s98CRGVb44957864
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 12:27:16 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s98CRGiW014586
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 08:27:16 -0400
Message-ID: <54352DA3.8090509@us.ibm.com>
Date: Wed, 08 Oct 2014 07:27:15 -0500
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: Heinz Wrobel <Heinz.Wrobel@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: mitigate impact of decrementer reset
References: <1412708517-84726-1-git-send-email-pc@us.ibm.com>
 <54343B54.4060500@us.ibm.com>
 <cf20308cc3b44935a604f409958b610d@BLUPR03MB167.namprd03.prod.outlook.com>
In-Reply-To: <cf20308cc3b44935a604f409958b610d@BLUPR03MB167.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/08/2014 12:37 AM, Heinz Wrobel wrote:
> what if your tb wraps during the  test?

Per the Power ISA, Time Base is 64 bits, monotonically increasing, and 
is writable only in hypervisor state.  To my understanding, it is set to 
zero at boot (although this is not prescribed).

Also, as noted by others, the logic is roughly duplicated (with some 
differences) from the analogous code in __timer_interrupt just above it.

I don't see wrapping as a concern.

PC
