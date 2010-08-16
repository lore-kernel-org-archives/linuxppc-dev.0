Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 79769B6F0E
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 22:18:40 +1000 (EST)
Message-ID: <4C692C9D.6040100@neli.hopto.org>
Date: Mon, 16 Aug 2010 14:18:37 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH 4/9] RapidIO: Add relation links between RIO device
	structures
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-5-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1281712686-31308-5-git-send-email-alexandre.bounine@idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> Create back and forward links between RIO devices. These links are intended for
> use by error management and hot-plug extensions.

As RapidIO is a switched network, the concept of 'previous' and 'next' 
devices is invalid. Perhaps it's just the way they were 
discovered/enumerated, but that does not matter any more at runtime. Or 
at least, should not matter.

> @@ -237,6 +241,7 @@ struct rio_switch {
>  	u16 hopcount;
>  	u16 destid;
>  	u8  inport;
> +	u8  nports;
>  	u8 *route_table;
>  	u32 port_ok;

This can be extracted from the swpinfo field (which you removed in 
another patch)?

Micha
