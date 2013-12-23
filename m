Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0162.hostedemail.com
 [216.40.44.162]) by ozlabs.org (Postfix) with ESMTP id 2F5532C0094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 01:57:58 +1100 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 7564F173D79
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 14:52:15 +0000 (UTC)
Message-ID: <1387810329.22671.66.camel@joe-AO722>
Subject: Re: [PATCH] ibmveth: Fix more little endian issues
From: Joe Perches <joe@perches.com>
To: Anton Blanchard <anton@samba.org>
Date: Mon, 23 Dec 2013 06:52:09 -0800
In-Reply-To: <20131223173833.0a9a6705@kryten>
References: <1387762163-39662-1-git-send-email-agraf@suse.de>
 <20131223173833.0a9a6705@kryten>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Dinar Valeev <dvaleev@suse.com>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, netdev@vger.kernel.org,
 Santiago Leon <santil@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-12-23 at 17:38 +1100, Anton Blanchard wrote:
> The hypervisor expects MAC addresses passed in registers to be big
> endian u64.

So maybe use __be64 declarations?

> +static unsigned long ibmveth_encode_mac_addr(char *mac)

static __be64 ibmveth_encode_mac_addr(const char *mac)

?

etc...
