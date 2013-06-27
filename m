Return-Path: <suzuki@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2079C2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 16:36:43 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 27 Jun 2013 00:36:40 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 59A2C1FF001C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 00:31:21 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R6ab4w384086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 00:36:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R6aaB8028191
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 00:36:37 -0600
Message-ID: <51CBDD71.6030408@in.ibm.com>
Date: Thu, 27 Jun 2013 12:06:33 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] powerpc: don't flush/invalidate the d/icache for an
 unknown relocation type
References: <1372295383-19740-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372295383-19740-1-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2013 06:39 AM, Kevin Hao wrote:
> For an unknown relocation type since the value of r4 is just the 8bit
> relocation type, the sum of r4 and r7 may yield an invalid memory
> address. For example:
>      In normal case:
>               r4 = c00xxxxx
>               r7 = 40000000
>               r4 + r7 = 000xxxxx
>
>      For an unknown relocation type:
>               r4 = 000000xx
>               r7 = 40000000
>               r4 + r7 = 400000xx
>     400000xx is an invalid memory address for a board which has just
>     512M memory.
>
> And for operations such as dcbst or icbi may cause bus error for an
> invalid memory address on some platforms and then cause the board
> reset. So we should skip the flush/invalidate the d/icache for
> an unknown relocation type.
>

Good catch. Thanks for the fix.

Acked-by: Suzuki K. Poulose <suzuki@in.ibm.com>
