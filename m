Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3DDD9B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 08:21:33 +1000 (EST)
Date: Tue, 14 Sep 2010 15:20:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH v2 09/10] RapidIO: Add support for IDT CPS Gen2 switches
Message-Id: <20100914152049.8d42783f.akpm@linux-foundation.org>
In-Reply-To: <1284476363-1677-10-git-send-email-alexandre.bounine@idt.com>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com>
	<1284476363-1677-10-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Sep 2010 10:59:22 -0400
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> +static int
> +idtg2_route_add_entry(struct rio_mport *mport, u16 destid, u8 hopcount,
> +		       u16 table, u16 route_destid, u8 route_port)
> +{
> +	/*
> +	 * Select routing table to update
> +	 */
> +	if (table == RIO_GLOBAL_TABLE)
> +		table = 0;
> +	else
> +		table++;
> +
> +	rio_mport_write_config_32(mport, destid, hopcount,
> +				  LOCAL_RTE_CONF_DESTID_SEL, table);
> +
> +	/*
> +	 * Program destination port for the specified destID
> +	 */
> +	rio_mport_write_config_32(mport, destid, hopcount,
> +				  RIO_STD_RTE_CONF_DESTID_SEL_CSR,
> +				  (u32)route_destid);
> +
> +	rio_mport_write_config_32(mport, destid, hopcount,
> +				  RIO_STD_RTE_CONF_PORT_SEL_CSR,
> +				  (u32)route_port);
> +	udelay(10);
> +
> +	return 0;
> +}

The handling of `table' is strange.  One would expect the caller of
this function to provide the correct table index, and for the caller to
increment that index at an appropriate time.

So I take a look around but cannot find any means by which
->add_entry() is called with anything other than RIO_GLOBAL_TABLE. 
Maybe I missed something.  Is this all dead code?
