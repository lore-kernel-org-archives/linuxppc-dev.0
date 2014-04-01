Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E020140090
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 00:53:05 +1100 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 1 Apr 2014 14:53:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E6BD2190046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 14:52:53 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s31DqlhN60489738
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Apr 2014 13:52:47 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s31DqwPM002861
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Apr 2014 07:52:59 -0600
Message-ID: <533AC50A.3010602@linux.vnet.ibm.com>
Date: Tue, 01 Apr 2014 15:54:18 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 15/33] powerpc: Fix ABIv2 issues with stack offsets in
 assembly code
References: <1395747879-5948-1-git-send-email-anton@samba.org>
 <1395747879-5948-16-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-16-git-send-email-anton@samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: mikey@neuling.org, amodra@gmail.com, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, paulus@samba.org, mjw@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard wrote:
> diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
> index 72ad055..01da956 100644
> --- a/arch/powerpc/lib/memcpy_64.S
> +++ b/arch/powerpc/lib/memcpy_64.S
> @@ -12,7 +12,7 @@
>  	.align	7
>  _GLOBAL(memcpy)
>  BEGIN_FTR_SECTION
> -	std	r3,48(r1)	/* save destination pointer for return value */
> +	std	r3,STK_PARAM(R3)(r1)	/* save destination pointer for return value */
>  FTR_SECTION_ELSE
>  #ifndef SELFTEST
>  	b	memcpy_power7

This chunk is rejected when applied to linux-3.14, because of the reference to SELTEST.
The last three context lines should rather read:

  FTR_SECTION_ELSE
  	b	memcpy_power7
  ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)

Same issue with [PATCH 16/33] powerpc: Fix unsafe accesses to parameter area in ELFv2.

Philippe
