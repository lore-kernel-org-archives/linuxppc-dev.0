Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk5pb4rl5zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 20:27:03 +1000 (AEST)
Date: Mon, 11 Apr 2016 13:26:08 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: geoff@infradead.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: Inconsistent use of size argument in kzalloc and memcpy in
 'drivers/net/ethernet/toshiba/ps3_gelic_wireless.c'
Message-ID: <20160411102608.GC4298@mwanda>
References: <570B75A4.5070904@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570B75A4.5070904@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 11, 2016 at 12:00:04PM +0200, Christophe JAILLET wrote:
> Hi,
> 
> while looking at potential clean-up, I ended on the following code
> which looks spurious to me.
> 
> We allocate 'be16_to_cpu(scan_info->size)' bytes, but then copy
> 'scan_info->size'.
> This is not consistent.
> 

Good catch.  be16_to_cpu(scan_info->size) is correct.  It's surprising
that this bug wasn't caught in testing...

regards,
dan carpenter
