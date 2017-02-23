Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTr1s5SjLzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:25:21 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTr1s1FJyz9rvt
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:25:20 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1NNORmm121028
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:25:18 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28t39t7bxj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:25:18 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 24 Feb 2017 09:25:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E4AA52BB0055
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:25:13 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1NNP5qY48627872
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:25:13 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1NNOfMH003921
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:24:41 +1100
Subject: Re: [PATCH 11/12] drm/ast: Fix test for VGA enabled
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: dri-devel@lists.freedesktop.org
Cc: linuxppc-dev@ozlabs.org, airlied@redhat.com, "Y . C . Chen"
 <yc_chen@aspeedtech.com>
Date: Fri, 24 Feb 2017 10:24:02 +1100
In-Reply-To: <20170223225357.9572-11-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-11-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1487892242.23576.248.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-24 at 09:53 +1100, Benjamin Herrenschmidt wrote:
> From: "Y.C. Chen" <yc_chen@aspeedtech.com>
> 
> (Get better description from Aspeed)

And this should have been:

<<
The test to see if VGA was already enabled is doing an unnecessary
second test from a register that may or may not have been initialized
to a valid value. Remove it.
>>

If you prefer you can find the whole thing (already fixed up)
at git@github.com:ozbenh/linux-ast.git

Cheers,
Ben.

> Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/gpu/drm/ast/ast_post.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_post.c
> b/drivers/gpu/drm/ast/ast_post.c
> index c15f643..a5a7809 100644
> --- a/drivers/gpu/drm/ast/ast_post.c
> +++ b/drivers/gpu/drm/ast/ast_post.c
> @@ -59,13 +59,9 @@ bool ast_is_vga_enabled(struct drm_device *dev)
>  		/* TODO 1180 */
>  	} else {
>  		ch = ast_io_read8(ast, AST_IO_VGA_ENABLE_PORT);
> -		if (ch) {
> -			ast_open_key(ast);
> -			ch = ast_get_index_reg_mask(ast,
> AST_IO_CRTC_PORT, 0xb6, 0xff);
> -			return ch & 0x04;
> -		}
> +		return !!(ch & 0x01);
>  	}
> -	return 0;
> +	return false;
>  }
>  
>  static const u8 extreginfo[] = { 0x0f, 0x04, 0x1c, 0xff };
