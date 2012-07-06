Return-Path: <glommer@parallels.com>
Received: from mx2.parallels.com (mx2.parallels.com [64.131.90.16])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A2E892C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 19:07:06 +1000 (EST)
Message-ID: <4FF6AA11.2010303@parallels.com>
Date: Fri, 6 Jul 2012 13:04:17 +0400
From: Glauber Costa <glommer@parallels.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [PATCH SLAB 1/2 v3] duplicate the cache name in SLUB's saved_alias
 list, SLAB, and SLOB
References: <1341561286.24895.9.camel@ThinkPad-T420>
In-Reply-To: <1341561286.24895.9.camel@ThinkPad-T420>
Content-Type: text/plain; charset="UTF-8"
Cc: Christoph Lameter <cl@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Matt Mackall <mpm@selenic.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Wanlong Gao <gaowanlong@cn.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2012 11:54 AM, Li Zhong wrote:
> +	if (!c && lname)
> +		kfree(lname);
> +
kfree can still be validly called with a NULL argument. No need for the
lname in the conditional.
