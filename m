Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0217.hostedemail.com
 [216.40.44.217]) by ozlabs.org (Postfix) with ESMTP id 6ECD12C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Mar 2014 03:26:48 +1100 (EST)
Message-ID: <1394296003.6972.26.camel@joe-AO722>
Subject: Re: [PATCH] eeh_pseries: Missing break?
From: Joe Perches <joe@perches.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 08 Mar 2014 08:26:43 -0800
In-Reply-To: <20140308161647.GA24296@shangw.(null)>
References: <1394238692.16156.115.camel@joe-AO722>
 <20140308161647.GA24296@shangw.(null)>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-03-09 at 00:16 +0800, Gavin Shan wrote:
> On Fri, Mar 07, 2014 at 04:31:32PM -0800, Joe Perches wrote:
> >Looks like this is unintentional as the
> >result = EEH_STATE_UNAVAILABLE is being
> >overwritten by EEH_STATE_NOT_SUPPORT in the
> >fallthrough to the default case.
> 
> Thanks, Joe. It wasn't unintentional.

Hi Gavin.

English usages of "double negatives" are different
than other languages.  "it wasn't unintentional"
means the same thing as "it was intentional".

> Could you have better commit log
> and subject, then repost it?
> 
> The format looks like:
> 
> ---
> 
> powerpc/eeh: Fix overwritten PE state
> 
> In pseries_eeh_get_state(), we always have EEH_STATE_UNAVAILABLE
> overwritten by EEH_STATE_NOT_SUPPORT because of the missed "break"
> the patch fixes the issue.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

>From my perspective, you should write up a commit
message of your own choice (I wouldn't use "we",
but the rest seems OK) and add a Reported-by:

All I did was notice it and bring it to your
attention.

> ---
> 
> With the better commit log/subject, please have:
> 
> Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> 
> >---
> >diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> >index 8a8f047..83da53f 100644
> >--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> >+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> >@@ -460,14 +460,15 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
> > 		case 5:
> > 			if (rets[2]) {
> > 				if (state) *state = rets[2];
> > 				result = EEH_STATE_UNAVAILABLE;
> > 			} else {
> > 				result = EEH_STATE_NOT_SUPPORT;
> > 			}
> >+			break;
> > 		default:
> > 			result = EEH_STATE_NOT_SUPPORT;
> > 		}
> > 	} else {
> > 		result = EEH_STATE_NOT_SUPPORT;
> > 	}
> >
> 
> Thanks,
> Gavin
> 
