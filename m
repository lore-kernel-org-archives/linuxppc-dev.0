Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0047.hostedemail.com
 [216.40.44.47]) by ozlabs.org (Postfix) with ESMTP id D30DE2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 11:31:37 +1100 (EST)
Message-ID: <1394238692.16156.115.camel@joe-AO722>
Subject: [PATCH] eeh_pseries: Missing break?
From: Joe Perches <joe@perches.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Fri, 07 Mar 2014 16:31:32 -0800
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

Looks like this is unintentional as the
result = EEH_STATE_UNAVAILABLE is being
overwritten by EEH_STATE_NOT_SUPPORT in the
fallthrough to the default case.
---
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 8a8f047..83da53f 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -460,14 +460,15 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
 		case 5:
 			if (rets[2]) {
 				if (state) *state = rets[2];
 				result = EEH_STATE_UNAVAILABLE;
 			} else {
 				result = EEH_STATE_NOT_SUPPORT;
 			}
+			break;
 		default:
 			result = EEH_STATE_NOT_SUPPORT;
 		}
 	} else {
 		result = EEH_STATE_NOT_SUPPORT;
 	}
 
