Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id CB06A2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 04:57:25 +1100 (EST)
Message-ID: <529783FF.7040505@suse.de>
Date: Thu, 28 Nov 2013 18:57:19 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2] powerpc: book3s: PR: Enable Little Endian PR guest
References: <1385654018-18232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1385654018-18232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/28/2013 04:53 PM, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> This patch make sure we inherit the LE bit correctly in different case
> so that we can run Little Endian distro in PR mode

IMHO H_SET_MODE should be handled in user space for most cases. We 
probably want an interface similar to the RTAS hypercall where user 
space can then tell the kernel to handle individual sub-commands inside 
the kernel after all for performance counters and other performance 
critical operations.

But the normal mode of operation should be to bounce this into user 
space and have that one set LPCR then.


Alex
