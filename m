Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfcJC6KFtzDqtp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 19:07:23 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5T93V62115252
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 05:07:22 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09p4sq5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 05:07:21 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 03:07:21 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: robh@kernel.org, arnd@arndb.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, sjitindarsingh@gmail.com
Subject: Re: [PATCH V5 2/3] powerpc/opal: Add inline function to get rc from
 an ASYNC_COMP opal_msg
In-Reply-To: <1467171519-19882-2-git-send-email-sjitindarsingh@gmail.com>
References: <1467171519-19882-1-git-send-email-sjitindarsingh@gmail.com>
 <1467171519-19882-2-git-send-email-sjitindarsingh@gmail.com>
Date: Wed, 29 Jun 2016 19:07:09 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shvw1hz6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -276,6 +276,14 @@ extern int opal_error_code(int rc);
>  
>  ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count);
>  
> +static inline int opal_get_async_rc(struct opal_msg msg)
> +{
> +	if (msg.msg_type != OPAL_MSG_ASYNC_COMP)
> +		return OPAL_PARAMETER;

Should instead be WARN_ON or BUG_ON ? Is there *ever* a situation where
calling opal_get_async_rc on a non-OPAL_MSG_ASYNC_COMP is a not both a
dumb idea and a bug?

otherwise (including if above change is made)
Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>


-- 
Stewart Smith
OPAL Architect, IBM.
