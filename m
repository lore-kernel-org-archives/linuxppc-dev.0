Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA5A1B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 08:12:36 +1000 (EST)
Date: Tue, 14 Sep 2010 15:12:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH v2 03/10] RapidIO: Use stored ingress port number
	instead of register read
Message-Id: <20100914151219.5d92c6f9.akpm@linux-foundation.org>
In-Reply-To: <1284476363-1677-4-git-send-email-alexandre.bounine@idt.com>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com>
	<1284476363-1677-4-git-send-email-alexandre.bounine@idt.com>
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

On Tue, 14 Sep 2010 10:59:16 -0400
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> @@ -219,6 +219,7 @@ struct rio_net {
>  /**
>   * struct rio_switch - RIO switch info
>   * @node: Node in global list of switches
> + * @rdev: Associated RIO device structure
>   * @switchid: Switch ID that is unique across a network
>   * @hopcount: Hopcount to this switch
>   * @destid: Associated destid in the path
> @@ -234,6 +235,7 @@ struct rio_net {
>   */
>  struct rio_switch {
>  	struct list_head node;
> +	struct rio_dev *rdev;
>  	u16 switchid;
>  	u16 hopcount;
>  	u16 destid;

What is the locking for rdev?  In other patches I see pointer chases
with no obvious locking against concurrent changes?
