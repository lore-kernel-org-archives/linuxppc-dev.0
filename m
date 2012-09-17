Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id B97972C007D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2012 20:08:24 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 04378-07 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 17 Sep 2012 11:08:16 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [v5][PATCH 2/3] powerpc/kprobe: complete kprobe and migrate
 exception frame
Date: Mon, 17 Sep 2012 11:02:10 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6FF1@saturn3.aculab.com>
In-Reply-To: <1347875671-15838-2-git-send-email-tiejun.chen@windriver.com>
References: <1347875671-15838-1-git-send-email-tiejun.chen@windriver.com>
 <1347875671-15838-2-git-send-email-tiejun.chen@windriver.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Tiejun Chen" <tiejun.chen@windriver.com>,
	<benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>  /* N.B. the only way to get here is from the beq following =
ret_from_except. */
>  resume_kernel:
> -	/* check current_thread_info->preempt_count */
> +	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
>  	CURRENT_THREAD_INFO(r9, r1)
> +	lwz	r8,TI_FLAGS(r9)
> +	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
> +	beq+	1f
...
> +1:

Does this add a statically mispredicted branch to every
return to userspace ?
Or is there an earlier check for 'unlikely' conditions.

	David
