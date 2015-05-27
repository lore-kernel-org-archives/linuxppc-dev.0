Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B45491A0D0B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:11:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 27 May 2015 10:41:13 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id F04D5394004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 10:41:08 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4R5B8We62586972
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 10:41:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4R4QMoV027225
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 09:56:22 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] fbuffer: improve toggle cursor performance
In-Reply-To: <20150527001113.2506.23159.stgit@bahia.huguette.org>
References: <20150527001113.2506.23159.stgit@bahia.huguette.org>
Date: Wed, 27 May 2015 10:41:06 +0530
Message-ID: <87egm2a9lh.fsf@abhimanyu.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kurz <gkurz@linux.vnet.ibm.com> writes:

> SLOF currently calls hv-logical-load and hv-logical-store for every pixel
> when enabling or disabling the cursor. This is suboptimal when writing one
> char at a time to the console since terminal-write always toggles the cursor.
> And this is precisely what grub is doing when the user wants to edit a menu
> entry... the result is an incredibly slow and barely usable interface.
>
> The inner loop in fb8-toggle-cursor handles a contiguous region: it can be
> converted to hv-logical-memop. The result is 32 times less hcalls per char
> and a serious improvement in grub usability.
>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  slof/fs/fbuffer.fs |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
> index 756f05a..46b59bf 100644
> --- a/slof/fs/fbuffer.fs
> +++ b/slof/fs/fbuffer.fs
> @@ -99,8 +99,8 @@ CREATE bitmap-buffer 400 4 * allot
>  : fb8-toggle-cursor ( -- )
>  	line# fb8-line2addr column# fb8-columns2bytes +
>  	char-height 0 ?DO
> -		char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP
> -		screen-width screen-depth * + char-width screen-depth * -
> +		dup dup 0 char-width screen-depth * 1 hv-logical-memop drop
> +		screen-width screen-depth * +

Why did you drop "char-width screen-depth * -" in the new code? This is
not me mentioned in the description.

Regards
Nikunj
