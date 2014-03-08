Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53F062C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Mar 2014 03:17:10 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 8 Mar 2014 09:17:07 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 316AD3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 09:17:04 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s28GGQZu786900
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Mar 2014 17:16:26 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s28GH3Wt003780
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Mar 2014 09:17:03 -0700
Date: Sun, 9 Mar 2014 00:16:48 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] eeh_pseries: Missing break?
Message-ID: <20140308161647.GA24296@shangw.(null)>
References: <1394238692.16156.115.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394238692.16156.115.camel@joe-AO722>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2014 at 04:31:32PM -0800, Joe Perches wrote:
>Looks like this is unintentional as the
>result = EEH_STATE_UNAVAILABLE is being
>overwritten by EEH_STATE_NOT_SUPPORT in the
>fallthrough to the default case.

Thanks, Joe. It wasn't unintentional. Could you have better commit log
and subject, then repost it?

The format looks like:

---

powerpc/eeh: Fix overwritten PE state

In pseries_eeh_get_state(), we always have EEH_STATE_UNAVAILABLE
overwritten by EEH_STATE_NOT_SUPPORT because of the missed "break"
the patch fixes the issue.

Signed-off-by: Joe Perches <joe@perches.com>

---

With the better commit log/subject, please have:

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

>---
>diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>index 8a8f047..83da53f 100644
>--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>@@ -460,14 +460,15 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
> 		case 5:
> 			if (rets[2]) {
> 				if (state) *state = rets[2];
> 				result = EEH_STATE_UNAVAILABLE;
> 			} else {
> 				result = EEH_STATE_NOT_SUPPORT;
> 			}
>+			break;
> 		default:
> 			result = EEH_STATE_NOT_SUPPORT;
> 		}
> 	} else {
> 		result = EEH_STATE_NOT_SUPPORT;
> 	}
>

Thanks,
Gavin
