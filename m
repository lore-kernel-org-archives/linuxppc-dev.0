Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B5F09B6F6B
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Nov 2011 04:01:31 +1100 (EST)
Message-ID: <4ECA83E1.6090902@freescale.com>
Date: Mon, 21 Nov 2011 11:01:21 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
 <20111118082929.5ee8d4f07d84f2bf65e18006@canb.auug.org.au>
 <4EC5860D.5000606@freescale.com>
 <20111119120455.8435467a8c11a2a122321670@canb.auug.org.au>
In-Reply-To: <20111119120455.8435467a8c11a2a122321670@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:

> exit_lcs1_iounmap:
> 	iounmap(lbc_lcs1_ba);
> exit_lcs0_iounmap:
> 	iounmap(lbc_lcs0_ba);
> exit_indirect_node:
> 	of_node_put(indirect_node);
> exit_guts_iounmap:
> 	iounmap(guts);

The point I'm trying to make is that I don't want to have multiple goto exit labels.  If I have to rearrange the code or add/delete code, then I probably would need to make similar changes to these labels.  I just don't like that sort of thing.  

I appreciate your taking the time to review my code and provide suggestions.  However, considering that I'm modifying my own code, I would hope that you can appreciate my personal coding style preference.  And my style is to reduce the number of labels, even if it means superfluous checks in the exit code.

So Kumar, if there are no further objections, please apply this patch as-is.  Thank you.

-- 
Timur Tabi
Linux kernel developer at Freescale
