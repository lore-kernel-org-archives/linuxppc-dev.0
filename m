Return-Path: <sam@ravnborg.org>
Received: from pqueuea.post.tele.dk (pqueuea.post.tele.dk [193.162.153.9])
	by ozlabs.org (Postfix) with ESMTP id 076D8687F4
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 06:24:08 +1100 (EST)
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 59D5E3764CB
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2005 19:54:55 +0100 (CET)
Date: Wed, 23 Nov 2005 19:55:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kumar Gala <galak@gate.crashing.org>
Message-ID: <20051123185523.GC8336@mars.ravnborg.org>
References: <Pine.LNX.4.44.0511231242510.4183-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0511231242510.4183-100000@gate.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Add support for building uImages
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 23, 2005 at 12:43:15PM -0600, Kumar Gala wrote:
> +
> +$(obj)/uImage: $(obj)/vmlinux.gz
> +	$(Q)rm -f $@
> +	$(call if_changed,uimage)
> +	@echo -n '  Image: $@ '
> +	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi

The above is suboptimal. The $(call if_changed,uimage) will execute
$(cmd_uimage) if 1) prerequisites has changed or 2) the command to execute
has changed.
In the above case 1) is always true, otherwise we would not reach the
statement. So change it to $(call cmd,uimage) is the correct way.

The 'bug' is also present in ppc/boot/images

	Sam
