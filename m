Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 994E3B6F0E
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 22:37:01 +1000 (EST)
Message-ID: <4C6930EA.8030406@neli.hopto.org>
Date: Mon, 16 Aug 2010 14:36:58 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH 9/9] RapidIO: Add support for IDT CPS Gen2 switches
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-10-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1281712686-31308-10-git-send-email-alexandre.bounine@idt.com>
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
> +	rio_mport_write_config_32(mport, destid, hopcount,
> +				  LOCAL_RTE_CONF_DESTID_SEL, table);
> +
> +	for (i = 0x80000000; i <= 0x800000ff;) {
> +		rio_mport_write_config_32(mport, destid, hopcount,
> +			RIO_STD_RTE_CONF_DESTID_SEL_CSR, i);

The 0x80000000 is that an autoincrement bit? If so, it only needs to do 
this once I think? If so please call it like that, and loop the 'i' 
variable through the destination IDs.

Micha
